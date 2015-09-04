#!/bin/bash

echo cape-bone-iio > /sys/devices/bone_capemgr.8/slots

echo bspm_P8_41_17 > /sys/devices/bone_capemgr.8/slots
echo 74 > /sys/class/gpio/export

echo 4 > /sys/class/pwm/export
