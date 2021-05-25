---
title: "Wiring"
subtitle: "Groundwork for a wired home automation setup"
cover-img:
  - "/assets/2021-05-25/cover.jpg": "Top row from my electric cabinet"
readtime: true
tags:
  - home automation
  - mqtt
  - tech
---

The [architecture post] laid out the rationale and principles behind a wired home automation setup.
It also focussed on the different _layers_ to consider in such a setup.

In this post, we shall take a deeper dive into the bottom layer, the **wiring**.
Different kinds of inputs and outputs can be discussed, but for the sake of simplicity, I shall focus on a push button operating a lamp.

I shall discuss:

- caution: safety first
- principle: operating principle behind a light push button and relay
- conductors: the physical wires and cables themselves
- schematics: one-wire diagram and floor plan
- inside the cabinet: bringing everything together while keeping mental sanity

# A mandatory word of caution (!)

![danger]

This post will touch a number of points where working with mains voltage is required.
If you do not have any background in working with electricity, please be sure you get help from a _qualified electrician_.
Also, some of the details really only apply to my local regulations (Belgium), so make sure you are well aware of _your_ local regulations.
Related to this, some of the terminology used might be a poor translation of some term which would have been straightforward in my native language (Dutch).
Note that, while I do have a background as an electrical engineer, I still got a local professional electrician involved to ensure the overall safety ...

# Principle

## Relays

![principle relay]

A [relay] is in essence an electrically operated switch.
The voltage over two of its terminals can then control (switch) the voltage over two other terminals.
The control voltage will typically be on a safe, low voltage, whereas the other terminals can carry higher (mains) voltage.
You can use it to control any other electrically switched device, e.g. lights or motors.

## Push buttons

![principle push button]

Where the relay serves as the output, the [push button], together with a digital input sensor, serves as the input.
The push button itself is actually a simple mechanical contact.
Pushing the button results in the internal mechanical contact making an electrical contact.

Two variants can be discerned: a _normally open_ (NO) contact or a _normally closed_ (NC) contact.
Normally open means that the mechanical contact maintains an open electrical contact for the majority of the time, unless the button is pressed.
Normally closed is then the opposite situation, meaning a closed electrical contact whenever the button is not pressed.
For push buttons, such as those to operate lamps, NO contact would typically be used.
NC contacts make sense for situation where you want to be sure that the electrical contact is always guaranteed, e.g. a sensor for an alarm system.
Loss of signal for an NC contact might indicate the sensor has been tampered with.

The _voltage_ used for a push button is typically not on mains voltage (240VAC), but rather a lower, safer voltage like 24 VDC.
Typical digital input sensors such as those found on DIY devices like the [arduino] or [raspberry pi] would operate on 5V or 3.3V, respectively.
For wiring a house, this is not an option because of the longer line runs and the resulting voltage drop related to the resistance of the wiring itself.

An important thing to consider in the push button - lamp constellation is that the way the push button is used is _stateless_.
Considering the lamp is off, one push would switch the light on.
Another push would switch it back off again.
Based on the position of the push button itself, you would not be able to tell the state of the light.
It differs from a rocker switch in that it only maintains the contact for the duration of the push of the button.
While these observations might be rather trivial, for the purposes of modeling them higher up on the stack, they are relevant.

# Conductors (Belgium only)

## Relays

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

## Push buttons

TODO!

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

[^1]: ISBN/EAN 9789030142942
[^2]: the official regulation is the [AREI]
[^3]: the voltage between each phase wire and the neutral wire is 240V
[^4]: although it _could_ be wired in series, e.g. for a series of current-controlled LED fixtures
[^5]: DALI is a bus system for digital light control. In theory, you could do full light control with DALI only (removing the need for relay-based control), but this means all of your light fixtures need to be DALI-aware.
[^6]: not quite visible, but a similar connection can be made for the other wire (blue, neutral)

[architecture post]: {% post_url 2021-04-22-architecture %}
[AREI]: https://economie.fgov.be/nl/publicaties/algemeen-reglement-op-de
[principle relay]: /assets/2021-05-25/principle.png
[principle push button]: /assets/2021-05-25/principle_push_button.png
[push button]: https://en.wikipedia.org/wiki/Push-button
[danger]: /assets/2021-05-25/danger.jpg
[onewire]: /assets/2021-05-25/onewire.png
[layout]: /assets/2021-05-25/layout.png
[cabinet-wip]: /assets/2021-05-25/cabinet-wip.jpg
[cabinet-clamps]: /assets/2021-05-25/cabinet-clamps.jpg
[cabinet-unipi]: /assets/2021-05-25/cabinet-unipi.jpg
[relay]: https://en.wikipedia.org/wiki/Relay
[project huisinstallatie naslagwerk]: https://www.plantyn.com/webshop/product/project-huisinstallatie-naslagwerk-9789030142942
[residual-current devices]: https://en.wikipedia.org/wiki/Residual-current_device
[three-phase connection]: https://en.wikipedia.org/wiki/Three-phase_electric_power
[WAGO rail-mount terminal blocks]: https://www.wago.com/global/electrical-interconnections/discover-rail-mount-terminal-blocks
[DALI]: https://en.wikipedia.org/wiki/Digital_Addressable_Lighting_Interface
[unipi relay outputs img]: https://kb.unipi.technology/_media/en:hw:010_connection_of_io.png
[arduino]: https://www.arduino.cc/en/Tutorial/Foundations/DigitalPins
[raspberry pi]: https://www.raspberrypi.org/documentation/hardware/raspberrypi/gpio/README.md
