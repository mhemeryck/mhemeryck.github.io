---
title: Architecture
subtitle: My home automation layout
cover-img:
  - "/assets/2021-04-22/cover.jpg": "Photo by Maarten Deckers on Unsplash"
readtime: true
tags:
  - home automation
  - mqtt
  - tech
---

In the [previous post], I did start with explaining my vision and guiding principles in building a home automation setup.
Though not required, this post is part of a series posts on my home automation setup, so it might make sense to read this first.

Prior to actually building anything, it is important to think on a higher level what the various components are and how they can interact with each other.
There is a huge amount of different possible setups to choose from, each with their pros and cons.
Here, I will not give an exhaustive overview of those, but rather outline the final choice I did make.

![architecture]

Let's discuss!

## MQTT broker

_Central_ to the drawing is a [mosquitto MQTT broker].
MQTT is a _publish-subscribe_ protocol:

- there is one central instance, called the _broker_, which manages different _topics_
- different clients can _publish_ updates, _events_, to the topics
- in addition, all clients can also _subscribe_ to topics to receive the events

MQTT is a popular choice for IoT since the event-based model fits well for a lot of problems (e.g. a push button toggle).
Another advantage is that the each of the different clients only need to be aware of their connection to the broker.
A disadvantage however is that all connections rely on the availability of the central broker.

## MQTT clients

The principal other components of the setup are all MQTT clients which both subscribe and publish to specified topics, specifically:

- subscribe: they listen to topics which instruct them to do some behavior ("command topics")
- publish: they publish events to topics that indicates their state ("state topics")

The clients in this setup can provide (a combination of):

- _sensors_: push buttons, motion sensors, smoke detectors, ...
- _actors_: lights, covers, sirens, ...
- _logic_: send out events on a certain condition, e.g. on another event (an automation)

### unipi

For the sensors and actors I did use hardware from [unipi].
In essence the unipi modules are DIN-rail mountable units housing a raspberry pi and a couple of I/O boards depending on the model you have.

### home assistant

[home assistant] is an open source software project which aims to integrate all sorts of smart home devices.
Given my choice of MQTT as an interfacing protocol throughout my setup, I heavily rely on the [home assistant MQTT integration].

From a high level, all sensors and actors which are available as MQTT topics can be represented as _entities_ within the home assistant configuration.
The home assistant instance itself connects to the central MQTT broker and listens to those MQTT topics for which it has entities.
Automations, which are also part of the configuration, can then link actions from one entity to another.
An obvious example is the push of a button that switches a light on.
The rationale behind this way of working is that nothing is really hard-wired in this setup!

Note that home assistant supports a wide range of integrations beyond MQTT.
The thermostat in the schematic for instance has an integration based on REST / HTTP.

## Layers of abstraction

Planning for a DIY wired open home automation setup requires some other specific thinking in terms of the different layers of abstraction.
The following diagram focuses on these different layers.

![layers]

From low to high level:

1. **wiring**: the physical wiring which connects to electrical components such as push buttons and light fixtures
1. **hardware**: the physical hardware component that will interface with the electrical components (I/O).
1. **software**: a client library interfacing with the hardware and which can translate low-level hardware events to protocol events
1. **network**: layer which connects the different components together using the protocols
1. **service**: the services are those parts which actually talk to each other over the network.

Notice that not all components need to have all of the layers.
Services like home assistant and the mosquitto broker act completely on the network itself.

Why does this matter?
For the majority of commercially available IoT devices, you would get something that takes care of most of the lower levels.
Wiring isn't really an issue (it is mostly wireless) and the hardware and software are part of the package that you buy.
In this wired layout with custom components however, all of these layers need to be addressed.

By means of example, have a look at the wiring required for my cover control:

![wiring]

Most of my wiring was done in a [star topology].
The upside is that it is very flexible towards the future.
The (visible) downside is that the amount of wires piles up rapidly and you will need _some_ kind of system to keep a sane overview of this.

## Toggling a light switch ...

To conclude, let's just walk through all the steps of toggling a push button:

![flow]

1. a push button is pushed down, making contact (off-on) and then released again (on-off)
1. the unipi digital input module sees this change and translates this to an MQTT state change event[^1] which is pushed to the central mosquitto broker
1. the home assistant instance has a subscription on the broker for the input button state change and updates its internal entity state
1. the home assistant instance has an automation configured for the push button entity and triggers the matching light entity to an action
1. the light entity update pushes out another event to the light action topic to turn on
1. another unipi module which is connected to the physical light and has a subscription to the light action topic pulls in the update
1. the unipi module toggles a relay, switching on the light
1. finally, after the light has turned on, a state update is also pushed out from the unipi module, which updates the internal state on home assistant

## Conclusion

The focus of this post was to simply outline the main components and links in my home automation setup, principally based on MQTT and home assistant as the brains behind it all.

The main advantage of this setup is the flexiblity if offers since everything is configurable from within home assistant.
On the other side of the equation, once home assistant breaks down, the entire system can break down, which poses high reliability constraints on such central components.

I did not yet dive down into the details of the different components i.e. the sensors and actuators, most notably the unipi platform.
Also, the different applications themselves, such as push buttons, lighting fixtures, DALI, shades, an alarm system, ... all merit their own discussion.
Finally, I did also point the different layers of abstraction to consider when laying out a wired home automation system, which shall also make for an interesting future topic to dive into.

[^1]: actually, there's some more processing involved using a custom library [evok2mqtt] of mine, but I will leave this out of the discussion for now

[previous post]: {% post_url 2021-04-18-why %}
[architecture]: /assets/2021-04-22/architecture.png
[flow]: /assets/2021-04-22/flow.png
[layers]: /assets/2021-04-22/layers.png
[wiring]: /assets/2021-04-22/wiring.jpg
[mosquitto mqtt broker]: https://hub.docker.com/_/eclipse-mosquitto
[unipi]: https://www.unipi.technology/
[home assistant]: https://www.home-assistant.io/
[home assistant mqtt integration]: https://www.home-assistant.io/integrations/mqtt/
[evok2mqtt]: https://github.com/mhemeryck/evok2mqtt
[star topology]: https://en.wikipedia.org/wiki/Network_topology#Star
