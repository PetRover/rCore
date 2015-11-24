mkdir bin
mkdir build
cd build

cmake -DCMAKE_TOOLCHAIN_FILE=BBBToolchain_Windows.cmake -G "Unix Makefiles" ..
make
scp ../bin/* debian@192.168.7.2:/home/debian/rover
cd ..
