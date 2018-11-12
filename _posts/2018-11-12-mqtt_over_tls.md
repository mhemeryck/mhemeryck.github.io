---
layout: post
title: "MQTT over TLS"
author: "mhemeryck"
---
[MQTT] is a popular lightweight protocol for use in home automation.
If features a central broker where each of the clients can communicate with in a pub / sub fashion.

Since I've been toying around with some home automation setups, I was curious how to secure it with TLS.

# Mosquitto

The most commonly used broker implementation I have come across is [mosquitto] and is quite straightforward to setup on most \*nix flavors.
In my setup, I wanted to run it on Raspberry Pi, which I could leave running at my local home network.
Since it runs raspbian, installing it was as simple as:

    ~ sudo apt-get install mosquitto

# TLS setup: keys and certificates

Doing the TLS setup requires a number of key and certificate files.
The official [mosquitto-tls man page] fortunately lists all of them and how to generate them.

Note that for the final setup, not all of these files are required; these are the files we _do_ need:
1. `ca.crt`: Certificate Authority certificate: the "central" authority certifying ownership of the public key
1. `server.key`: server private key, linked to the certificate.
1. `server.crt`: certificate from the server (MQTT broker), signing the server key pair, by the CA.

# File layout on the broker

On my setup, most of these folders were already available after install, so I figured to actually use them.

    ~ tree /etc/mosquitto
    /etc/mosquitto
    ├── ca_certificates
    │   ├── ca.crt
    │   └── README
    ├── certs
    │   ├── README
    │   ├── server.crt
    │   └── server.key
    ├── conf.d
    │   ├── README
    │   └── tls.conf
    └── mosquitto.conf

# `mosquitto.conf`

This is pretty the same config that was also provided by the built-in; just to show:

    ~ cat /etc/mosquitto/mosquitto.conf
    # Place your local configuration in /etc/mosquitto/conf.d/
    #
    # A full description of the configuration file is at
    # /usr/share/doc/mosquitto/examples/mosquitto.conf.example

    pid_file /var/run/mosquitto.pid

    persistence true
    persistence_location /var/lib/mosquitto/

    log_dest file /var/log/mosquitto/mosquitto.log

    # This include assures that our own custom config gets loaded
    include_dir /etc/mosquitto/conf.d

# `tls.conf`

Actual TLS specific config, pointing to all the files that were added.

    ~ cat /etc/mosquitto/conf.d/tls.conf
    port 8883
    cafile /etc/mosquitto/ca_certificates/ca.crt
    keyfile /etc/mosquitto/certs/server.key
    certfile /etc/mosquitto/certs/server.crt
    tls_version tlsv1

# Reload the setup

The package installer also conveniently creates the required (systemd) service for us.
Simply restart the service now:

    sudo systemctl restart mosquitto.service

# Client subscribe

With the broker running the new config, testing can easily be done with the mosquitto built-in `mosquitto_pub` / `mosquitto_sub` commands.
Obviously, all clients that want to use this config now need the CA file.

On a client: subscribe:

    ~ mosquitto_sub --cafile ca.crt -h raspberrypi.lan -t test

**Note:** the host name should correspond to the host name in the certificate.

# Client publish

On a client: publish

    ~ mosquitto_pub --cafile ca.crt -h raspberrypi.lan -t test -m "hi there"

In the window running the subscribe, the message should now appear.

Here, the clients do _not_ verify themselves though, they just use the certificate to encrypt traffic over TLS.


[MQTT]: https://en.wikipedia.org/wiki/MQTT
[mosquitto]: https://mosquitto.org/
[mosquitto-tls man page]: https://mosquitto.org/man/mosquitto-tls-7.html
