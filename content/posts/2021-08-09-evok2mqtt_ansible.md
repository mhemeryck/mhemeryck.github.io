+++
title = "evok2mqtt ansible"
subtitle = "Automating an evok2mqtt install"
date = "2021-08-09"
tags = ["home automation", "evok2mqtt", "tech", "mqtt", "ansible"]
+++

As part of my [home automation series], I did write about a small interfacing library that I did write, called [evok2mqtt].

The purpose of this service is to translate between two different protocols: websockets, as exposed by [evok] and [mqtt], which is the primary protocol I did use in communicating with [home assistant].
If you'd like to get more details about the setup itself, check the blog post series first.

The focus of this post is the **automated provisioning of a unipi unit using [ansible]**.

# Rationale

Earlier, I did discuss all of the software running on each of my [unipi] units, where each part is responsible for a layer in the overall process:

- the linux-based OS: for capturing and sending I/O events
- `evok`: for exposing this I/O information in various formats and protocols (of which I did use websockets)
- `evok2mqtt`: for translating between websockets and MQTT

Arguably, it would be better to have fewer of these layers, but the current situation is one of **many different moving parts**.

Next to that, I do have **multiple of these unipi nodes**, each interfacing different types of I/O, yet fundamentally they share a common setup.

Occasionally, there is a need to **update or reprovision** the unipi nodes, e.g. in the case of regular software or in the unlucky event that and SD-card crashed.

Considering all of these factors, having a way to automatically provision the unipi units in a predefined state is very helpful to have.

# Automated provisioning

Automated provisioning refers to tooling that can handle the tedious tasks related to setting up a client or server automatically.
Many different kinds of tooling can be used, e.g.:

- scripting like [bash]:
- declarative-style recipes like [ansible] and [puppet]
- immutable builds like [packer] or [docker]
- infrastructure-as-code like [terraform]

**Scripting** is one of the oldest and most widespread approaches to automation.
In scripting, you define a list of commands that each run in sequence after each other, generally from the top of the script to the bottom.
Scripting is _procedural_, meaning you define _how_ a specific action is to be carried out, like a recipe.
The advantage of scripting is that it is simple and ubiquitous.
On the other side of the equation are all issues related to state manipulation.
As a script runs through its sequence of steps, it changes the state to end up in a desired target state.
In theory, you can write your scripts in such a way that they can adapt for any kind of initial or in-between state.
Also, you could attempt to write some parts of your scripts in an _idempotent_ way, meaning that they perform the same action regardless of their input.
At larger scale however, scripting quickly becomes unwieldy of this state manipulation it needs to take into account and idempotency is simply not always possible.

**Declarative** tools take a different approach, not by defining _how_ the provisioning should take place, but rather _what_ the end-result needs to be.
Particularly in the case of provisioning, this makes for an interesting programming paradigm since ideally after running the provisioning tool, it will always result in the same end state, regardless of any initial state the node was in.

**Immutable build** tools also operate in this fashion, the difference being that the provisioning process itself consists of picking a pre-built image (virtual machine image or container image) and deploying that entirely.
Doing updates in this fashion just means killing the entire image and replacing it with another one.

**Infrastructure as code** augments this approach by extending it to any kind of resource.
Cloud providers make all of their virtualised infrastructure components available via APIs.
Infrastructure as code provides a common code-based framework to declaratively define your desired cloud architecture.

All of these have their place, but for now, I did focus on using [ansible] as a declarative provisioning tool:

- scripting is too much of a pain, considering the state manipulation issues mentioned before
- immutable build tools seem really interesting, but might not fit my use case where I would manually need to swap out built images[^1]
- infrastructure as code: this does not apply here, since I want to run the tooling on the unipi unit itself[^2]
- I recently did learn about ansible and also a good use case to apply it

Some basic _ansible-lingo_ before we dive into the details:

- `ansible` is the tool you run on your local machine to perform actions on a remote system
- an action on a remote machine is a _task_
- a set of tasks can be combined into a _role_
- a set of roles can be further combined into a _playbook_
- ... further higher levels of grouping also still exist (collections?), but I didn't give that much extra thought
- `ansible-playbook` is the tool to orchestrate the execution of a playbook

For my purposes, I did write a _playbook_.

# Initial setup

Ansible has some basic initial conditions for it to be run on the target host:

- the target host needs to be reachable via SSH (ideally key-based)
- the target host should run some version of python (as ansible itself is based on python)
- depending on the permissions you need to execute, the connecting user needs to have root access

Fortunately, unipi does provides such an image that already satisfies these constraints (most modern linux-based OS images would do, actually): the [Neuron OpenSource OS].

Practical next steps include:

1. flash the SD card for the unipi with this image
1. ensure an internet connection, preferably wired, although a [headless raspberry pi wifi install] would also work

From here on, you can start running the playbook!

# Running `evok2mqtt-ansible`

The playbook can be found on github [evok2mqtt-ansible].

From the README file:

The first step is to clone the repository:

    git clone https://github.com/mhemeryck/evok2mqtt-ansible.git

Next, we need some extra requirements which can be installed using `ansible-galaxy` (a tool to pull in other people's playbooks).

    ansible-galaxy install -r requirements.yaml

Adapt the `hosts.yaml` file for your own purposes.

Run the playbook with

    ansible-playbook site.yaml -i hosts.yaml

# A closer look

Taking a step back; what does this playbook actually do?
Let's check the folder structure:

    .
    ├── hosts.yaml
    ├── LICENSE.txt
    ├── README.md
    ├── requirements.yaml
    ├── roles
    │   ├── account
    │   │   └── tasks
    │   │       └── main.yaml
    │   ├── evok2mqtt
    │   │   ├── handlers
    │   │   │   └── main.yaml
    │   │   ├── tasks
    │   │   │   └── main.yaml
    │   │   └── templates
    │   │       └── evok2mqtt.service.j2
    │   ├── hostname
    │   │   ├── tasks
    │   │   │   └── main.yaml
    │   │   └── vars
    │   │       └── hostnames.yaml
    │   ├── security
    │   │   ├── handlers
    │   │   │   └── main.yaml
    │   │   └── tasks
    │   │       └── main.yaml
    │   └── wifi
    │       ├── handlers
    │       │   └── main.yaml
    │       ├── tasks
    │       │   └── main.yaml
    │       └── templates
    │           └── wpa_supplicant.conf.j2
    └── site.yaml

The playbook consists of:

- a `site.yaml` file which is the main entry point which invokes the different roles
- a `hosts.yaml` file which lists the groups of target hosts to run the commands against (you would definitely need to adapt this to your needs)
- a `requirements.yaml` file which defines external roles and plugins to be used
- 5 different folders, each related to a specific role; a set of tasks that are available for execution

Discussing each of the roles themselves might be a bit too much (you can just was well read the source for that), but I want to discuss the main `site.yaml` file which brings all of the roles together:

```yaml
---
- hosts: testpi
  vars:
    ansible_python_interpreter: /usr/bin/python3 # Force py3
    ansible_ssh_password: unipi.technology # not really a secret
    ansible_ssh_user: unipi
    mqtt_host: shuttle.lan
    username: mhemeryck
    wifi_ssd: luctor_IoT
    wifi_passphrase: "{{ lookup('community.general.passwordstore', 'home/luctor') }}"
  roles:
    - account
    - hostname
    - wifi
    - evok2mqtt
- hosts: testpi
  vars:
    ansible_python_interpreter: /usr/bin/python3 # Force py3
    username: mhemeryck
  roles:
    - security
```

The main file defines **two sets of roles**, referring to the different roles that are made available.
The first set is the biggest one, the second one can only run after the first has completed.
The reason for this split is that when the initial image is made available, it does include a default `unipi` user with a fixed password.
The first set of roles will run as this user (as this is the only user available at that time).
Afterwards, we can run a second security-related role as a newly available hardened user and then remove that `unipi` user -- you obviously can't remove the `unipi` user while you are executing tasks with it.
You can see that the first set of roles does include the `ansible_ssh_user` and `ansible_ssh_password`: these refer to those standard credentials.

In terms of **credentials**, I did include those ssh user / password as variables in plain text, as this publicly available knowledge.
For the `wifi_passphrase` however, I did use my password manager [`pass`] and the related ansible [`pass` plugin]!

A quick look at the **different roles**:

- `account`: this provisions my own user with proper root access and copies in my public SSH keys from github
- `hostname`: this role changes the host name to a sensible one. The mapping for the host name is determined from a variables file[^3].
- `wifi`: this sets up `wpa_supplicant` with proper WIFI credentials for my home network.
- `evok2mqtt`: the main job; it will do a full system upgrade, install `evok`, install `evok2mqt`, create a system unit file and make sure it runs as a daemon
- `security`: some cleanup tasks, like disabling password-based SSH logins (key-based only) and removing the default `unipi` user.

After running these tasks, the unipi unit should in theory be in my ideal end state!

# Closing thoughts

Given the central place my unipi units play in my home automations setup, **having any failures on them is, however rare, not fun**.
With this in mind and also a general interest in learning infrastructure automation, I did set out to automate those tasks with ansible.

The current **downside** of this approach is that the full system upgrade will mean that the unipi is occupied for a large portion of time.
Consequently, I haven't yet set out to use it on my live environment.
However, any breaking failures on my unipi units could now be quickly mitigated by flashing an SD-card and running this playbook against, which is a huge improvement over the previous situation.

Alternative **future solutions** could consist of changing the software required to run on the unipi units (would simplify the install process) and / or fully immutable (packer) builds, which completely prepare the image upfront.

[^1]: in the cloud server world, this is of course an entirely different situation.
[^2]: a platform that could mimic infrastructure-as-code for local development would be really cool, though!
[^3]: I did not include my own file, since this could contain sensitive information ...

[home automation series]: {{< ref "2021-06-15-home_automation_why" >}}
[evok2mqtt]: https://github.com/mhemeryck/evok2mqtt
[evok]: https://github.com/UniPiTechnology/evok
[mqtt]: https://mqtt.org/
[home assistant]: https://www.home-assistant.io/integrations/mqtt/
[ansible]: https://www.ansible.com/
[unipi]: https://www.unipi.technology/
[bash]: https://www.gnu.org/software/bash/
[puppet]: https://puppet.com/
[packer]: https://www.packer.io/
[docker]: https://www.docker.com/
[terraform]: https://www.terraform.io/
[Neuron OpenSource OS]: https://kb.unipi.technology/en:files:software:os-images:00-start#neuron_opensource_os
[headless raspberry pi wifi install]: https://www.raspberrypi.com/documentation/computers/configuration.html#connect-to-a-wireless-network
[evok2mqtt-ansible]: https://github.com/mhemeryck/evok2mqtt-ansible
[`pass`]: https://www.passwordstore.org/
[`pass` plugin]: https://docs.ansible.com/ansible/latest/collections/community/general/passwordstore_lookup.html
