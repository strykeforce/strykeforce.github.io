---
title: "Third Coast Telemetry"
description: "Third Coast Telemetry protocol between our grapher app written in LabView and our robot code written in Java."
date: 2017-10-17T13:53:02-04:00
categories:
  - "project"
tags:
  - "java"
  - "thirdcoast"
  - "telemetry"
  - "frc"
draft: false
weight: 0
---

Status: **DRAFT**

This is the current state of the Third Coast Telemetry protocol between our grapher app written in LabView and our robot code written in Java.

Javadocs are [here](https://strykeforce.github.io/thirdcoast/javadoc/).

### Network

The grapher and robot communicate over two network channels, one for control and one for data.

The control channel is a HTTP REST web service that listens on robot TCP port 5800.

The data channel is for one-way graph data streaming from robot to grapher and listens on grapher workstation UDP port 5555.

### Web Service Endpoints

- **`GET /v1/grapher/inventory`** - request the robot inventory, robot web service returns JSON message specified as Inventory Message below
- **`POST /v1/grapher/subscription`** - subscribe and start the data stream, subscribe JSON message sent to robot is specified as Subscribe Message below. The POST request will receive a Subscription Acknowledgement message. Data is streamed over UDP in the JSON Data Message format below.
- **`DELETE /v1/grapher/subscription`** - stop the data stream from robot to grapher.

### Interaction Diagram

The interactions between a client and the server when starting a data stream.

{{<figure src="/media/telemetry.png" title="Telemetry Interactions">}}

### Message Formats

#### Inventory Message

This message lists all items that can be graphed under the `items` key and measurements for different types of items under the `measures` key. This messages is versions to potentially invalidate grapher save files.

```json
{
  "type": "inventory",
  "items": [
    {
      "id": 0,
      "type": "TALON",
      "description": "Talon 0"
    },
    {
      "id": 1,
      "type": "SERVO",
      "description": "Servo 0"
    },
    {
      "id": 2,
      "type": "DIGITAL_INPUT",
      "description": "Digital Input 0"
    }
  ],
  "measures": [
    {
      "deviceType": "DIGITAL_INPUT",
      "deviceMeasures": [
        {
          "id": "VALUE",
          "description": "Value"
        }
      ]
    },
    {
      "deviceType": "SERVO",
      "deviceMeasures": [
        {
          "id": "ANGLE",
          "description": "Angle"
        },
        {
          "id": "POSITION",
          "description": "Position"
        }
      ]
    },
    {
      "deviceType": "TALON",
      "deviceMeasures": [
        {
          "id": "SETPOINT",
          "description": "Setpoint"
        },
        {
          "id": "OUTPUT_CURRENT",
          "description": "Output Current"
        },
        {
          "id": "OUTPUT_VOLTAGE",
          "description": "Output Voltage"
        },
        {
          "id": "ENCODER_POSITION",
          "description": "Encoder Position"
        },
        {
          "id": "ENCODER_VELOCITY",
          "description": "Encoder Velocity"
        },
        {
          "id": "ABSOLUTE_ENCODER_POSITION",
          "description": "Absolute Encoder Position"
        },
        {
          "id": "CONTROL_LOOP_ERROR",
          "description": "Control Loop Error"
        },
        {
          "id": "INTEGRATOR_ACCUMULATOR",
          "description": "Integrator Accumulator"
        },
        {
          "id": "BUS_VOLTAGE",
          "description": "Bus Voltage"
        },
        {
          "id": "FORWARD_HARD_LIMIT_CLOSED",
          "description": "Forward Hard Limit Closed"
        },
        {
          "id": "REVERSE_HARD_LIMIT_CLOSED",
          "description": "Reverse Hard Limit Closed"
        },
        {
          "id": "FORWARD_SOFT_LIMIT_OK",
          "description": "Forward Soft Limit OK"
        },
        {
          "id": "REVERSE_SOFT_LIMIT_OK",
          "description": "Reverse Soft Limit OK"
        }
      ]
    }
  ]
}
```

#### Subscribe Message

The `itemId` and `measurementId` keys correspond to `id` in the inventory message.

```json
{
  "type": "start",
  "subscription": [
    {
      "itemId": 0,
      "measurementId": "SETPOINT"
    },
    {
      "itemId": 0,
      "measurementId": "OUTPUT_CURRENT"
    },
    {
      "itemId": 1,
      "measurementId": "ANGLE"
    },
    {
      "itemId": 1,
      "measurementId": "POSITION"
    },
    {
      "itemId": 2,
      "measurementId": "VALUE"
    }
  ]
}
```

#### Subscription Acknowledgement

This message is returned as the response to the subscribe message and lists the descriptions of each measurement subscribed to.

```json
{
  "type": "subscription",
  "descriptions": [
    "Shooter Wheel Setpoint",
    "Shooter Wheel Output Current"
  ]
}
```

#### Data Message

This message is encapsulated in a UDP datagram so we want to keep this as lightweight as possible. The type` key is deprecated.

```json
{
  "data": [
    0.099998,
    8.52108,
    8.964057,
    1.01418,
    -7.885253,
    -9.401892,
    -2.115742,
    7.151332,
    9.722767,
    3.190984,
    -6.328449,
    -9.922691,
    -4.22653,
    5.426841,
    9.999177,
    5.209498
  ],
  "timestamp": 1507473896981
}
```
