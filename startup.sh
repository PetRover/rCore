#!/bin/bash

#Analog Input Pins (enables all AIN pins)
#echo BB-ADC > /sys/devices/platform/bone_capemgr/slots

#GPIO pins
mkdir /sys/kernel/config/device-tree/overlays/rover_board_rev1
cat /lib/firmware/rover_board_rev1-00A0.dtbo > /sys/kernel/config/device-tree/overlays/rover_board_rev1/dtbo

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

#SPI
#echo BB-SPIDEV1 > /sys/devices/platform/bone_capemgr/slots

#I2C
#echo BB-I2C1 > /sys/devices/platform/bone_capemgr/slots

#PWM
#to ensure PWMs are exported (occassional issues), each is tried until it exports (up to 300 times)
for i in {1..100000}
do
    echo "Trying for the $i time to export pwmchip0/pwm0"
    echo 0 > /sys/class/pwm/pwmchip0/export #9_16
    [ -a /sys/class/pwm/pwmchip0/pwm0 ] && echo "pwmchip0/pwm0 is exported" && break
done

for i in {1..100000}
do
    echo "Trying for the $i time to export pwmchip0/pwm1"
    echo 1 > /sys/class/pwm/pwmchip0/export #8_46
    [ -a /sys/class/pwm/pwmchip0/pwm1 ] && echo "pwmchip0/pwm1 is exported" && break
done

for i in {1..100000}
do
    echo "Trying for the $i time to export pwmchip2/pwm0"
    echo 0 > /sys/class/pwm/pwmchip2/export #8_36
    [ -a /sys/class/pwm/pwmchip2/pwm0 ] && echo "pwmchip2/pwm0 is exported" && break
done

for i in {1..100000}
do
    echo "Trying for the $i time to export pwmchip2/pwm1"
    echo 1 > /sys/class/pwm/pwmchip2/export #8_19
    [ -a /sys/class/pwm/pwmchip2/pwm1 ] && echo "pwmchip2/pwm1 is exported" && break
done

# DEFAULT PWM FREQUENCY = 100kHz (AND 50% Duty Cycle)
echo 10000 > /sys/class/pwm/pwmchip0/pwm0/period
echo 5000 > /sys/class/pwm/pwmchip0/pwm0/duty_cycle
echo 10000 > /sys/class/pwm/pwmchip0/pwm1/period
echo 5000 > /sys/class/pwm/pwmchip0/pwm1/duty_cycle
echo 10000 > /sys/class/pwm/pwmchip2/pwm0/period
echo 5000 > /sys/class/pwm/pwmchip2/pwm0/duty_cycle
echo 10000 > /sys/class/pwm/pwmchip2/pwm1/period
echo 5000 > /sys/class/pwm/pwmchip2/pwm1/duty_cycle

#start main program (rCore)
sleep 5
./home/debian/rover/rCore