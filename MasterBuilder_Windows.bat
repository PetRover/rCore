mkdir bin
mkdir build
cd build

cmake -DCMAKE_TOOLCHAIN_FILE=BBBToolchain_Windows.cmake -G "Unix Makefiles" ..
make
scp ../bin/rCore debian@192.168.1.222:/home/debian/rover
scp ../bin/rTests debian@192.168.1.222:/home/debian/rover
cd ..
