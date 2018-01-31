+++
categories = ["project"]
date = "2017-10-18T17:36:17-04:00"
description = "Simulate a robot for Third Coast Telemetry client development."
draft = false
tags = ["java", "thirdcoast", "telemetry", "frc"]
title = "Third Coast Telemetry Simulator"
weight = 0

+++

We use simulated telemetry data for client development, jar file available here [here](https://github.com/strykeforce/thirdcoast/releases).

Example of use:

```sh
$ java -jar sim-v17.0.14.jar

Creating simulated inventory...
 0: Fake Talon 54 at 5 Hz
 1: Fake Talon 57 at 3 Hz
 2: Fake Talon 39 at 5 Hz
 3: Fake Talon 45 at 1 Hz
 4: Fake Talon 13 at 4 Hz
 5: Fake Talon 52 at 3 Hz
 6: Fake Talon 16 at 2 Hz
 7: Fake Talon 46 at 2 Hz
 8: Fake Servo 0 at 1 Hz
 9: Fake Digital Input 0 at 1 Hz

Measure signals are...
Setpoint                  : SINE inv even ids
Output Current            : SINE, ampl 1000, ph 0.25
Output Voltage            : SINE, ampl 2, ph -0.25, off 2/-2 even/odd id
Encoder Position          : SAWTOOTH, inv odd ids
Encoder Velocity          : SAWTOOTH, ampl 0.1
Absolute Encoder Position : SAWTOOTH, off 2/-2 even/odd
Control Loop Error        : TRIANGLE, inv even ids
Integrator Accumulator    : TRIANGLE, ampl 50 ph 0.25
Bus Voltage               : TRIANGLE, ampl id ph 0.33 off id/-id even/odd
Forward Hard Limit Closed : SQUARE
Reverse Hard Limit Closed : SQUARE, inv
Forward Soft Limit OK     : SQUARE, ph 0.33
Reverse Soft Limit OK     : SQUARE, ph 0.33 inv
Value                     : SINE
Position                  : SAWTOOTH
Angle                     : TRIANGLE

Inventory at http://192.168.1.226:5800/v1/grapher/inventory
Inventory at http://127.0.0.1:5800/v1/grapher/inventory

Press enter to exit.
```

Javadocs are [here](https://strykeforce.github.io/thirdcoast/javadoc/).
