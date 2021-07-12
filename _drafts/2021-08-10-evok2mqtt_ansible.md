---
title: "evok2mqtt ansible"
subtitle: "Automating an evok2mqtt install"
cover-img:
  - "/assets/2021-08-10/automation_robot.jpg": "Photo by Alex Knight on Unsplash"
readtime: true
tags:
  - home automation
  - evok2mqtt
  - tech
  - mqtt
---

As part of my [home automation series], I did write about a small interfacing library that I did write, called [evok2mqtt].

The purpose of this service is to translate between two different protocols: websockets, as exposed by [evok] and [mqtt], which is the primary protocol I did use in communicating with [home assistant].
If you'd like to get more details about the setup itself, check the blog post series first.

The focus of this post is the **automated provisioning of a unipi unit using [ansible]**.

# Rationale

Earlier, I did discuss all of the software running on each of my [unipi] units, each responsible for a layer in the overall process:

- the linux-based OS: for capturing and sending I/O events
- evok: for exposing this I/O information in various formats and protocols (of which I did use websockets)
- evok2mqtt: for translating between websockets and mqtt

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
- infrastructure as code like [terraform]

**Scripting** is the oldest and most widespread approaches to automation.
In scripting, you define a list of commands that each run in sequence after each other, generally from the top of the script to the bottom.
Scripting is _procedural_, meaning you define _how_ a specific action is to be carried out, like a recipe.
The advantage of scripting is that it is simple and ubiquitous.
On the other side of the equation are all issues related to state manipulation.
As a script runs through its sequence of steps, it changes the state to end up in a desired target state.
In theory, you can write your scripts in such a way that they can adapt for any kind of initial or in-between state.
Also, you could attempt to write some parts of your scripts in an _idempotent_ way, meaning that they perform the same action regardless of their input.
At larger scales however, scripting quickly becomes unwieldy of this state manipulation it needs to take into account and idempotency is simply not always possible.

**Declarative** tools take a different approach, not by defining _how_ the provisioning should take place, but rather _what_ the end-result needs to be.
Particularly in the case of provisioning, this makes for an interesting programming paradigm since ideally after running the provisioning tool, it will always result in the same end state, regardless of any initial state the node was in.

**Immutable build** tools also operate in this fashion, the difference being that the provisioning process itself consists of picking a pre-built image (VM or container image) and deploying that entirely.
Doing updates in this fashion just means killing the entire image and replacing it with another one.

**Infrastructure as code** augments this approach by extending it to any kind of resource.
Cloud providers make all of their virtualised infrastructure components available via APIs.
Infrastructure as code provides a common code-based framework to declaratively define your desired cloud architecture.

All of these have their place, but for now, I did focus on using [ansible] as a declarative provisioning tool:

- scripting is too much of a pain, considering the state manipulation issues mentioned before
- immutable build tools seem really interesting, but might not fit my use case where I would manually need to swap out built images[^1]
- infrastructure as code: this does not apply here, since I want to run the tooling on the unipi unit itself[^2]
- I recently did learn about ansible and also a good use case to apply it

# `evok2mqtt-ansible`

# Closing thoughts

[^1]: in the cloud server world, this is off course an entirely different situation.
[^2]: a platform that could mimic infrastructure-as-code for local development would be really cool, though!

[home automation series]: {% post_url 2021-06-15-home_automation_why %}
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
