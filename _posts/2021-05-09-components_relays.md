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

# Hardware

# Software

# Network

# Service

[^1]: ISBN/EAN 9789030142942
[^2]: the official regulation is the [AREI]
[^3]: the voltage between each phase wire and the neutral wire is 240V
[^4]: although it _could_ be wired in series, e.g. for a series of current-controlled LED fixtures

[previous post]: {% post_url 2021-04-22-architecture %}
[AREI]: https://economie.fgov.be/nl/publicaties/algemeen-reglement-op-de
[principle]: /assets/2021-05-09/principle.png
[danger]: /assets/2021-05-09/danger.jpg
[onewire]: /assets/2021-05-09/onewire.png
[layout]: /assets/2021-05-09/layout.png
[relay]: https://en.wikipedia.org/wiki/Relay
[project huisinstallatie naslagwerk]: https://www.plantyn.com/webshop/product/project-huisinstallatie-naslagwerk-9789030142942
[residual-current devices]: https://en.wikipedia.org/wiki/Residual-current_device
[three-phase connection]: https://en.wikipedia.org/wiki/Three-phase_electric_power
