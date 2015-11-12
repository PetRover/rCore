# this one is important
SET(CMAKE_SYSTEM_NAME Linux)
#this one not so much
SET(CMAKE_SYSTEM_VERSION 1)
SET(CROSS_COMPILE TRUE)

# specify the cross compiler
include(CMakeForceCompiler)
SET(CMAKE_C_COMPILER /usr/local/linaro/arm-linux-gnueabihf/bin/arm-linux-gnueabihf-gcc)
SET(CMAKE_CXX_COMPILER /usr/local/linaro/arm-linux-gnueabihf/bin/arm-linux-gnueabihf-gcc)


SET(CMAKE_C_FLAGS "-marm -O0 -g -I." CACHE STRING "Toolchain")
SET(CMAKE_CXX_FLAGS "-marm -O0 -g -I." CACHE STRING "Toolchain")
# where is the target environment
#SET(CMAKE_SYSROOT /usr/local/linaro/arm-linux-gnueabihf/arm-linux-gnueabihf/libc)
#LINK_DIRECTORIES(/usr/local/linaro/arm-linux-gnueabihf/arm-linux-gnueabihf/libc/usr/lib/arm-linux-gnueabihf)

set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)
set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_PACKAGE ONLY)