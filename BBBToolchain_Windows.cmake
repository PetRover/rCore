# this one is important
SET(CMAKE_SYSTEM_NAME Linux)
#this one not so much
SET(CMAKE_SYSTEM_VERSION 1)

# specify the cross compiler
SET(CMAKE_C_COMPILER /cygdrive/c/gcc-linaro/bin/arm-linux-gnueabihf-gcc.exe)
SET(CMAKE_CXX_COMPILER /cygdrive/c/gcc-linaro/bin/arm-linux-gnueabihf-gcc.exe)

SET(CMAKE_C_FLAGS "-marm -mfloat-abi=soft -O0 -g -I.")
SET(CMAKE_CXX_FLAGS "-marm -mfloat-abi=soft -O0 -g -I.")

# search for programs in the build host directories
SET(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)
# for libraries and headers in the target directories
SET(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
SET(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)