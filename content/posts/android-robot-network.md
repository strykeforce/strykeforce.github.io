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

Android tethering over USB looks to be the best solution for us as we can set it up using the native RNDIS network driver on the roboRIO. No installation of `adb` required.

### Addresses

The Android end of the tethered connection is hard-coded for `192.168.42.129` (see [source code][USB_NEAR_IFACE_ADDR]).

### Resources

- [Calling Android services from ADB shell](http://ktnr74.blogspot.com/2014/09/calling-android-services-from-adb-shell.html)
- [HorNDIS](http://joshuawise.com/horndis)
- [LigerBots example](https://github.com/ligerbots/Steamworks2017Vision)
- [ElementalX Kernel](https://elementalx.org)
- [SuperSU](http://www.supersu.com)
- [TWRP](https://twrp.me)

[USB_NEAR_IFACE_ADDR]: https://github.com/aosp-mirror/platform_frameworks_base/blob/marshmallow-release/services/core/java/com/android/server/connectivity/Tethering.java#L110
