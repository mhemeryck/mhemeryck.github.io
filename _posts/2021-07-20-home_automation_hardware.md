---
title: "Hardware"
subtitle: "Unipi units"
cover-img:
  - "/assets/2021-07-20/neuron-cover.jpg": "unipi neuron unit"
readtime: true
tags:
  - home automation
  - tech
---

This post is a part of a larger series of posts on my home automation setup.
See the [home automation overview post], to learn about the rationale and a description of the other posts!

# unipi

For the hardware, I did choose the [unipi] neuron series:

![unipi hardware]

- open platform: the main controller board is an raspberry pi 3B+, meaning you can run any software on it you would want.
- local: obviously, it runs from my local network inside of my home.
- wired: the I/O interfaces use standard voltages, for instance the power supply to the unit uses 24V, the digital inputs use 24V, the relay outputs can switch 240V, ...
- form factor: the modules come in form factors of 4, 8 and 12 modules and fit nicely on a DIN rail in the electric cabinet.
- low cost: the units themselves do not come that cheap, but calculated as a _cost per I/O_, they are quite OK compared to other solutions like industrial PLCs
- community: while working on the units and my own custom software, I would often reach out to the [unipi community forum]. They often reply quite quickly and have been a great help!

The following picture shows what's actually inside such a unit: raspberry pi 3B+ main controller board and then (depending on the neuron series you have), 1 to 3 I/O boards, connected via [SPI].

![unipi module]

I have a number of different neuron units in my setup, but for the relay control of lights, I specifically have the [unipi neuron L403] since it has the largest amount of relay outputs (56).

Check out the [unipi KB] for more technical details.

[home automation overview post]: {% post_url 2021-06-15-home_automation_why %}
[unipi]: https://www.unipi.technology/
[spi]: https://en.wikipedia.org/wiki/Serial_Peripheral_Interface
[unipi module]: https://kb.unipi.technology/_media/en:hw:neuron_m103-top.jpg
[unipi neuron l403]: https://www.unipi.technology/unipi-neuron-l403-p102
[unipi kb]: https://kb.unipi.technology/en:hw:02-neuron
[unipi community forum]: https://forum.unipi.technology/
[unipi hardware]: /assets/2021-07-20/unipi-hardware.png
