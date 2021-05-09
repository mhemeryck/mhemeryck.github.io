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

The [previous post] laid out rationale and principles behind the wired home automation setup.
In this post, we shall take a first dive into one of the fundamental components in an end-to-end way: controlling a relay.

## A mandatory word of caution (!)

This post will touch a number of points where working with mains voltage is required.
If you do not have any background in working with electricity, please be sure you get help from a qualified electrician.
Also, some of the details really only apply to my local regulations (Belgium), so also make sure you are well aware of _your_ local regulations.
Related to this, some of the terminology might be a poor translation of some term which would have been straightforward in the original language (Dutch).
Despite a background as an electrical engineer, I still involved a local professional electrician to ensure the overall safety ...

The structure of this post will step through each of the layers explained before: **wiring**, **hardware**, **software**, **network** and **service**.

# Wiring

## Prinicple

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

## One-wire diagram

## Inside the cabinet

# Hardware

# Software

# Network

# Service

[^1]: ISBN/EAN 9789030142942
[^2]: the official regulation is the [AREI]

[previous post]: {% post_url 2021-04-22-architecture %}
[AREI]: https://economie.fgov.be/nl/publicaties/algemeen-reglement-op-de
[principle]: /assets/2021-05-09/principle.png
[relay]: https://en.wikipedia.org/wiki/Relay
[project huisinstallatie naslagwerk]: https://www.plantyn.com/webshop/product/project-huisinstallatie-naslagwerk-9789030142942
[residual-current devices]: https://en.wikipedia.org/wiki/Residual-current_device
