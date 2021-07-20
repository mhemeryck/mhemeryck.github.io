---
title: "Hardware"
subtitle: "Unipi units"
cover-img:
  - "/assets/2021-07-20/neuron-cover.jpg": "unipi neuron unit"
readtime: true
tags:
  - home automation
  - hardware
  - unipi
  - tech
---

In this post, I will give some more details about the rationale for the **hardware** that I had chosen for interpreting the input signals and controlling the outputs, specifically the [unipi neuron series].
Note that I am in no way affiliated with unipi, nor do I intend to do an in-depth description of their hardware.
For more details from unipi themselves, have a look at the [unipi] website.

This post is a part of a larger series of posts on my home automation setup.
See the [home automation overview post], to learn about the rationale and a description of the other posts!

# Inside

The following picture shows what is actually **inside such a unit**: a [raspberry pi 3B+] main controller board and then (depending on the neuron series you have), 1 to 3 I/O boards, connected via [SPI] -- Serial Peripheral Interface.

The **SPI interface** works by connecting a number of nodes in a series, _daisy-chained_, on the same SPI-line(s).
The raspberry pi functions as the main _server_ node, the I/O boards are the _clients_.
The server nodes periodically _selects_ one of the clients to become active.
Consequently, the selected client becomes active and puts its data on the SPI-lines that were made available.
Other clients remain inactive for that duration of time they were not selected.
Afterwards, the server moves on to the next client.
This process continues until all clients have been consulted, at which point the cycle concludes and a new one starts.

![unipi inside]

The main controller board has all the other **functionalities** the raspberry pi has, including bluetooth, wifi, wired ethernet, USB ports, and even a HDMI interface[^1].
The I/O boards either feature digital inputs, relay outputs, analog inputs, analog outputs or a combination of these.
Additionally, there are connections like a RS-485 serial lines (e.g. for interfacing with modbus) as well as a connector for a 1-wire bus (e.g. for temperature sensors).

# Rationale

![unipi module]

Considering the hardware platform, I think the unipi platform provides a number of **advantages** I couldn't find with other vendors:

- **open platform**: the main controller board is a raspberry pi 3B+, meaning you can run any software on it you would want.
- **software support**: next to the open platform, they also provide open source OS images as well as software libraries to extend yourself.
- **local**: obviously, it runs from my local network inside of my home.
- **wired**: the I/O interfaces use standard voltages, for instance the power supply to the unit uses 24V, the digital inputs use 24V, the relay outputs can switch 240V[^2], ...
- **form factor**: the modules come in form factors of 4, 8 and 12 DIN rail modules and fit nicely on a household DIN rail in the electric cabinet.
- **wiring connectors**: related to the form factor, it is quite easy to connect a large amount of I/O in a relatively small space.
- **low cost**: the units themselves do not come that cheap, but calculated as a _cost per I/O_, they are quite OK compared to other solutions like industrial PLCs
- **community**: while working on the units and my own custom software, I would often reach out to the [unipi community forum]. They often reply quite quickly and have been a great help!
- **connectivity**: apart from the I/O, the unipi units come with a lot of extra connectivity options such as wifi, wired ethernet, bluetooth, RS-485, one-wire, ...

# Specific units

I have number of different unipi units in my setup, since I have a large amount of functionalities to support, for example:

- push button read-out
- light control (relays)
- alarm system (window / door contacts, PIR detector, ... but also on the output side an indoor-and outdoor siren).
- shades (relays)
- ...

While you can have both inputs and outputs on the same unipi unit, I did decide to dedicate a bigger unipi unit for the push button control and another one for the lights:

- lights, relay control: [unipi neuron l403], which has up to 56 relay outputs
- push button read-out: the unipi neuron m303. This was an upgraded version of the [unipi neuron m303] with up to 64 digital inputs, but at the time of writing, it seems this model is no longer supported.

# Unipi axon

As a side note, I also have a **unipi axon S605** for _DALI light control_.
The [unipi axon series] is another series of PLCs from the same brand.
It differs mainly in the controller board it features: instead of being based on raspberry pi, it is based on an Allwinner H5 ARM processor.
Also, instead of having the main hard drive on a removable flash memory, it has internal eMMC memory.

I did not look into the rest of the axon series as it wasn't available at the time when I acquired them.
Additionally, I also favored the neuron series because I have more familiarity with the raspberry platform in general.

DALI light control is something I haven't yet fully deployed, but the advantage is that you can have more all-digital control of lights -- wherever the light fixtures support it.
The main feature I do like about DALI is the ability to dim lights directly from the LED driver that already needs to perform the AC / DC conversion, making it more effective.

Note however that this specific unit also isn't able anymore, I suspect due to low demand.

# Closing thoughts

This was just a short description mainly about _why_ I did choose unipi neuron as the main hardware platform for my home automation.

Note that this sort of hardware is particularly suited for a wired, [star topology] setup.
If I were to name a **disadvantage**, it would be that working with this kind of hardware requires a lot of _tedious manual wiring_ which also takes up a lot of _cabinet space_.
This is however more of an issue of the overall setup, not the hardware itself.
The alternative is a bus-system, where all of the signaling is done on a shared bus.
The disadvantage here is either all of the hardware on the bus is more complex and costly (e.g. KNX, DALI) and / or that you are tied to a single hardware vendor.
Nonetheless, DALI (and maybe even KNX) is something I would still like to examine a bit more in detail at some point in the future.

Another issue I have faced is with the **removable flash drives** as these tend to go _corrupt after many read / write cycles_.
Again, this is more of an issue of the raspberry pi and flash drives in general, but it could still pose an issue for the reliability of the overall system.
After changing the flash drives to a more durable pSLC SD card, I can confirm that I haven't faced any issues with corrupt flash drives lately (fingers crossed!)
Check the [unipi SD card reference] for more details.

Overall, I have been very happy with the unipi hardware platform though!

For more commercial details check the [unipi] main website.
On the technical side, checkout the [unipi kb].

[^1]: the HDMI interface isn't readily exposed
[^2]: for highly inductive loads, like motors, it is recommended to switch the loads not directly, but instead via an intermediary set of relays

[home automation overview post]: {% post_url 2021-06-15-home_automation_why %}
[unipi neuron series]: https://www.unipi.technology/products/unipi-neuron-3?categoryId=2&categorySlug=unipi-neuron
[unipi axon series]: https://www.unipi.technology/products/unipi-axon-135?categoryId=13&categorySlug=unipi-axon
[unipi inside]: /assets/2021-07-20/unipi-hardware.png
[unipi]: https://www.unipi.technology/
[spi]: https://en.wikipedia.org/wiki/Serial_Peripheral_Interface
[unipi module]: https://kb.unipi.technology/_media/en:hw:neuron_m103-top.jpg
[unipi neuron m303]: https://www.unipi.technology/unipi-neuron-m303-p98
[unipi neuron l403]: https://www.unipi.technology/unipi-neuron-l403-p102
[unipi kb]: https://kb.unipi.technology/en:hw:02-neuron
[unipi community forum]: https://forum.unipi.technology/
[star topology]: https://en.wikipedia.org/wiki/Network_topology#Star
[unipi SD card reference]: https://kb.unipi.technology/en:hw:02-neuron:suitable-sd-card
[raspberry pi 3B+]: https://www.raspberrypi.org/products/raspberry-pi-3-model-b-plus/
