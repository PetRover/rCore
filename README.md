# rCore


## Setting Up Development Invironment

### Get the Source Code
[Set up git SSH key](https://help.github.com/articles/generating-ssh-keys/)


Clone all robot firmware repos into a single folder:
```
git clone git@github.com:PetRover/rCore.git
git clone git@github.com:PetRover/rProtocols.git
git clone git@github.com:PetRover/rWifi.git
git clone git@github.com:PetRover/rSensors.git
git clone git@github.com:PetRover/rMotors.git
git clone git@github.com:PetRover/rPowerSystems.git
```

### Install IDE and Environment 

#### Windows
1. Install [Cygwin](https://cygwin.com/setup-x86_64.exe) with the default options except for adding **git** and **make** from the devel group 
2. Add the Cygwin folder to the PATH: My Computer->(Right Click)->Properties(option)->Advanced System Settings(link)->Advanced(tab)->Environment Variables(button)->System Variables(table)->Path(entry)->Add C:\cygwin64\bin
3. Install [CLion](http://download.jetbrains.com/cpp/clion-1.1.exe)
* Point the "Environment" for CLion to the cygwin folder 
* Point the "Git Executable" for CLion to the cygwin git ({cygwinfolder}\bin\git.exe) 

#### Mac
1. Install [CLion](http://download.jetbrains.com/cpp/CLion-1.1.dmg)

### Install CMake

#### Windows 
Download and run the [CMake Installer](http://www.cmake.org/files/v3.3/cmake-3.3.1-win32-x86.exe)
* During setup choose "Add CMake to system PATH for all users"

#### Mac
1. Download the [CMake App](http://www.cmake.org/files/v3.3/cmake-3.3.1-Darwin-x86_64.dmg) and add it to the Applications folder
2. Add the cmake to the PATH by adding the following lines to ~/.bashrc or ~/.bash_profile:
```shell
PATH="???:${PATH}"
export PATH
```

### Install BBB Drivers
#### Mac
* [Network](http://beagleboard.org/static/Drivers/MacOSX/RNDIS/HoRNDIS.pkg)
* [Serial](http://beagleboard.org/static/Drivers/MacOSX/FTDI/FTDI_Ser.dmg)

#### Windows
* [All](http://beagleboard.org/static/Drivers/Windows/BONE_D64.exe)

### Install Cross Compiler Toolchains 

#### Mac
Referanced from [here](http://tblog.rool.at/?p=57) *[do not follow the instructions in this link, they are for referance only]*

1. Download and install the arm cross-compiler toolchain from [this site](http://www.carlson-minot.com/downloads/arm-2014.05-29-arm-none-linux-gnueabi.osx.intelx86.bin.pkg)
2. Add the new toolchain binaries to the PATH by adding the following lines to ~/.bashrc or ~/.bash_profile:
```shell
PATH="/usr/local/carlson-minot/crosscompilers/bin:${PATH}"
export PATH
```
3. Configure IDE to run "MasterBuilder_Mac.sh"

#### Windows 
Referenced from [here](http://jkuhlm.bplaced.net/hellobone/) *[do not follow the instructions in this link, they are for referance only]*

1. Download the [linaro cross-compiler toolchain](http://releases.linaro.org/13.09/components/toolchain/binaries/gcc-linaro-arm-linux-gnueabihf-4.8-2013.09_win32.zip)
2. Extract to hard drive at {LINARO_LOCATION}
3. Add {LINARO_LOCATION}\bin to the system PATH: : My Computer->(Right Click)->Properties(option)->Advanced System Settings(link)->Advanced(tab)->Environment Variables(button)->System Variables(table)->Path(entry)->Add {LINARO_LOCATION}\bin
4. Configure IDE to run "MasterBuilder_Windows.bat"

## Advanced Features
### SSH Auth with Key
 NOTE: For mac, ssh-copy-id must be installed using ```brew install ssh-copy-id```
```shell
ssh-copy-id -i .ssh/id_rsa.pub root@192.168.7.2
```

### Internet Connection Sharing

#### Windows
1. Follow the instructions in [this video](https://www.youtube.com/watch?v=D-NEPiZDSx8)
2. Issue the following command on the beagle bone: ```echo "nameserver 8.8.8.8" >> /etc/resolv.conf``` from [here](http://robotic-controls.com/learn/beaglebone/beaglebone-internet-over-usb-only)


##Configuring Pins
###Configure which overlays are enabled/disabled on system startup
1. Go to My Computer > BeagleBone Getting Started > and open uEnv.txt. Replace the contents of uEnv.txt with: 
```
optargs=quiet capemgr.disable_partno=BB-BONELT-HDMI,BB-BONELT-HDMIN capemgr.enable_partno=BB-SPIDEV1,BB-I2C1,BB-UART2
```
2. Save the changes, reboot beaglebone black (/sbin/reboot)
3. Reconnect to BBB

###Verify setup
####Check active I2C buses
shows enabled I2C buses:
```shell
ls -al /dev/i2c*
```
####Check active SPI buses
shows enabled SPI buses:
```shell
ls -al /dev/spi*
```

####Check active UART
shows enabled UART:
```shell
ls -l /dev/ttyO*
```

####Check which capes are active
```shell
cat /sys/devices/bone_capemgr.8/slots
```
The absence of the letter "L" means that cape is disabled (L means loaded)

####Check pingroups
```shell
cat /sys/kernel/debug/pinctrl/44e10800.pinmux/pingroups
```
