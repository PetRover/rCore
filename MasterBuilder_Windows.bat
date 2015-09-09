mkdir -p bin
mkdir -p build
cd build

cmake -DCMAKE_TOOLCHAIN_FILE=BBBToolchain_Windows.cmake ..
#cmake -DCMAKE_TOOLCHAIN_FILE=BBBToolchain_Windows.cmake -DCMAKE_VERBOSE_MAKEFILE=ON ..
make
scp ../bin/rCore root@192.168.7.2:/home/root/rover
scp ../bin/rTests root@192.168.7.2:/home/root/rover
cd ..
