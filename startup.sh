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

echo bspm_P8_14_f > /sys/devices/bone_capemgr.8/slots
echo 26 > /sys/class/gpio/export

echo bspm_P8_15_f > /sys/devices/bone_capemgr.8/slots
echo 47 > /sys/class/gpio/export

echo bspm_P8_16_f > /sys/devices/bone_capemgr.8/slots
echo 46 > /sys/class/gpio/export

echo bspm_P8_17_f > /sys/devices/bone_capemgr.8/slots
echo 27 > /sys/class/gpio/export

echo bspm_P8_18_2f > /sys/devices/bone_capemgr.8/slots
echo 65 > /sys/class/gpio/export

echo bspm_P8_20_37 > /sys/devices/bone_capemgr.8/slots
echo 63 > /sys/class/gpio/export

echo bspm_P8_21_2f > /sys/devices/bone_capemgr.8/slots
echo 62 > /sys/class/gpio/export

echo bspm_P8_23_17 > /sys/devices/bone_capemgr.8/slots
echo 36 > /sys/class/gpio/export

echo bspm_P8_24_2f > /sys/devices/bone_capemgr.8/slots
echo 33 > /sys/class/gpio/export

echo bspm_P8_25_37 > /sys/devices/bone_capemgr.8/slots
echo 32 > /sys/class/gpio/export

echo bspm_P8_26_2f > /sys/devices/bone_capemgr.8/slots
echo 61 > /sys/class/gpio/export

echo bspm_P8_27_f > /sys/devices/bone_capemgr.8/slots
echo 86 > /sys/class/gpio/export

echo bspm_P8_28_f > /sys/devices/bone_capemgr.8/slots
echo 88 > /sys/class/gpio/export

echo bspm_P8_29_f > /sys/devices/bone_capemgr.8/slots
echo 87 > /sys/class/gpio/export

echo bspm_P8_30_f > /sys/devices/bone_capemgr.8/slots
echo 89 > /sys/class/gpio/export

echo bspm_P8_33_17 > /sys/devices/bone_capemgr.8/slots
echo 9 > /sys/class/gpio/export

echo bspm_P8_34_2f > /sys/devices/bone_capemgr.8/slots
echo 81 > /sys/class/gpio/export

echo bspm_P8_35_f > /sys/devices/bone_capemgr.8/slots
echo 8 > /sys/class/gpio/export

echo bspm_P8_36_f > /sys/devices/bone_capemgr.8/slots
echo 80 > /sys/class/gpio/export

echo bspm_P8_39_17 > /sys/devices/bone_capemgr.8/slots
echo 76 > /sys/class/gpio/export

echo bspm_P8_40_37 > /sys/devices/bone_capemgr.8/slots
echo 77 > /sys/class/gpio/export

echo bspm_P8_41_2f > /sys/devices/bone_capemgr.8/slots
echo 74 > /sys/class/gpio/export

echo bspm_P8_42_f > /sys/devices/bone_capemgr.8/slots
echo 75 > /sys/class/gpio/export

echo bspm_P8_43_f > /sys/devices/bone_capemgr.8/slots
echo 72 > /sys/class/gpio/export

echo bspm_P8_44_f > /sys/devices/bone_capemgr.8/slots
echo 73 > /sys/class/gpio/export

echo bspm_P8_45_f > /sys/devices/bone_capemgr.8/slots
echo 70 > /sys/class/gpio/export

echo bspm_P8_46_f > /sys/devices/bone_capemgr.8/slots
echo 71 > /sys/class/gpio/export

echo bspm_P9_11_7 > /sys/devices/bone_capemgr.8/slots
echo 30 > /sys/class/gpio/export

echo bspm_P9_12_17 > /sys/devices/bone_capemgr.8/slots
echo 60 > /sys/class/gpio/export

echo bspm_P9_13_7 > /sys/devices/bone_capemgr.8/slots
echo 31 > /sys/class/gpio/export

echo bspm_P9_15_f > /sys/devices/bone_capemgr.8/slots
echo 48 > /sys/class/gpio/export

echo bspm_P9_19_f > /sys/devices/bone_capemgr.8/slots
echo 13 > /sys/class/gpio/export

echo bspm_P9_20_f > /sys/devices/bone_capemgr.8/slots
echo 12 > /sys/class/gpio/export

echo bspm_P9_22_f > /sys/devices/bone_capemgr.8/slots
echo 2 > /sys/class/gpio/export

echo bspm_P9_23_17 > /sys/devices/bone_capemgr.8/slots
echo 49 > /sys/class/gpio/export

echo bspm_P9_25_27 > /sys/devices/bone_capemgr.8/slots
echo 117 > /sys/class/gpio/export

echo bspm_P9_27_f > /sys/devices/bone_capemgr.8/slots
echo 115 > /sys/class/gpio/export

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