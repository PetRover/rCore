mkdir bin
mkdir build
cd build

cmake -DCMAKE_TOOLCHAIN_FILE=BBBToolchain_Windows.cmake -G "Unix Makefiles" ..
make
scp ../bin/rCore root@192.168.7.2:/root/rover
scp ../bin/rTests root@192.168.7.2:/root/rover
cd ..
