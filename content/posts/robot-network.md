---
title: Robot Practice Field Network
description: A reference on setting up robot networking on our home practice field.
date: 2017-10-20T14:56:12.000Z
categories:
  - reference
tags:
  - frc
  - network
draft: false
weight: 2
---

While using FRC radios in the default configuration is easy to set up, having to connect to an isolated robot access point is inconvienient during development when Internet access is required. We have installed [OpenWRT][openwrt] on the Open Mesh [OM5P-AN][om5p] used on our robots.

# Diagram

{{< figure src="/media/network/network_diagram.png" >}}

# Open Mesh OM5P-AN Radio

The radio is configured using OpenWRT as a router with its WiFi interface connecting to our shop network with static IP address `192.168.3.251` and its ethernet ports on the `10.27.67.0/24` network.

## Router

Our router is configured with a static route to the robot radio.

{{< figure src="/media/network/router_static_route.png" >}}

## Resources

Some material referenced when setting this up.

- [OpenWRT][openwrt]
- Andymark OMP5-AN [setup guide][andymark]
- Open Mesh OM5P-AN [product page][om5p]

[andymark]: http://files.andymark.com/OM5P-AN_QuickAP_Setup.pdf
[om5p]: https://wiki.openwrt.org/toh/hwdata/open-mesh/open-mesh_om5p
[openwrt]: https://openwrt.org
