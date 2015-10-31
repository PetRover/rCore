#!/usr/bin/env bash

mkdir -p bin
mkdir -p build
cd build

cmake -DCMAKE_TOOLCHAIN_FILE=BBBToolchain_Mac.cmake ..

make

ip=${1-text}
echo $ip
scp ../bin/rCore root@${ip}:/home/root/rover
scp ../bin/rTests root@${ip}:/home/root/rover
cd ..