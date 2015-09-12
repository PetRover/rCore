#!/bin/bash

#GPIO Cape
echo cape-bone-iio > /sys/devices/bone_capemgr.8/slots

#GPIO pins
echo bspm_P8_41_17 > /sys/devices/bone_capemgr.8/slots
echo 74 > /sys/class/gpio/export

#PWM
echo am33xx_pwm > /sys/devices/bone_capemgr.8/slots

echo 1 > /sys/class/pwm/export #9_21
echo 3 > /sys/class/pwm/export #9_14
echo 4 > /sys/class/pwm/export #9_16
echo 5 > /sys/class/pwm/export #8_19
echo 6 > /sys/class/pwm/export #8_13

echo bone_pwm_P8_13 > /sys/devices/bone_capemgr.8/slots #DRIVE_A_IN1
echo bone_pwm_P8_19 > /sys/devices/bone_capemgr.8/slots #MTR_TREAT_IN1
echo bone_pwm_P9_14 > /sys/devices/bone_capemgr.8/slots #MTR_CAM_AIN1
echo bone_pwm_P9_16 > /sys/devices/bone_capemgr.8/slots #DRIVE_B_IN1
echo bone_pwm_P9_21 > /sys/devices/bone_capemgr.8/slots #MTR_CAM_BIN1

echo 1000000 > /sys/class/pwm/pwm1/period_ns
echo 500000 > /sys/class/pwm/pwm1/duty_ns
echo 1000000 > /sys/class/pwm/pwm3/period_ns
echo 500000 > /sys/class/pwm/pwm3/duty_ns
echo 1000000 > /sys/class/pwm/pwm4/period_ns
echo 500000 > /sys/class/pwm/pwm4/duty_ns
echo 1000000 > /sys/class/pwm/pwm5/period_ns
echo 500000 > /sys/class/pwm/pwm5/duty_ns
echo 1000000 > /sys/class/pwm/pwm6/period_ns
echo 500000 > /sys/class/pwm/pwm6/duty_ns