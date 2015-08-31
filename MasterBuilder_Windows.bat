mkdir -p bin
mkdir -p build
cd build

cmake -DCMAKE_TOOLCHAIN_FILE=BBBToolchain_Windows.cmake -G "Unix Makefiles" ..
make
scp ../bin/rCore root@192.168.7.2:/home/root/rover
cd ..