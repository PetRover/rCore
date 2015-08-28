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
1. Install [Cygwin](https://cygwin.com/setup-x86_64.exe) with the default options except for adding git from the devel group
2. Add the Cygwin folder to the PATH: My Computer->(Right Click)->Properties->Advanced->Environment Variables->System Variables(Path)->Add C:\cygwin64\bin
3. Install [CLion](http://download.jetbrains.com/cpp/clion-1.1.exe)
* Point the "Enviroment" for CLion to the cygwin folder 
* Point the "Git Execuatable" for CLion to the cygwin git ({cygwinfolder}\bin\git.exe) 

#### Mac
1. Install [CLion](http://download.jetbrains.com/cpp/CLion-1.1.dmg)

### Intall CMake

#### Windows 
Download and run the [CMake Installer](http://www.cmake.org/files/v3.3/cmake-3.3.1-win32-x86.exe)
* During setup choose "Add CMake to system PATH for all users"

#### Mac
1. Download the [CMake App](http://www.cmake.org/files/v3.3/cmake-3.3.1-Darwin-x86_64.dmg) and add it to the Applications folder
2. Add the cmake to the PATH by adding the folling lines to ~/.bashrc or ~/.bash_profile:
```shell
PATH="???:${PATH}"
export PATH
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

