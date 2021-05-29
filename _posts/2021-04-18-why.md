---
title: Why
subtitle: My vision for a modern home automation system
cover-img:
  - "/assets/2021-04-18/cover.jpg": "Photo by Simone Secci on Unsplash"
readtime: true
tags:
  - homeautomation
  - tech
---

This post shall be the first in a series of blog posts where I will outline my home automation setup.

Let's start with _why_?

# why

I am an electrical engineer by _background_, specialized in signal processing and programming for embedded devices (high complexity on small systems).
Within my career, I did make the switch to software engineering, doing the opposite (low complexity on large systems).

One of the things I really did enjoy while building this system (and by extension: my house) was being able to _build something from the ground up_.
Along the way, I was able to learn about a myriad of things: electricity and lighting, IoT hardware, various concepts / paradigms / languages / ... related to software development, networking and network-related infrastructure but also non-technical aspects such as project management.

Even though I feel there's still a lot of room left for various improvements, I felt that _now was a good time do a write-up_ of everything accomplished thus far.
Firstly, I believe that writing everything down would help me in documenting everything.
It should also give me the ability to reflect back on those things that went well as well as other parts that might still benefit from some improvements.
I also hope that the process of writing itself will help me to improve on my technical writing.
Secondly, I also hope that these posts might help or even inspire you, my readers, to get into this topic.
Even though I have always tried to keep an open mind towards existing solutions, the overall solution is a mix of different ideas.
Via this way, I hope to reach out to a larger community to share these ideas and get feedback on them.

# Vision

There are many different approaches to build a home automation system.
I agree with everything presented in [home assistant's vision].

Considering my own ideal system, I would underline the following points.

## Wired

A wired solution has the advantage of not being affected by unreliable wireless links.
Also, there's generally no issue of ensuring a power supply, so there is no need to keep an eye on batteries.
The disadvantage is however that the overall setup is less flexible and needs to be thought out really well in advance.
The process of wiring itself can also be quite time consuming and costly or simply impossible, depending on your housing situation.

## Open

All hardware and software should be "open" in the sense that it can readily understood and changes can be made to it.
It should be possible to take a given component and swap it out for another one, unrelated to the original vendor.
On the software-side, it should be possible to program against it with standard protocols using general purpose programming languages.
Combining different hardware and software should be straightforward.

## Local

The home automation should always work, even if there is no Internet connection.
The data from the home automation system itself should be owned by yourself.

## Low cost

Home automation systems have been around for quite some time, but was has changed the latest years is the availability of both hardware and software that allows to mix and match.
Also open hardware platforms like the raspberry pi have made it much easier to develop own platforms.
The disadvantage of such DIY platforms it the lower intrinsic robustness, compared to an off-the-shelf commercial solution.

## Reproducible

This is a key idea coming from my background as a software developer.
Essentially, this means that the provisioning and deployment of the overall setup should be automated to the extent that in case of any failure it can readily be reconstructed.

[home assistant's vision]: https://www.home-assistant.io/blog/2016/01/19/perfect-home-automation/

# Posts

In the following series of blog posts, I will outline more of the details of the actual setup that I did design and build.

1. architecture: topology of home automation components
1. levels of abstraction: how to think and design home automation
1. components: what can be automated?
1. schematics: how to document?
1. network: how to connect everything over LAN
1. local cloud: k3s-at-home
