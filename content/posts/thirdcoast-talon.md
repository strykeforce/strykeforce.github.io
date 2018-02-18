+++
categories = ["project"]
date = "2018-02-18T06:52:57.000Z"
description = "Library for storing any number of Talon configurations in a TOML file and applying them to Talons."
draft = false
tags = ["java", "thirdcoast", "talon", "frc"]
title = "Third Coast Talon Provisioner"
weight = 0
+++

# Talon Configurations

**Note:** This library has seen some major changes as a result of the upgrade to CTRE Phoenix Toolkit in 2018.

Third Coast provides a library for storing any number of TalonSRX configurations in a [TOML](https://github.com/toml-lang/toml) file and applying them to Talons. If this configuration file is not present on the roboRIO in the location you specify, a default configuration file stored in the robot application JAR is used. See the [demonstration robot][robot] for an example of specifying a config file to use.

Javadocs are [here](https://strykeforce.github.io/thirdcoast/javadoc/) and source code is in [GitHub](https://github.com/strykeforce/thirdcoast).

Multiple TalonSRX configurations, each with up to four closed-loop parameter slots, can be stored in a TOML configuration file. Each configuration is an element of the `TALON` table array. An actual example of our swerve TalonSRX configurations is:

```toml
# Third Coast Swerve Drive configuration, PID parameters TBD for hardware
[[TALON]]
  name = "azimuth"
  talonIds = [0, 1, 2, 3]
  [TALON.selectedFeedbackSensor]
    feedbackDevice = "CTRE_MagEncoder_Relative"
  [TALON.currentLimit]
    continuous   = 0
    peak         = 0
    peakDuration = 0
  [TALON.motionMagic]
    acceleration   = 0
    cruiseVelocity = 0
  [[TALON.closedLoopProfile]] # slot 0 MotionMagic
    pGain = 0.0
    iGain = 0.0
    dGain = 0.0
    fGain = 0.0
    iZone = 0
    allowableClosedLoopError = 0

[[TALON]]
 name = "drive"
 talonIds = [10, 11, 12, 13]
 [TALON.selectedFeedbackSensor]
   feedbackDevice = "CTRE_MagEncoder_Relative"
 [TALON.output]
   neutralMode = "Brake"
 [TALON.currentLimit]
   continuous   = 40
   peak         = 0
   peakDuration = 0
 [[TALON.closedLoopProfile]] # slot 0 Velocity Low
   pGain = 0.0
   iGain = 0.0
   dGain = 0.0
   fGain = 0.0
   iZone = 0
   maxIntegralAccumulator   = 0
   allowableClosedLoopError = 0
 [[TALON.closedLoopProfile]] # slot 1 Velocity High
   pGain = 0.0
   iGain = 0.0
   dGain = 0.0
   fGain = 0.0
   iZone = 0
   allowableClosedLoopError = 0
```

At startup, this file is read and used to provision the Talons indicated by `talonIds`. References to the configured `TalonSRX` are simply obtained from the `Talons` object by:

```java
Talons talons = new Talons(new Settings(tomlString));
TalonSRX talon = talons.getTalon(10);
talon.set(ControlMode.Velocity, 10_000);
```

## Talon Configuration Parameters and Defaults

We've provided a sensible (at least to us) default setting for each of the TalonSRX parameters as show below.

```toml
[[TALON]]
  name = "DEFAULT"
  talonIds = []

  [TALON.selectedFeedbackSensor]
    feedbackDevice = "QuadEncoder"
    pidIdx = 0
    phaseSensor = false

  [TALON.limitSwitch.forward]
    source = "Deactivated"
    normal = "Disabled"

  [TALON.limitSwitch.reverse]
    source = "Deactivated"
    normal = "Disabled"

  [TALON.softLimit.forward]
    limit = 0
    enabled = false

  [TALON.softLimit.reverse]
    limit = 0
    enabled = false

  [TALON.currentLimit]
    continuous = 0
    peak = 0
    peakDuration = 0

  [TALON.velocityMeasurement]
    period = "Period_100Ms"
    window = 32

  [TALON.output]
    neutralDeadband = 0.04
    inverted = false
    neutralMode = "Coast"

    [TALON.output.forward]
      peak = 1.0
      nominal = 0.0

    [TALON.output.reverse]
      peak = -1.0
      nominal = 0.0

    [TALON.output.rampRates]
      openLoop = 0.0
      closedLoop = 0.0

    [TALON.output.voltageCompensation]
      saturation = 12.0
      enabled = true
      measurementFilter = 32

  [TALON.motionMagic]
    acceleration = 0
    cruiseVelocity = 0

  [[TALON.closedLoopProfile]]
    pGain = 0.0
    iGain = 0.0
    dGain = 0.0
    fGain = 0.0
    iZone = 0
    maxIntegralAccumulator = 1.7976931348623157E308
    allowableClosedLoopError = 0

  [[TALON.closedLoopProfile]]
    pGain = 0.0
    iGain = 0.0
    dGain = 0.0
    fGain = 0.0
    iZone = 0
    maxIntegralAccumulator = 1.7976931348623157E308
    allowableClosedLoopError = 0

  [[TALON.closedLoopProfile]]
    pGain = 0.0
    iGain = 0.0
    dGain = 0.0
    fGain = 0.0
    iZone = 0
    maxIntegralAccumulator = 1.7976931348623157E308
    allowableClosedLoopError = 0

  [[TALON.closedLoopProfile]]
    pGain = 0.0
    iGain = 0.0
    dGain = 0.0
    fGain = 0.0
    iZone = 0
    maxIntegralAccumulator = 1.7976931348623157E308
    allowableClosedLoopError = 0
```

[robot]: https://github.com/strykeforce/thirdcoast/tree/master/robot
