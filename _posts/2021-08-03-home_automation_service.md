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

I already did manage home assistant, but what is it really?

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

# Containers and services

# Sample setup

# Closing thoughts

[home automation architecture post]: {% post_url 2021-06-22-home_automation_architecture %}
[home automation overview post]: {% post_url 2021-06-15-home_automation_why %}
[home assistant]: https://www.home-assistant.io/
[architecture]: /assets/2021-06-22/architecture.png
[home assistant integrations]: https://www.home-assistant.io/integrations/
[entities]: https://developers.home-assistant.io/docs/core/entity/
[home assistant architecture dev docs]: https://developers.home-assistant.io/docs/architecture_index
[home assistant MQTT integration]: https://www.home-assistant.io/integrations/mqtt/
