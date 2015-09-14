#!/bin/bash

#GPIO Cape
echo cape-bone-iio > /sys/devices/bone_capemgr.8/slots

#GPIO pins
echo bspm_P8_3_f > /sys/devices/bone_capemgr.8/slots
echo 38 > /sys/class/gpio/export
echo bspm_P8_4_f > /sys/devices/bone_capemgr.8/slots
echo 39 > /sys/class/gpio/export
echo bspm_P8_5_f > /sys/devices/bone_capemgr.8/slots
echo 34 > /sys/class/gpio/export
echo bspm_P8_6_f > /sys/devices/bone_capemgr.8/slots
echo 35 > /sys/class/gpio/export
echo bspm_P8_9_37 > /sys/devices/bone_capemgr.8/slots
echo 69 > /sys/class/gpio/export
echo bspm_P8_10_17 > /sys/devices/bone_capemgr.8/slots
echo 68 > /sys/class/gpio/export
echo bspm_P8_11_17 > /sys/devices/bone_capemgr.8/slots
echo 45 > /sys/class/gpio/export
echo bspm_P8_16_f > /sys/devices/bone_capemgr.8/slots
echo 46 > /sys/class/gpio/export
echo bspm_P8_17_f > /sys/devices/bone_capemgr.8/slots
echo 27 > /sys/class/gpio/export
echo bspm_P8_35_f > /sys/devices/bone_capemgr.8/slots
echo 8 > /sys/class/gpio/export
echo bspm_P8_15_f > /sys/devices/bone_capemgr.8/slots
echo 47 > /sys/class/gpio/export
echo bspm_P8_14_f > /sys/devices/bone_capemgr.8/slots
echo 26 > /sys/class/gpio/export
echo bspm_P8_27_f > /sys/devices/bone_capemgr.8/slots
echo 86 > /sys/class/gpio/export
echo bspm_P8_28_f > /sys/devices/bone_capemgr.8/slots
echo 88 > /sys/class/gpio/export

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