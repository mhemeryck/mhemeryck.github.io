---
title: "Electrical cabinet"
subtitle: "A quick tour inside"
cover-img:
  - "/assets/2021-05-25/cover.jpg": "Top row from my electric cabinet"
readtime: true
tags:
  - home automation
  - tech
---
# Inside the cabinet

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
Nonetheless, I would still recommend it keep a clear overview while inside of your cabinet.

## Relays

The next picture shows 2 DIN-rails with all of the terminal blocks for my lights.

![cabinet-clamps]

- top row: termination of line (brown) and neutral (blue) wires.
- bottom row: termination of 2 more wires which I intend to use as a [DALI] bus[^5]; DALI+ (grey) and DALI- (black).
- jumpers: middle of terminal blocks: some of the terminal blocks have "jumpers" in them, i.e. another advantage in the sense that you can easily add (parallel) connections[^6].
- orange spacers: each set of blocks between these spacers represent a single electric circuit. This makes it easier to map the one-wire diagram to the actual wiring inside the cabinet.
- green / yellow wires: these are terminated separately on the copper bar (visible between the two DIN rails) and directly connected to the main earth wire.
- two-level terminal blocks: the terminal blocks used here have 2 levels, i.e. the outer 2 terminals are connected as well as the inner 2. A multitude of such terminal blocks exists, ranging for single to multiple levels as well as different functionalities (built-in diodes, resistors, ...). Here, two-level terminal blocks were used mostly because of space constraints.

Note that at this point that the wires from the light fixtures in the house were just connected to these terminal blocks: having these blocks there means you can later still have all flexibility for connecting them elsewhere.

The next part is connecting them to the unit that contains the relays themselves.
The [unipi relay outputs KB] lists all of the details for connecting a single relay:

![unipi relay outputs img]

This connection in itself is not all that complex for a _single_ relay.
Since multiple lights on the same circuit are connected to the same circuit breaker, there is the practical concern of how to ensure these are all properly connected in parallel while still maintaining again a good overview.
The following picture shows another set of terminal blocks that I did use for this:

![cabinet-unipi]

- line wire (brown): the terminal block holders (orange, left from the unipi module) hold a set of terminal blocks which have one end connected to the circuit breaker, the other ends serve to _distribute_ the voltage to multiple relays.
- neutral wire (blue): since all neutral wires of a single circuit are placed next to each other, these can just be connected in parallel using a jumper.
- relay: each of the lights are connected to "RO" connections coming from the unipi module.

## Push buttons

Next to the series of clamps for terminating the cables for the lights, I also did add clamps for terminating the SVV analog signaling cable:

![cabinet-clamps-svv]

At the top, the incoming signaling cable is terminated.
Spacers are placed series of clamps which belong to the same signaling cable run.
The bottom part then connects each of the signaling wires to a digital input somewhere lower in the cabinet.
In the middle of the clamps, you can see a number of overlapping jumpers.
These jumpers have been set up such that they only make an electrical contact in a fixed number of slots, in this case for connecting one of the wires for each cable run to 24V.

As before, the following image shows the electrical connection from the signaling cable to the unipi digital input unit.
The `DIGND` corresponds to the ground level of your 24VDC power source.
The `DI` level is the signaling cable to one of the push buttons.
Pushing a button means the 24V level gets connected to the signal cable and thus giving a `DI` level of 24V.
For more technical details, consult the [unipi digital input KB].

![unipi digital inputs img]

As can be seen from the following picture, making the physical connection between the incoming signal wires and the unipi units is easier than for the relay unit, shown earlier.

![cabinet-unipi-di]

There is no need to have dedicated circuit breakers for the different signal wire cable runs; all of them can all run on the same 24VDC power source.
Also, since the wire diameter is much lower, the screw connectors can just be used directly to terminate multiple wires and effectively provide electrical parallel connections.
Since each of the green screw connectors could have up to 4 signal wire connections and 1 ground level, I did use 4-wire SVV cable to connect them to terminal clamps higher up in the cabinet.
Note that I also did use my color coding again here (red / yellow / blue / white).
