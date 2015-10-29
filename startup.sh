#!/bin/bash

#Analog Input Pins (enables all AIN pins)
echo cape-bone-iio > /sys/devices/bone_capemgr.8/slots

#GPIO pins
echo rover_board_rev1 > /sys/devices/bone_capemgr.8/slots

#P8_8
echo 67 > /sys/class/gpio/export

#P8_9
echo 69 > /sys/class/gpio/export

#P8_10
echo 68 > /sys/class/gpio/export

#P8_11
echo 45 > /sys/class/gpio/export

#P8_12
echo 44 > /sys/class/gpio/export

#P8_13
echo 23 > /sys/class/gpio/export

#P8_14
echo 26 > /sys/class/gpio/export

#P8_15
echo 47 > /sys/class/gpio/export

#P8_16
echo 46 > /sys/class/gpio/export

#P8_17
echo 27 > /sys/class/gpio/export

#P8_25
echo 32 > /sys/class/gpio/export

#P8_26
echo 61 > /sys/class/gpio/export

#P8_27
echo 86 > /sys/class/gpio/export

#P8_28
echo 88 > /sys/class/gpio/export

#P8_29
echo 87 > /sys/class/gpio/export

#P8_30
echo 89 > /sys/class/gpio/export

#P8_31
echo 10 > /sys/class/gpio/export

#P8_34
echo 81 > /sys/class/gpio/export

#P8_35
echo 8 > /sys/class/gpio/export

#P8_36
echo 80 > /sys/class/gpio/export

#P8_37
echo 78 > /sys/class/gpio/export

#P8_38
echo 79 > /sys/class/gpio/export

#P8_39
echo 76 > /sys/class/gpio/export

#P8_40
echo 77 > /sys/class/gpio/export

#P8_41
echo 74 > /sys/class/gpio/export

#P8_42
echo 75 > /sys/class/gpio/export

#P8_43
echo 72 > /sys/class/gpio/export

#P8_44
echo 73 > /sys/class/gpio/export

#P8_45
echo 70 > /sys/class/gpio/export

#P8_46
echo 71 > /sys/class/gpio/export

#P9_11
echo 30 > /sys/class/gpio/export

#P9_12
echo 60 > /sys/class/gpio/export

#P9_13
echo 31 > /sys/class/gpio/export

#P9_14
echo 50 > /sys/class/gpio/export

#P9_15
echo 48 > /sys/class/gpio/export

#P9_19
echo 13 > /sys/class/gpio/export

#P9_20
echo 12 > /sys/class/gpio/export

#P9_21
echo 3 > /sys/class/gpio/export

#P9_22
echo 2 > /sys/class/gpio/export

#P9_23
echo 49 > /sys/class/gpio/export

#P9_24
echo 15 > /sys/class/gpio/export

#P9_25
echo 117 > /sys/class/gpio/export

#P9_26
echo 14 > /sys/class/gpio/export

#P9_27
echo 115 > /sys/class/gpio/export

#P9_41
echo 20 > /sys/class/gpio/export

#P9_42
echo 7 > /sys/class/gpio/export

#PWM
echo am33xx_pwm > /sys/devices/bone_capemgr.8/slots

echo 4 > /sys/class/pwm/export #9_16
echo 5 > /sys/class/pwm/export #8_19
echo 6 > /sys/class/pwm/export #8_46
echo 3 > /sys/class/pwm/export #8_36

echo bone_pwm_P8_19 > /sys/devices/bone_capemgr.8/slots
echo bone_pwm_P9_16 > /sys/devices/bone_capemgr.8/slots
echo bone_pwm_P8_46 > /sys/devices/bone_capemgr.8/slots
echo bone_pwm_P8_36 > /sys/devices/bone_capemgr.8/slots

# DEFAULT PWM FREQUENCY = 100kHz (AND 50% Duty Cycle)
echo 10000 > /sys/class/pwm/pwm3/period_ns
echo 5000 > /sys/class/pwm/pwm3/duty_ns
echo 10000 > /sys/class/pwm/pwm4/period_ns
echo 5000 > /sys/class/pwm/pwm4/duty_ns
echo 10000 > /sys/class/pwm/pwm5/period_ns
echo 5000 > /sys/class/pwm/pwm5/duty_ns
echo 10000 > /sys/class/pwm/pwm6/period_ns
echo 5000 > /sys/class/pwm/pwm6/duty_ns

#SPI
echo BB-SPIDEV1 > /sys/devices/bone_capemgr.8/slots

#I2C
echo BB-I2C1 > /sys/devices/bone_capemgr.8/slots