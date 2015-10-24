//
// Created by Bryce Carter on 8/25/15.
//
#define ELPP_STL_LOGGING

#include "core.h"
#include "easylogging++.h"

INITIALIZE_EASYLOGGINGPP;
el::Logger *logger = el::Loggers::getLogger("default");

using namespace RVR;

int main(int argc, char *argv[])
{
    START_EASYLOGGINGPP(argc, argv);
    LOG(INFO) << "Starting the main Rover";
    el::Loggers::removeFlag(el::LoggingFlag::AllowVerboseIfModuleNotSpecified);

    PowerRail *motorRail = PowerManager::getRail(RAIL12V0);
    const DRV8842Motor driveAMotor = DRV8842Motor(3, 86, 88, 89, 87, 10, 81, 32, 45, 61, 77, motorRail, 2500, 125);
    const DRV8842Motor driveBMotor = DRV8842Motor(5, 46, 44, 26, 23, 47, 27, 69, 45, 61, 77, motorRail, 2500, 125);
    const DRV8842Motor treatMotor = DRV8842Motor(6, 76, 74, 75, 72, 73, 70, 78, 79, 8, 77, motorRail, 2500, 125);
    const DRV8843Motor cameraMotor = DRV8843Motor(6, 76, 4, 30, 75, 72, 73, 70, 67, 68, 31, 77, motorRail, 1750, 250);


    return 0;
}