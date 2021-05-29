---
title: "Software"
subtitle: "Connecting the pieces together"
cover-img:
  - "/assets/2021-05-09/carbon.png": "Code snippet from evok2mqtt"
readtime: true
tags:
  - home automation
  - mqtt
  - tech
  - unipi
---

# Software

The following diagram shows the different software _layers_, going from the kernel which polls the IO-boards to eventually pushing out / pulling in MQTT events.

![software layers]

## Kernel: polling SPI

Unipi provides their own [neuron open source OS], which is a modified version of [raspbian] including custom kernel drivers to poll the I/O boards over [SPI].
The kernel driver makes the data available via the [modbus] protocol.
The modbus protocol is a widely accepted, open industry standard for interfacing with PLCs.
I believe you would typically use it in a setup where you have one main controller and a series of follower controllers - which is pretty much the situation you would have using SPI.
Note that the unipi units also have an [RS-485] connection, commonly used for daisy chaining multiple controllers.

Apart from the modbus interface, unipi also provides a [sysfs interface], which essentially maps the I/O states and controls to a number of files in a fixed file system structure.

## Evok: modbus to web APIs

Unipi also provides an open source library called [evok] that will periodically poll the underlying modbus interface and make it available via all sorts of common web API formats and protocols: JSON / REST, JSONRPC, SOAP, ...
See the [evok API docs] for an extensive overview of all possible interfaces.

The most interesting interface provided by evok is the [evok websockets interface], since this is the only interface that can also trigger actions for particular events.
This is a definite requirement here, since you'd need to be able toggle the relays fast in case of an incoming request.

For the _receiving_ of messages (I/O board → outside) you would need to register a number of callback functions to the websocket.
The arguments to the callback function then hold information about the specific I/O action that triggered them.
For the _sending_ of messages (outside → I/O board), you can just send a structured message directly.

Here's a python snippet directly taken from the [evok websocket interface] docs:

```python
import json

import websocket

url = "ws://your.unipi.ip.address/ws"


def on_message(ws, message):
    obj = json.loads(message)
    dev = obj["dev"]
    circuit = obj["circuit"]
    value = obj["value"]
    print(message)


def on_error(ws, error):
    print(error)


def on_close(ws):
    print("Connection closed")


# receiving messages
ws = websocket.WebSocketApp(
    url,
    on_message=on_message,
    on_error=on_error,
    on_close=on_close,
)
ws.run_forever()

# sending messages
ws = websocket.WebSocket()
ws.connect(url)
ws.send('{"cmd":"set","dev":"relay","circuit":"3","value":"1"}')
ws.close()
```

## `evok2mqtt`: websocket to MQTT

The final layer is to translate the websocket "events" from and to MQTT events.
This translation is required since this is the standard message-based system interface that was chosen to interface with [home assistant].
In order to implement this, I did create a small application called [evok2mqtt].
The application is written in python3 and uses the `websockets` library for interfacing with the evok websocket and `paho-mqtt` to do the same thing for MQTT.
This application runs alongside evok on the unipi neuron itself.

To express actions that need to occur on the receiving of messages, the MQTT library works pretty similar to the websockets library using callback functions, see e.g. [this evok2mqtt `on_message` snippet](https://github.com/mhemeryck/evok2mqtt/blob/96bf7e19063b15e96522fac038fab89959f16475/evok2mqtt/__init__.py#L158-L195)

```python
def on_message(client, userdata, message):
    """Callback for MQTT events"""
    logger.info(
        f"Incoming MQTT message for topic {message.topic} with payload {message.payload}",
        extra={"kind": LOG_KIND.MQTT},
    )
    match = MQTT_COMMAND_TOPIC_REGEX.match(message.topic)
    if match is None:
        return

    device_name = match.group("device_name")
    dev = match.group("dev")
    circuit = match.group("circuit")
    if device_name != _settings().DEVICE_NAME:
        logger.warning(
            "Handling incoming message for device %s, expected %s",
            device_name,
            _settings().DEVICE_NAME,
            extra={"kind": LOG_KIND.MQTT},
        )

    # Update state topic
    client.publish(
        MQTT_TOPIC_FORMAT.format(
            device_name=device_name,
            dev=dev,
            circuit=circuit,
            hass_action=HASS_ACTION.STATE,
        ),
        message.payload,
    )

    # Send to websocket
    value = 1 if message.payload == _settings().MQTT_PAYLOAD_ON else 0
    logger.info(
        f"Push to output {dev}, {circuit}, {value}", extra={"kind": LOG_KIND.WEBSOCKET}
    )
    asyncio.run(_ws_trigger(dev, circuit, value))
```

This snippet essentially details all actions that occur for incoming events from the MQTT broker (originating from home assistant):

- the message is logged
- the message topic is checked to ensure whether we should process this message further[^7]
- the state of the I/O is updated to acknowledge to home assistant that the update went OK
- a call is issued to the websocket to do the update on the I/O

For the opposite action, a websocket event that needs to be translated to MQTT, a similar callback function is implemented.

At this point, with all of these layers of software in between, the unipi neuron unit provides the standard MQTT-based interface to home assistant.
