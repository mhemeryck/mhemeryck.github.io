---
title: "Service"
subtitle: "Home assistant as the service layer"
cover-img:
  - "/assets/home_assistant_logo.svg": "home assistant logo"
readtime: true
tags:
  - home automation
  - mqtt
  - tech
  - home assistant
---

Up to this point, I did already lay out all of the tidbits concerning the electricity, the I/O hardware units, even some custom software to provide an event-based API to reach address all of the various components in the overall system.
The final fundamental piece to bring everything together is what I call the _service_ layer, and specifically [home assistant].

This post is a part of a larger series of posts on my home automation setup.
See the [home automation overview post], to learn about the rationale and a description of the other posts!

# Architecture

To recap, have a look at this drawing from the earlier [home automation architecture post].

![architecture]

In summary:

- a central MQTT broker: this component takes in _events_ on a _topic_ from the various _publishers_ and forwards them to any of the _subscribers_ for that topic
- all the unipi units: can take in any MQTT event to handle as _commands_ and pushes out events as _state_ updates.
- home assistant: has logic to trigger specific events on other events incoming

Note that for a pub / sub system, all of the clients can (and will) function as both publisher and subscriber.

# home assistant

I already did mention home assistant, but what is it really?

Home assistant is an open source software platform that was created with the vision of being able to integrate all sorts of IoT solutions.

It is bundled with a huge amount of _integrations_ for various different vendors; check out the [home assistant integrations] page for an overview.
The way the platform is structured is via a number of [entities], e.g. a generic switch, light, etc ...
Each integration can then implement such entities.
The home assistant community would typically encourage new contributors to put the interfacing logic (e.g. an API client) in its own, open source library, to be called from the custom integration.
The added value of this approach is twofold:

1. the community rapidly gets more of these open source libraries
1. the home assistant installation only needs to pull in the source libraries it needs, instead of being a big code base

The advantage of rolling your own platform is that you are more in control of your own hardware, less reliant on cloud solutions.

Though not required, I did find it interesting to learn about more about the way it was setup, check the [home assistant architecture dev docs].

The integration I have been mostly using is [home assistant MQTT integration].
At this point, this means that all of the I/O that is provided by the unipi units via an MQTT interface can now be readily represented as entities directly in home assistant!

# Scenario

Let's make it more tangible by presenting the scenario from the [home automation architecture post] again, where a push button triggers a light.

![flow]

In terms of the home assistant MQTT integration, the notion of _command_ and _state_ topics are quite relevant:

- command topic: this is a specific MQTT topic, e.g. `/{device}/{io}/set` which accepts and incoming command to update the I/O. This scenario is typically coming from home assistant to the IO module.
- state topic: this topic is specific for reporting state updates back to any listeners, e.g. `/{device}/{io}/state`. This is for the opposite scenario where the IO module itself updates its state back again to home assistant.

With this pair of topics for each entity, a typical flow combining command and state topics means:

1. home assistant requesting a state update on the command topic of the IO module
1. the IO module updates its value (e.g. toggles a relay for a light)
1. the IO module sends out an update on the corresponding state topic
1. home assistant then updates its matching entity according to the state topic

In relation to the flow diagram above:

1. on the push of the button, an MQTT event is pushed out to the _state_ topic
1. the MQTT broker pushes the state update home assistant
1. home assistant updates the matching [home assistant MQTT switch] entity
1. home assistant triggers an _automation_ which connects a state update for the push button entity to a match light entity
1. to update the light entity, an event is published on that [home assistant MQTT light] entity
1. the MQTT borker pushed the command to the subscribed I/O module
1. the I/O module takes in the command to update its state and toggles the light accordingly
1. after that the I/O module triggers the relay, it pushes back an update on its state topic
1. the MQTT broker forwards the state update again to home assistant
1. home assistant sees the state update for that light entity and updates its internal state

# Containers and services

Home assistant has multiple ways of installing and running the platform, see the [home assistant installation] page.

First of all, you should be aware that the overall platform consists of multiple layers and the meaning of each of those has changed over time.
I would refer to the following diagram from the [home assistant architecture dev docs].

![home assistant layers img]

- core: at the center, there's the main home assistant software.
- supervisor: this component manages the core software, but it also has the capability to run other services besides home assistant, yet integrating them in a single UI
- operating system: the way I understand this, this is a minimal linux-based OS just to be able to run the supervisor for you. The idea is that at this level, you can just download a disk image, flash an SD-card and fire it up in a raspberry pi.

The core itself is actually a _containerized_ version of the main home assistant software, which in turn is a python application.
Check out the [home assistant core docker container] on docker hub.
The rationale behind containerization is that you specify an image that contains an isolated environment for your application to run in.
Containers are different from _virtual machines_ in that multiple containers would share the same underlying OS kernel, which is better in terms of performance.

Containerization has become dominant in current-day software development and infrastructure management; I use it on a daily basis.
A lot can be said on the topic of containerization and IT infrastructure, but I would like to keep this out of the discussion here.
If you would be considering gaining more knowledge on this, before anything, understand that containers are there to support a particular model of software development, i.e. _service-based_ development.
This typically means _stateless_, _web-based_, _services_.

Apart from the container itself, you typically need something like a _supervisor_ or _container orchestrator_ to run the containers.
The orchestrator is responsible for e.g. starting the containers, making sure the correct amount of containers are running at the same time (redundancy, scaling), moving containers between hosts (in a multi-node setup), resource allocation, external networking, ...

As mentioned, home assistant has its own orchestrator; the supervisor.
An orchestrator I often use for quick-and-dirty local development is [docker-compose].
The current de-facto standard is the google-backed [kubernetes], abbreviated to k8s.
The lightweight version of this is [k3s].

All of these have their own merits and disadvantages:

| orchestrator              | pros                                                    | cons                                                                                                   |
| ------------------------- | ------------------------------------------------------- | ------------------------------------------------------------------------------------------------------ |
| home assistant supervisor | built-in the eco-system of home assistant               | container orchestration is _hard_ to do right, why roll your own?                                      |
|                           | allows extra functionality in the same UI               | to me, this indicates a bad design, where a supervisor is responsible for more than what it's intended |
|                           | supposedly more suited for embedded platforms (raspi 3) | low-memory footprint k8s alternatives exist, like the k3s mentioned before.                            |
| docker-compose            | simple syntax                                           | only supports a subset of features                                                                     |
|                           | easy to get up an running                               |                                                                                                        |
| k8s                       | the de-facto standard                                   | standard for web-based services and IT infrastructure management, might be overkill for IoT            |
|                           | a lot of features, e.g. zero-downtime deployments!      | lots of concepts to grasp                                                                              |

Over the course of time, I think I have actually ran home assistant in all of these configurations (even including directly from source).
Like everything in IT, there is no real _right_ or _wrong_ solution, it depends on your specific situation.
My current approach is based on k3s -- but this is better left as the topic of a future post.

# Sample setup

All of the theoretical babble about containers and orchestration is just to come to this point where I can actually show something to run.
For this sample setup, I will build part of the service layer using only `docker-compose` and a set of related home assistant configuration files.

# Closing thoughts

[home automation architecture post]: {% post_url 2021-06-22-home_automation_architecture %}
[home automation overview post]: {% post_url 2021-06-15-home_automation_why %}
[home assistant]: https://www.home-assistant.io/
[architecture]: /assets/2021-06-22/architecture.png
[home assistant integrations]: https://www.home-assistant.io/integrations/
[entities]: https://developers.home-assistant.io/docs/core/entity/
[home assistant architecture dev docs]: https://developers.home-assistant.io/docs/architecture_index
[home assistant MQTT integration]: https://www.home-assistant.io/integrations/mqtt/
[flow]: /assets/2021-06-22/flow.png
[home assistant MQTT switch]: https://www.home-assistant.io/integrations/switch.mqtt/
[home assistant MQTT light]: https://www.home-assistant.io/integrations/light.mqtt/
[home assistant installation]: https://www.home-assistant.io/installation/
[home assistant layers img]: https://developers.home-assistant.io/img/en/architecture/full.svg
[home assistant core docker container]: https://hub.docker.com/r/homeassistant/home-assistant
[hass supervisor vs k8s]: https://community.home-assistant.io/t/kubernetes-vs-supervisor/184415
[docker-compose]: https://docs.docker.com/compose/
[kubernetes]: https://kubernetes.io/
[k3s]: https://k3s.io/
