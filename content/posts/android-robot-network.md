+++
categories = ["project", "reference", "tutorial"]
date = "2017-12-28T09:48:25-06:00"
description = "A reference on Android to roboRIO networking."
draft = false
tags = ["frc", "roborio", "android", "network"]
title = "Android to roboRIO Networking"
weight = 0
+++

We've looked at a couple of methods for establishing a network connection over USB between an Android vision processor and our roboRIO. Two methods are using ADB for port-mapping and using Android USB tethering. This post describes our investigation of USB tethering.

### Addresses

The Android end of the tethered connection is hard-coded for `192.168.42.129` (see [source code][USB_NEAR_IFACE_ADDR]).

[USB_NEAR_IFACE_ADDR]: https://github.com/aosp-mirror/platform_frameworks_base/blob/marshmallow-release/services/core/java/com/android/server/connectivity/Tethering.java#L110
