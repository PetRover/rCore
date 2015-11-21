cmake_minimum_required(VERSION 3.3)

project(rCore)
SET(EXECUTABLE_OUTPUT_PATH ../bin)
SET(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++11 -lstdc++ -lm")
SET(CMAKE_VERBOSE_MAKEFILE OFF)
SET(CMAKE_BUILD_TYPE DEBUG)

IF (NOT DEFINED CROSS_COMPILE)
    SET(CROSS_COMPILE FALSE)
endif()
link_directories(/usr/lib/arm-linux-gnueabi)

# Compiler-specific C++11 activation.
if ("${CMAKE_CXX_COMPILER_ID}" MATCHES "GNU")
    execute_process(COMMAND ${CMAKE_CXX_COMPILER} -dumpversion OUTPUT_VARIABLE GCC_VERSION)
    if (NOT (GCC_VERSION VERSION_GREATER 4.7 OR GCC_VERSION VERSION_EQUAL 4.7))
        message(FATAL_ERROR "${PROJECT_NAME} requires g++ 4.7 or greater.")
    endif ()
elseif ("${CMAKE_CXX_COMPILER_ID}" MATCHES "Clang")
    set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -stdlib=libc++")
else ()
    message(FATAL_ERROR "Your C++ compiler does not support C++11.")
endif ()

add_subdirectory("./../rCamera" "rCamera")
include_directories("./../rCamera")

add_subdirectory("./../rMotors" "rMotors")
include_directories("./../rMotors")

add_subdirectory("./../rProtocols" "rProtocols")
include_directories("./../rProtocols")

add_subdirectory("./../rSensors" "rSensors")
include_directories("./../rSensors")

add_subdirectory("./../rWifi" "rWifi")
include_directories("./../rWifi")

add_subdirectory("./../rPowerSystems" "rPowerSystems")
include_directories("./../rPowerSystems")

add_subdirectory("./../rTests" "rTests")
include_directories("./../rTests")

add_executable(rCore core.cpp)

target_link_libraries(rCore rCamera)
target_link_libraries(rCore rMotors)
target_link_libraries(rCore rProtocols)
target_link_libraries(rCore rSensors)
target_link_libraries(rCore rWifi)
target_link_libraries(rCore rPowerSystems)

IF (NOT CROSS_COMPILE)
    FIND_PACKAGE(libuvc REQUIRED)
    INCLUDE_DIRECTORIES("${libuvc_INCLUDE_DIRS}")
    TARGET_LINK_LIBRARIES(rCore ${libuvc_LIBRARIES})
endif()
