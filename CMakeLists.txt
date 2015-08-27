cmake_minimum_required(VERSION 3.3)

project(rCore)

SET(EXECUTABLE_OUTPUT_PATH ../bin)

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

add_executable(rCore core.cpp)

target_link_libraries(rCore rMotors)
target_link_libraries(rCore rProtocols)
target_link_libraries(rCore rSensors)
target_link_libraries(rCore rWifi)
target_link_libraries(rCore rPowerSystems)
