---
title: Using Third Coast Telemetry with Swerve Drive
description: Example code for using Stryke Force 2767 Third Coast Telemetry with a Swerve drive.
date: 2017-10-20T13:01:49.000Z
categories:
  - project
tags:
  - java
  - thirdcoast
  - frc
  - swerve
  - telemetry
draft: false
weight: 0
---

Using the Third Coast Telemetry Service and Swerve Drive together relies on configuration using [Dagger](https://google.github.io/dagger/) dependency injection. This allows for easy testing and reusable, interchangeable modules. The following code, taken from the example robot in this repository, configures the azimuth and drive Talons for monitoring.

```java
public void robotInit() {
  try {
    RobotComponent component;
    // load config file or create from default resource file in jar
    try (FileConfig toml = FileConfig.builder(CONFIG).defaultResource(DEFAULT_CONFIG).build()) {
      toml.load();
      // DaggerRobotComponent is generated from RobotComponent.java
      component = DaggerRobotComponent.builder().toml(toml.unmodifiable()).build();
    }
    swerve = component.swerveDrive();
    telemetryService = component.telemetryService();
    swerve.registerWith(telemetryService);
    telemetryService.start();
  // ...
}
```

This will set the Talon status frame update rates on the CAN bus to default values as specified in the [javadoc][javadoc] for `TelemetryService`. You can configure a higher status frame rate for one or more talons. For example to focus on the performance of talon 6 during tuning you increase the general and feedback update rates to 5 ms each with:

```java
 StatusFrameRate rates = StatusFrameRate.builder().general(5).feedback(5).build();
 telemetryService.configureStatusFrameRates(6, rates);

```

[javadoc]: https://strykeforce.github.io/thirdcoast/javadoc/
