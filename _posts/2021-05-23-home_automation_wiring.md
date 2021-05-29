---
title: "Wiring"
subtitle: "Groundwork for a wired home automation setup"
cover-img:
  - "assets/2021-05-25/wiring-push-buttons.jpg": "SVV wires connecting to a 4-touch push button"
readtime: true
tags:
  - home automation
  - tech
---

The [architecture post] laid out the rationale and principles behind a wired home automation setup.
It also focussed on the different _layers_ to consider in such a setup.

In this post, I will take a deeper dive into the bottom layer, the **wiring**.
Different kinds of inputs and outputs can be discussed, but for the sake of simplicity, I shall focus on a push button operating a lamp.

I will cover:

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
Even though I had a background as an electrical engineer, I still got a local professional electrician involved to ensure the overall safety ...

# Principle

## Relays

![principle relay]

A **[relay]** is an electrically operated switch.
The voltage over two of its terminals can then control (switch) the voltage over the two other terminals.
The control voltage will typically be on a safe, low voltage, whereas the other terminals can carry higher (mains) voltage.
You can use it to control any other electrically switched device, e.g. lights or motors.

## Push buttons

![principle push button]

Where the relay serves as the output, the [push button], together with a digital input sensor, serves as **the input**.
The push button itself is actually a simple mechanical contact.
Pushing the button results in the internal mechanical contact making an electrical contact.

There are two **types of contacts**: a _normally open_ (NO) contact or a _normally closed_ (NC) contact.
Normally open means that the mechanical contact maintains an open electrical contact for the majority of the time, unless the button is pressed.
Normally closed is then the opposite situation, meaning a closed electrical contact whenever the button is _not_ pressed.
For push buttons, such as those to operate lamps, an NO contact would typically be used.
NC contacts make sense for situation where you want to be sure that the electrical contact is always guaranteed, e.g. a sensor for an alarm system.
Loss of signal for an NC contact might indicate the sensor has been tampered with.

The **voltage** used for a push button is typically not mains voltage (240VAC), but rather a lower, safer voltage like 24VDC.
Typical digital input sensors such as those found on DIY devices like the [arduino] or [raspberry pi] would operate on 5V or 3.3V, respectively.
For wiring a house, this is not an option because of the longer line runs and the resulting voltage drop related to the resistance of the wiring itself.

An important thing to consider in the push button - lamp constellation is that the way the push button is used is **stateless**.
Considering the lamp is off, one push would switch the light on.
Another push would switch it back off again.
Based on the position of the push button itself, you would not be able to tell the state of the light.
It differs from a rocker switch in that it only maintains the contact for the duration of the push of the button.
While these observations might be rather trivial, for the purposes of modeling them higher up on the stack, they are relevant.

# Conductors (Belgium only)

## Relays

The following image shows a typical tube containing 3 wires with diameters of 1.5mm2, fit for lights.

![cable 3G 1.5mm2]

For the cables carrying mains voltage, the following **rules** are relevant (non-exhaustive see e.g.[^1][^2][project huisinstallatie naslagwerk]):

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

Contrary to the cabling for the lights, the push buttons run on the lower, safer voltage of 24VDC.
Consequently, the wire diameter can be a lot smaller.

The following image shows an _SVV_ **signal cable**, which is typically used in Belgium for analog signaling applications.
I did some online research into the international naming for this type of cable, but there does not seem to be any.
For the sake of the discussion here however, the characteristics are actually more important:

- small diameters, on the order of 0.8mm2
- solid core, as this makes connecting to the push buttons easier as they mostly have screw connectors
- multiple wires in 1 cable (as shown in the picture). These cables mostly come with either 4, 8, 12 or 16 wires.
- visually clearly differing wires, i.e. highly contrasting colors for the wires

![cable SVV]

The idea of having this multitude of wires in the signal cable is that you would ideally need **one cable run** for e.g. the push buttons of one floor.
Each push button contact then uses one of the wires of the signal cable.
Apart from the push button contacts, you also need to reserve one of the wires for the positive level.
Essentially, the push buttons thus internally connect 1 signal wire (on ground level) to the common positive level -- which can be detected by your digital input readout.

As a side note, some manufacturers also have push buttons with a built-in **LED light**.
If you want to provide power to that LED, you would also need to reserve an extra wire for that feature.

Concerning the **various colors** available in the signal cable, I did find it useful to have a fixed order in which to assign them to the different inputs.
I would always use the red wire for the positive (24V) level.
The remainder of the wires would then be assigned according to the [colors on the visible electromagnetic spectrum].
For example, you could go from black, grey, brown, orange, green, blue, ... all the way to white.

# Conclusion

The goal of this post was first describe in generic terms what kind of wiring is required for a simple push button-to-lamp setup.
Additionally, I have also attempted to provide a great level of detail for things I have found challenging myself during the course of the installation.
Some of these details might be very specific to my house (and local regulations), but I still hope someone else might learn from it!

[^1]: ISBN/EAN 9789030142942
[^2]: the official regulation is the [AREI]
[^3]: the voltage between each phase wire and the neutral wire is 240V
[^4]: although it _could_ be wired in series, e.g. for a series of current-controlled LED fixtures
[^5]: DALI is a bus system for digital light control. In theory, you could do full light control with DALI only (removing the need for relay-based control), but this means all of your light fixtures need to be DALI-aware.
[^6]: not quite visible, but a similar connection can be made for the other wire (blue, neutral)

[architecture post]: {% post_url 2021-04-22-home_automation_architecture %}
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
