---
title: Why
subtitle: My vision for a modern home automation system
cover-img:
  - "/assets/2021-06-15/cover.jpg": "Photo by Simone Secci on Unsplash"
readtime: true
tags:
  - homeautomation
  - tech
---

This post shall be the first in a series of blog posts where I intend to outline my home automation setup.

For this first post, I want to start by first explaining _why_ I worked on this.
Secondly, I want to give some more attention to the _vision_ and guiding principles I will use further on.
At the end, there is an overview of all the future posts that I have currently planned for this series.

# why

I am an electrical engineer by **background**, specialized in signal processing and programming for embedded devices (high complexity on small systems).
Within my career, I did make the switch to software engineering, doing the opposite (low complexity on large systems).

One of the things I really did enjoy while building this system (and by extension: my house) was being able to **build something from the ground up**.
Along the way, I was able to learn about a myriad of things: electricity and lighting, IoT hardware, various concepts, paradigms, languages ... related to software development, networking and network-related infrastructure ...
Non-technical aspects, such as project management, were also quite important.

Even though I feel there's still a lot of room left for improvement, I did consider that **now was a good time do a write-up** of everything accomplished thus far.
Firstly, I believe that writing everything down would help me in documenting everything.
Additionally, this provides the opportunity to reflect back on those things that went well as well as other parts that might still benefit from some improvements.
The process of writing itself is also a good exercise to improve on my technical writing (in a non-native language).
Possibly these posts might help or even inspire my readers to get into this topic.
Lastly, I do want to reach out to a larger community and get feedback

# Vision

There are many different approaches to build a home automation system.
Since the open source [home assistant] platform plays a central role in my system, I did borrow some inspiration from [home assistant's vision].

Considering my own ideal system, the following are the key ideas.

## Wired

A wired solution has the advantage of not being affected by unreliable wireless links.
Also, there's generally no issue of ensuring a power supply, so there is no need to keep an eye on batteries.
The disadvantage is however that the overall setup is less flexible and needs to be thought out really well in advance.
The process of wiring itself can also be quite time consuming, costly or simply impossible, depending on your housing situation.

## Open

All hardware and software should be "open" in the sense that it can readily understood and changes can be made to it.
It should be possible to take a given component and swap it out for another one, unrelated to the original vendor.
On the software-side, it should be possible to program against it with standard protocols using general-purpose programming languages.
Combining different sorts of hardware and software should be straightforward.

## Local

The home automation should always work, even in the absence of an Internet connection.
The data from the home automation system itself should be owned by yourself.
This does not mean that you cannot use common network protocols, you can still have everything connected via a local network (LAN).
Nor does this mean that you cannot have non-critical integrations which are web-based, e.g. an integration that pulls in a weather forecast.
Ideally though, the majority of communications the home automations needs to do to function properly should be in the home itself.

## Low cost

Home automation systems have been around for quite some time, but what has changed the latest years is the availability of both hardware and software that allows to mix and match.
Also open hardware platforms like the raspberry pi have made it much easier to develop own platforms.
The disadvantage of such DIY platforms is the lower intrinsic robustness, compared to an off-the-shelf commercial solution.

## Reproducible

This is a key idea coming from my background as a software developer.
Essentially, this means that the provisioning and deployment of the overall setup should be automated to the extent that in case of any failure it can readily be reconstructed.

# Posts

In the following series of blog posts, I will outline more of the details of the actual setup that I did design and build.

1. [why] introduction to the series, this post
1. [architecture] topology of the home automation components and different levels of abstraction
1. [wiring] details about basic components (relays and push buttons) and the related wiring
1. [schematics] how to represent the electrical wiring in a one-wire diagram and floor plan
1. [cabinet] a peek inside my electrical cabinet
1. [hardware] details about the central hardware units I did use
1. [software] different layers of interfacing software
1. [service] bringing it all together with home assistant

[why]: {% post_url 2021-06-15-home_automation_why %}
[architecture]: {% post_url 2021-06-22-home_automation_architecture %}
[wiring]: {% post_url 2021-06-29-home_automation_wiring %}
[schematics]: {% post_url 2021-07-06-home_automation_schematics %}
[cabinet]: {% post_url 2021-07-13-home_automation_cabinet %}
[hardware]: {% post_url 2021-07-20-home_automation_hardware %}
[software]: {% post_url 2021-07-27-home_automation_software %}
[service]: {% post_url 2021-08-03-home_automation_service %}
[home assistant]: https://www.home-assistant.io/
[home assistant's vision]: https://www.home-assistant.io/blog/2016/01/19/perfect-home-automation/
