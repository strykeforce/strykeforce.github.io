---
title: "Third Coast Telemetry Swerve"
description: "Example code for using Third Coast Telemetry with a Swerve drive"
date: 2017-10-20T09:01:49-04:00
categories:
  - "project"
tags:
  - "java"
  - "thirdcoast"
  - "frc"
  - "swerve"
  - "telemetry"
draft: false
weight: 2
---
Using the Third Coast Telemetry Service and Swerve Drive together is simple. Put the following into `robotInit()` to configure the drive Talons for monitoring.

```java
private final TelemetryService telemetryService = new TelemetryService();
private final SwerveDrive swerve = SwerveDrive.getInstance();

@Override
public void robotInit() {
  swerve.configure(telemetryService);
  telemetryService.start();
  // ...
}
```
This will set the Talon status frame update rates on the CAN bus to default values as specified in the javadoc for `TelemetryService`.
