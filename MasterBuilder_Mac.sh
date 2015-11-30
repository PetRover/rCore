#!/usr/bin/env bash

mkdir -p bin
mkdir -p build
cd build

cmake -DCMAKE_TOOLCHAIN_FILE=BBBToolchain_Mac.cmake ..

make

ip=${1-text}
echo $ip
scp ../bin/* debian@${ip}:/home/debian/rover
cd ..