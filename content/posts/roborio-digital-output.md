+++
categories = ["project", "reference"]
date = "2017-11-14T13:32:11-05:00"
description = "Results from testing the digital outputs on the roboRIO."
draft = false
tags = ["frc", "roborio"]
title = "Roborio Digital Output"
weight = 0
+++

Results from testing the digital outputs on the roboRIO.

## Pulse Output
The pulse length is set with a double and is passed to the FPGA where it is used to determine the pulse length. Calling `DigitalOutput#pulse(double pulseLength)` gives the following:

- `pulseLength` = 0.25: pulse width = 144 µsec
- `pulseLength` = 0.50: pulse width =  32 µsec
- `pulseLength` = 1.00: pulse width =  64 µsec
- `pulseLength` = 2.00: pulse width = 128 µsec
- `pulseLength` = 4.00: pulse width = 256 µsec
- `pulseLength` = 8.00: pulse width = 256 µsec

Example output is show here, left to right pulses correspond to above.

{{< figure src="/media/roborio/pulse_demo.png" title="Pulse Demo" caption="Pulse lengths of 0.25, 0.5, 1.0, 2.0, 4.0, 8.0">}}

## PWM Output

PWM output from [`DigitalOutput#enablePWM(double initialDutyCycle)`](http://first.wpi.edu/FRC/roborio/release/docs/java/edu/wpi/first/wpilibj/DigitalOutput.html#enablePWM-double-) works as expected. Example output is show here, with `initialDutyCycle = 0.25`. The frequency is settable but was left at default for this example.

{{< figure src="/media/roborio/pwm_demo.png" title="PWM Demo" caption="Duty cycle set to 25%">}}
