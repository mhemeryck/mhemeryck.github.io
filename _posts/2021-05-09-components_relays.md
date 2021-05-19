---
title: "Components: relays"
subtitle: "A first component setup E2E -- relays"
cover-img:
  - "/assets/2021-05-09/relays.jpg": "Photo by Angeles Pérez on Unsplash"
tags:
  - home automation
  - mqtt
  - tech
---

The [previous post] laid out the rationale and principles behind a wired home automation setup.
In this post, we shall take a first dive into one of the fundamental components in an end-to-end way: controlling a relay.

## A mandatory word of caution (!)

![danger]

This post will touch a number of points where working with mains voltage is required.
If you do not have any background in working with electricity, please be sure you get help from a _qualified electrician_.
Also, some of the details really only apply to my local regulations (Belgium), so make sure you are well aware of _your_ local regulations.
Related to this, some of the terminology used might be a poor translation of some term which would have been straightforward in my original language (Dutch).
Note that, while I do have a background as an electrical engineer, I still got a local professional electrician involved to ensure the overall safety ...

The structure of this post will step through each of the layers explained before: **wiring**, **hardware**, **software**, **network** and **service**.

# Wiring

## Principle

![principle]

A [relay] is in essence an electrically operated switch.
The voltage over two of its terminals can then control (switch) the voltage over two other terminals.
The control voltage will typically be on a safe, low voltage, whereas the other terminals can carry higher (mains) voltage.
You can use it to control any other electrically switched device, e.g. lights or motors.

## Conductors (Belgium only)

For the cables carrying mains voltage, the following rules are relevant (non-exhaustive see e.g.[^1][^2][project huisinstallatie naslagwerk]):

- for circuits up to 16A (typically lights), a min 1.5 mm2 cross-section wire is to be used
- for circuits up to 20A (lights and / or others like power sockets), a min 2.5 mm2 cross-section wire is to be used
- each of the circuits need to have proper matching circuit breakers
- all cables consist of neutral wire, live wire and a earth wire
- color coding:
  - neutral: blue
  - live: brown
  - earth wire: green / yellow
- max 8 consumers (lights, power sockets) per circuit

Keep in mind:

- _circuit breakers_ protect _your wires_ from burning up
- _[residual-current devices]_ protect _living things_!

## One-wire diagram and floor plan

The one-wire diagram is an easy representation of all of the circuits in an electrical installation.
As its name implies, it does not show each of the individual wires of the installation but rather how the cables are laid out logically.

To illustrate, here's a small annotated (red) part of my installation's one-wire diagram:

![onewire]

1. The bottom left corner holds the entry-point from the street level where the main cable enters the house. In this case, it is a 400V [three-phase connection]: 3 phase wires plus 1 neutral[^3].
1. Straight after entering the house, the main cable passes through the utility company's power meter.
1. Main residual current device, ΔI=300 mA. This means that if the circuit breaker detects a leakage current ≥ 300 mA, it will automatically shut down the entire installation. Note that for Belgium, the 300 mA is mandatory for the overall installation, for circuits that pass through more humid environments (e.g. bathrooms), an additional 30 mA residual-current device is required.
1. At this level, all of the various circuits are placed in parallel, each with their own circuit breaker.
1. Wire specs: note that the circuit breakers need to match the requirements of the wires and the related consumers, as indicated in the previous section.
1. This level just illustrates two kinds of consumers; first a power socket, then a generic consumer.
1. Another example with emergency lighting.
1. An example circuit with a 240VAC / 24VDC transformer.
1. An example circuit for my solar panel installation.
1. This is a circuit exclusively containing lights: each of the branches indicates which lights are wired against the same control point. This means that each of the branches are switched using the same switch, or in this case relay. Note that this does not relate to how they are wired electrically: typically everything is wired in parallel[^4].
1. This is another example of a circuit with lights.

Next to the one-wire diagram, there's an additional diagram that lays out the circuits and their consumers on a floor plan.

![layout]

Essentially, it just re-uses the numbering from the one-wire diagram presented earlier, so I won't discuss these further.

Even though these diagrams only represent part of the information, they proved to be really valuable to me along the way:

- planning: since there's a finite number of consumers you can add to a circuit, it forces you to think ahead of the number of consumers on a single wire run.
- installation: on the construction site, you really don't want to spend too much time (re)thinking your setup.
- posterity: in case anything breaks down (e.g. a circuit breaker switching off), you just want an easy to digest overview of the whole thing.

## Inside the cabinet

Given the star-configuration for all of the lights, the amount of wiring in the central electricity cabinet quickly adds up.
The following picture shows a work-in-progress view while laying out the cables:

![cabinet-wip]

Be sure you have a consistent _labelling scheme_ while pulling all of the cable.
Looking back at these pictures, I think it is a bit of miracle I did not miss anything ...

Besides from labelling the cables during the pulling of the cables, I also did use terminal clamps, like the [WAGO rail-mount terminal blocks].
On one end of such a block, you have one or more terminals where you can connect your wires.
The other end on this block can then later be used to connect whatever you need.

Functionally, it does not do all that much.
In terms of costs, a single block is not that expensive but since the amount of blocks you need quickly adds up, so do the costs.
Even so, in a setup with a substantial amount of wiring it is almost necessary to have something like this in place.

The next picture shows 2 DIN-rails with all of the terminal blocks for my lights.

![cabinet-clamps]

- top row: termination of line (brown) and neutral (blue) wires.
- bottom row: termination of 2 more wires which I intend to use as a [DALI] bus[^5]; DALI+ (grey) and DALI- (black).
- jumpers: middle of terminal blocks: some of the terminal blocks have "jumpers" in them, i.e. another advantage in the sense that you can easily add (parallel) connections[^6].
- orange spacers: each set of blocks between these spacers represent a single electric circuit. This makes it easier to map the one-wire diagram to the actual wiring inside the cabinet.
- green / yellow wires: these are terminated separately on the copper bar (visible between the two DIN rails) and directly connected to the main earth wire.
- two-level terminal blocks: the terminal blocks used here have 2 levels, i.e. the outer 2 terminals are connected as well as the inner 2. A multitude of such terminal blocks exists, ranging for single to multiple levels as well as different functionalities (built-in diodes, resistors, ...). Here, two-level terminal blocks were used mostly because of space constraints.

Note that at this point that the wires from the light fixtures in the house were just connected to these terminal blocks: having these blocks there means you can later still have all flexibility for connecting them elsewhere.

The next part is connecting them to the module that contains the relays themselves.
The [unipi relay outputs KB] lists all of the details for connecting a single relay:

![unipi relay outputs img]

This connection in itself is not all that complex for a _single_ relay.
Since multiple lights on the same circuit are connected to the same circuit breaker, there is the practical concern of how to ensure these are all properly connected in parallel while still maintaining again a good overview.
The following picture shows another set of terminal blocks that I did use for this:

![cabinet-unipi]

- line wire (brown): the terminal block holders (orange, left from the unipi module) hold a set of terminal blocks which have one end connected to the circuit breaker, the other ends serve to _distribute_ the voltage to multiple relays.
- neutral wire (blue): since all neutral wires of a single circuit are placed next to each other, these can just be connected in parallel using a jumper.
- relay: each of the lights are connected to "RO" connections coming from the unipi module.

At this point we _finally_ have all of the wiring in place!

# Hardware

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

Check out the [unipi KB] for more technical details.

# Software

# Network

# Service

[^1]: ISBN/EAN 9789030142942
[^2]: the official regulation is the [AREI]
[^3]: the voltage between each phase wire and the neutral wire is 240V
[^4]: although it _could_ be wired in series, e.g. for a series of current-controlled LED fixtures
[^5]: DALI is a bus system for digital light control. In theory, you could do full light control with DALI only (removing the need for relay-based control), but this means all of your light fixtures need to be DALI-aware.
[^6]: not quite visible, but a similar connection can be made for the other wire (blue, neutral)

[previous post]: {% post_url 2021-04-22-architecture %}
[AREI]: https://economie.fgov.be/nl/publicaties/algemeen-reglement-op-de
[principle]: /assets/2021-05-09/principle.png
[danger]: /assets/2021-05-09/danger.jpg
[onewire]: /assets/2021-05-09/onewire.png
[layout]: /assets/2021-05-09/layout.png
[cabinet-wip]: /assets/2021-05-09/cabinet-wip.jpg
[cabinet-clamps]: /assets/2021-05-09/cabinet-clamps.jpg
[cabinet-unipi]: /assets/2021-05-09/cabinet-unipi.jpg
[relay]: https://en.wikipedia.org/wiki/Relay
[project huisinstallatie naslagwerk]: https://www.plantyn.com/webshop/product/project-huisinstallatie-naslagwerk-9789030142942
[residual-current devices]: https://en.wikipedia.org/wiki/Residual-current_device
[three-phase connection]: https://en.wikipedia.org/wiki/Three-phase_electric_power
[WAGO rail-mount terminal blocks]: https://www.wago.com/global/electrical-interconnections/discover-rail-mount-terminal-blocks
[DALI]: https://en.wikipedia.org/wiki/Digital_Addressable_Lighting_Interface
[unipi relay outputs KB]: https://kb.unipi.technology/en:hw:02-neuron:description-of-io:03-description-of-ro
[unipi relay outputs img]: https://kb.unipi.technology/_media/en:hw:010_connection_of_io.png
[unipi hardware]: /assets/2021-05-09/unipi-hardware.png
[unipi module]: https://kb.unipi.technology/_media/en:hw:neuron_m103-top.jpg
[unipi KB]: https://kb.unipi.technology/en:hw:02-neuron
[unipi]: https://www.unipi.technology/
[SPI]: https://en.wikipedia.org/wiki/Serial_Peripheral_Interface
[unipi community forum]: https://forum.unipi.technology/
