# rCore


## Setting Up Development Invironment

### Get the Source Code
Set up git SSH key https://help.github.com/articles/generating-ssh-keys/

Clone all robot firmware repos into a single folder:
```
git clone git@github.com:PetRover/rCore.git
git clone git@github.com:PetRover/rProtocols.git
git clone git@github.com:PetRover/rWifi.git
git clone git@github.com:PetRover/rSensors.git
git clone git@github.com:PetRover/rMotors.git
git clone git@github.com:PetRover/rPowerSystems.git
```

### Install BBB Drivers
#### Mac
* http://beagleboard.org/static/Drivers/MacOSX/RNDIS/HoRNDIS.pkg
* http://beagleboard.org/static/Drivers/MacOSX/FTDI/FTDI_Ser.dmg

#### Windows
* http://beagleboard.org/static/Drivers/Windows/BONE_D64.exe

### Set up Crosscompiler

#### Mac
Referanced from [here](http://tblog.rool.at/?p=57)

1. Download and install the arm cross-compiler toolchain from [this site](http://www.carlson-minot.com/downloads/arm-2014.05-29-arm-none-linux-gnueabi.osx.intelx86.bin.pkg)
2. Add the new toolchain binaries to the PATH by adding the folling lines to ~/.bashrc or ~/.bash_profile:
```shell
PATH="/usr/local/carlson-minot/crosscompilers/bin:${PATH}"
export PATH
```
3. Configure IDE to run "MasterBuilder_Mac.sh"
