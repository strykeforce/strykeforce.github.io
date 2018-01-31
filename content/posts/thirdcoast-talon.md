+++
categories = ["project"]
date = "2017-10-17T17:52:57.000Z"
description = "Library for storing any number of Talon configurations in a TOML file and applying them to Talons."
draft = false
tags = ["java", "thirdcoast", "talon", "frc"]
title = "Third Coast Talon Provisioner"
weight = 0

+++

# Talon Configurations

Third Coast provides a library for storing any number of Talon configurations in a [TOML](https://github.com/toml-lang/toml) file and applying them to Talons. If this configuration file is not present on the roboRIO in the location you specify, a default configuration file stored in the robot application JAR is copied there. See the [demonstration robot][robot] for an example of specifying a config file to use.

Javadocs are [here](https://strykeforce.github.io/thirdcoast/javadoc/).

Multiple Talon configurations can be stored in a TOML configuration file. Each configuration is an element TOML table array called `TALON` and is identified by the `name` key. An example of a Talon configuration file is:

```toml
# Third Coast Swerve Drive Talon
[[TALON]]
  name = "drive"
  mode = "Voltage"
  setpointMax    = 12.0
  currentLimit   = 50
  # remaining settings at default values

# Third Coast Swerve Azimuth Talon
[[TALON]]
  name = "azimuth"
  mode = "Position"
  brakeInNeutral = false
  forwardOutputVoltagePeak =  6.0
  reverseOutputVoltagePeak = -6.0
  # NOTE: you must provide azimuth Talon closed-loop tuning parameters below
  pGain =   0.0
  iGain =   0.0
  dGain =   0.0
  fGain =   0.0
  iZone =   0
  [TALON.encoder]
    device  = "CtreMagEncoder_Relative"
    reversed = false
```

This Talon configuration file can then be used in the Third Coast Java library to provision Talons in the robot, for example:

```java
File file = new File("/path/to/config.toml");
TalonProvisioner provisioner = new TalonProvisioner(file);
TalonConfiguration azimuthConfig = provisioner.configurationFor("azimuth");
CANTalon talon = new CANTalon(1);
azimuthConfig.configure(talon);
```

## Talon Configuration Parameter Reference

Talon parameters may apply to all or specific Talon operating modes as listed below. Unless otherwise specified, parameters are optional and have a default value show in the example for each.

### Talon Parameters Applicable to all Operating Modes

#### `name`

Each talon configuration name needs to be globally unique. This is a required parameter.

```toml
name = "drive_teleop"
```

#### `mode`

Select a control mode from the following list. Note this is case-sensitive. If not specified, defaults to `Voltage`.

- Current
- Disabled
- Follower
- MotionMagic
- MotionProfile
- PercentVbus
- Position
- Speed
- Voltage

```toml
mode = "Voltage" # default
```

#### `setpointMax`

Max input or throttle will scale to this absolute value. Units are the same at the setpoint, i.e. volts, revolutions, encoder ticks, etc... Applies to all modes. This is a required parameter for Third Coast drive motors only.

```toml
setpointMax = 0.0 # default
```

#### `currentLimit`

Limit current to specified maximum. A value of zero will disable current limit. Applies to all modes.

```toml
currentLimit = 0 # default
```

#### `brakeInNeutral`

Set to true to brake during neutral, false to coast during neutral. If not specified, defaults to true. Applies to all modes.

```toml
brakeInNeutral = true # default
```

#### `outputReversed`

Set to true to reverse motor output. If not specified, defaults to false. Applies to all modes.

```toml
output_reversed = false # default
```

#### `voltageRampRate`

Set a maximum output voltage ramp rate, in volts/sec. A value at or near zero will disable ramping (see Talon software manual section 6.4). Applies to all modes.

```toml
voltageRampRate = 0.0 # default
```

#### `velocityMeasurementPeriod`

The Velocity Measurement Sample Period is selected from the following list of pre-supported sampling periods specifed in the `CANTalon.VelocityMeasurementPeriod` enum (see Talon software manual section 7.8). If not specified, defaults to 100 ms.

- Period_1Ms
- Period_2Ms
- Period_5Ms
- Period_10Ms
- Period_20Ms
- Period_25Ms
- Period_50Ms
- Period_100Ms

```toml
velocity_measurement_period = "Period_100Ms" # default
```

#### `velocityMeasurementWindow`

The velocity measurement rolling average window is selected from a fixed list of pre-supported sample counts: [1, 2, 4, 8, 16, 32, 64]. If an alternative value is specified, it is rounded down by the CTRE API to the nearest supported value. If not specified, defaults to 64.

```toml
velocityMeasurementWindow = 64 # default
```

#### `encoder`

Encoders are defined in a sub-table of the Talon configuration. For example,

```toml
[TALON.encoder]
    device = "QuadEncoder"
    reversed = false
    unitScalingEnabled = true
    ticksPerRevolution = 1024
```

##### `device`

Select feedback device from the following list. Note this is case-sensitive. If not specified, defaults to QuadEncoder. Applies to all modes.

- AnalogEncoder
- AnalogPot
- CtreMagEncoder_Absolute
- CtreMagEncoder_Relative
- EncFalling
- EncRising
- PulseWidth
- QuadEncoder

```toml
device = "QuadEncoder" # default
```

##### `unitScalingEnabled` and `ticksPerRevolution`

Configure if unit scaling is enabled and if so, how many codes per revolution are generated by this encoder. See Talon software manual section 7.2. If not specified, Talon will use native units. Applies to all modes.

```toml
unitScalingEnabled = false # default
ticksPerRevolution = 0 # n/a if not enabled
```

#### `forwardLimitSwitch`, `reverseLimitSwitch`

Limit switches are normally-open, normally-closed, or disabled and are defined in a sub-table of the Talon configuration. If not specified, defaults to disabled. Applies to all modes. For example,

```toml
[TALON.forwardLimitSwitch]
  enabled = false # default
  normallyOpen = true # default
```

#### `forwardSoftLimit`, `reverseSoftLimit`

Soft limits are enabled and set in a sub-table of the Talon configuration. Units are the same at the setpoint, i.e. volts, ticks. Applies to all modes. For example,

```toml
[TALON.reverseSoftLimit]
  enabled = false # default
  position = 0.0 # n/A if not enabled
```

### Talon Parameters Applicable to Closed-loop Operating Modes

#### PIDF, I-zone

Closed-loop motor tuning parameters.

```toml
pGain =   0.0 # defaults
iGain =   0.0
dGain =   0.0
fGain =   0.0
iZone =   0
```
#### `allowableClosedLoopError`

Within this error range, PID gains are zero, F still in effect. Units are mA for current, talon native units for position and velocity. If not specified, defaults to zero. Applies to closed-loop modes.

```toml
allowableClosedLoopError = 0 # default
```

#### `forwardOutputVoltageNominal`, `reverseOutputVoltageNominal`

Output magnitude between zero and this value is set to this value. If not specified, defaults to zero. Applies to closed-loop modes.

```toml
forwardOutputVoltageNominal = 0.0 # defaults
reverseOutputVoltageNominal = 0.0
```

#### `forwardOutputVoltagePeak`, `reverseOutputVoltagePeak`

Output voltage will be limited to this value. If not specified, defaults to no limit. Applies to closed-loop modes.

```toml
forwardOutputVoltagePeak = 12.0 # defaults
reverseOutputVoltagePeak = -12.0
```

#### `nominalClosedLoopVoltage`

When set, the output of the Closed Loop mode is compensated for the measured battery voltage. Set to zero to disable. If not specified, defaults to disabled. Applies to closed-loop modes.

```toml
nominalClosedLoopVoltage = 0.0 # default
```

#### `outputVoltageMax`

Set the maximum voltage that the Talon will ever output. This can be used to limit the maximum output voltage (positive or negative) in closed-loop modes so that motors which cannot withstand full bus voltage can be used safely. If not specified, defaults to no limit.  Applies to closed-loop modes.

```toml
outputVoltageMax = 12.0 # default
```

[robot]: https://github.com/strykeforce/thirdcoast/tree/master/robot
