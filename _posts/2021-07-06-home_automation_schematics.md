---
title: "Schematics"
subtitle: "One-wire diagram and floor plan"
cover-img:
  - "/assets/2021-05-29/cover.png": "Work-in-progress one-wire diagram"
readtime: true
tags:
  - home automation
  - tech
---

# One-wire diagram

The **one-wire diagram** is an easy representation of all of the circuits in an electrical installation.
As its name implies, it does not show each of the individual wires of the installation but rather how the cables are laid out logically.

Note that I no longer make the distinction between push buttons and relays.
According to my local regulations, it is not required and even discouraged to include low voltage wiring on the one-wire diagram since it adds to the overall complexity of the diagram.

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

# Floor plan

Next to the one-wire diagram, there's an additional diagram that lays out the circuits and their consumers on a floor plan.
Low voltage wiring is also not required for the official floor plan, but it does make sense to have it mapped out somewhere, even if that would be on a separate diagram.

![layout]

Essentially, it just re-uses the numbering from the one-wire diagram presented earlier, so I won't discuss these further.

Even though these diagrams only represent part of the information, they proved to be really valuable to me along the way:

- planning: since there's a finite number of consumers you can add to a circuit, it forces you to think ahead of the number of consumers on a single wire run.
- installation: on the construction site, you really don't want to spend too much time (re)thinking your setup.
- posterity: in case anything breaks down (e.g. a circuit breaker switching off), you just want an easy to digest overview of the whole thing.

[^1]: ISBN/EAN 9789030142942
[^2]: the official regulation is the [AREI]
[^3]: the voltage between each phase wire and the neutral wire is 240V
[^4]: although it _could_ be wired in series, e.g. for a series of current-controlled LED fixtures
[^5]: DALI is a bus system for digital light control. In theory, you could do full light control with DALI only (removing the need for relay-based control), but this means all of your light fixtures need to be DALI-aware.
[^6]: not quite visible, but a similar connection can be made for the other wire (blue, neutral)

[AREI]: https://economie.fgov.be/nl/publicaties/algemeen-reglement-op-de
[principle relay]: /assets/2021-05-25/principle.png
[principle push button]: /assets/2021-05-25/principle_push_button.png
[push button]: https://en.wikipedia.org/wiki/Push-button
[danger]: /assets/2021-05-25/danger.jpg
[onewire]: /assets/2021-05-25/onewire.png
[layout]: /assets/2021-05-25/layout.png
[cabinet-wip]: /assets/2021-05-25/cabinet-wip.jpg
[cabinet-clamps]: /assets/2021-05-25/cabinet-clamps.jpg
[cabinet-clamps-svv]: /assets/2021-05-25/cabinet-clamps-svv.jpg
[cabinet-unipi]: /assets/2021-05-25/cabinet-unipi.jpg
[relay]: https://en.wikipedia.org/wiki/Relay
[project huisinstallatie naslagwerk]: https://www.plantyn.com/webshop/product/project-huisinstallatie-naslagwerk-9789030142942
[residual-current devices]: https://en.wikipedia.org/wiki/Residual-current_device
[three-phase connection]: https://en.wikipedia.org/wiki/Three-phase_electric_power
[WAGO rail-mount terminal blocks]: https://www.wago.com/global/electrical-interconnections/discover-rail-mount-terminal-blocks
[DALI]: https://en.wikipedia.org/wiki/Digital_Addressable_Lighting_Interface
[unipi relay outputs img]: https://kb.unipi.technology/_media/en:hw:010_connection_of_io.png
[unipi digital inputs img]: https://kb.unipi.technology/_media/en:hw:001_connection_of_io.png
[arduino]: https://www.arduino.cc/en/Tutorial/Foundations/DigitalPins
[raspberry pi]: https://www.raspberrypi.org/documentation/hardware/raspberrypi/gpio/README.md
[cable 3G 1.5mm2]: /assets/2021-05-25/cable-3g15.jpg
[cable SVV]: /assets/2021-05-25/cable-svv.jpg
[unipi relay outputs KB]: https://kb.unipi.technology/en:hw:02-neuron:description-of-io:03-description-of-ro
[unipi digital input KB]: https://kb.unipi.technology/en:hw:02-neuron:description-of-io:01-description-of-di
[colors on the visible electromagnetic spectrum]: https://en.wikipedia.org/wiki/Electromagnetic_spectrum
[cabinet-unipi-di]: /assets/2021-05-25/cabinet-unipi-di.jpg
