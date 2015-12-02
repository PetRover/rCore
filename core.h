//
// Created by Bryce Carter on 8/25/15.
//

#ifndef FIRMWARE_CORE_H
#define FIRMWARE_CORE_H

#include "util.h"
#include "rMotors.h"
#include "rCamera.h"
#include "linux/videodev2.h"
#include "rWifi.h"
#include "rSensors.h"
#include <stdexcept>

#define USING_CAMERA

    enum class RoverDirection
    {
        DIRECTION_A,
        DIRECTION_B
    };

     RoverDirection roverDirection;
    RVR::MotorDirection getDirection(RoverDirection rvrDirection, RVR::MotorDirection direction);

#endif //FIRMWARE_CORE_H
