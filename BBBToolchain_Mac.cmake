# this one is important
SET(CMAKE_SYSTEM_NAME Linux)
#this one not so much
SET(CMAKE_SYSTEM_VERSION 1)
SET(CROSS_COMPILE TRUE)

# specify the cross compiler
SET(CMAKE_C_COMPILER /usr/local/carlson-minot/crosscompilers/bin/arm-none-linux-gnueabi-gcc)
SET(CMAKE_CXX_COMPILER /usr/local/carlson-minot/crosscompilers/bin/arm-none-linux-gnueabi-gcc)

# where is the target environment
SET(CMAKE_FIND_ROOT_PATH  /usr/local/carlson-minot/crosscompilers/arm-none-linux-gnueabi/libc-2014.05-29-sysroot)

# search for programs in the build host directories
SET(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)
# for libraries and headers in the target directories
SET(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
SET(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)