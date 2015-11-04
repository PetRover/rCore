# this one is important
SET(CMAKE_SYSTEM_NAME Linux)
#this one not so much
SET(CMAKE_SYSTEM_VERSION 1)
SET(CROSS_COMPILE TRUE)

# specify the cross compiler
include(CMakeForceCompiler)
CMAKE_FORCE_C_COMPILER(arm-linux-gnueabihf-gcc GNU)
CMAKE_FORCE_CXX_COMPILER(arm-linux-gnueabihf-gcc GNU)

SET(CMAKE_C_FLAGS "-marm -O0 -g -I." CACHE STRING "Toolchain")
SET(CMAKE_CXX_FLAGS "-marm -O0 -g -I." CACHE STRING "Toolchain")

# search for programs in the build host directories
SET(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)
# for libraries and headers in the target directories
SET(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
SET(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)