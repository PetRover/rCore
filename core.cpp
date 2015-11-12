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
// ==============================================================
// Logging setup
// ==============================================================
    START_EASYLOGGINGPP(argc, argv);
    LOG(INFO) << "Starting the main Rover";
    el::Loggers::removeFlag(el::LoggingFlag::AllowVerboseIfModuleNotSpecified);

// ==============================================================
// Motors setup
// ==============================================================
    PowerRail *motorRail = PowerManager::getRail(RAIL12V0);
    DRV8842Motor driveAMotor = DRV8842Motor(0, 86, 88, 89, 87, 10, 81, 32, 45, 61, 77, motorRail, 2500, 125, "DRIVE_A");
    DRV8842Motor driveBMotor = DRV8842Motor(2, 46, 44, 26, 23, 47, 27, 69, 45, 61, 77, motorRail, 2500, 125, "DRIVE_B");
    DRV8842Motor treatMotor = DRV8842Motor(3, 76, 74, 75, 72, 73, 70, 78, 79, 8, 77, motorRail, 2500, 125, "TREAT");
    DRV8843Motor cameraMotor = DRV8843Motor(3, 76, 1, 30, 75, 72, 73, 70, 67, 68, 31, 77, motorRail, 1750, 250, "CAMERA");

    GpioPin r12vGpio = GpioPin(14, GpioDirection::OUT);
    r12vGpio.setValue(GpioValue::HIGH);
    driveAMotor.setRampTime(100);
    driveBMotor.setRampTime(100);
    treatMotor.setRampTime(100);

    driveAMotor.setCurrentLimit(1000);
    driveBMotor.setCurrentLimit(1000);
    treatMotor.setCurrentLimit(1000);

    driveAMotor.wake();
    driveBMotor.wake();
    treatMotor.wake();


// ==============================================================
// Wifi setup
// ==============================================================
    NetworkManager* netMan = new NetworkManager;
    netMan->initializeNewConnection("COMMANDS", "192.168.1.2", 1024, ConnectionInitType::CONNECT);
    bool stop = false;

// ==============================================================
// Receive/Execute command loop
// ==============================================================
    NetworkChunk* nc = new NetworkChunk;
    while (!stop)
    {
        *nc = netMan->getData("COMMANDS");
        switch (nc->getDataType()){
            case DataType::COMMAND:
                VLOG(2) << "Received a command chunk";
                {//extra brackets needed for scoping
                    Command cmd = Command(*nc);
                    switch (cmd.getCommandType())
                    {
                        case CommandType::DRIVE_FORWARD:
                            driveAMotor.stopMotor();
                            driveBMotor.stopMotor();
                            VLOG(1) << "Got a drive forwards command... driving forwards";
                            driveAMotor.startMotor(100, MotorDirection::FORWARD);
                            driveBMotor.startMotor(100, MotorDirection::FORWARD);
//                            stop = true;
                            break;
                        case CommandType::DRIVE_BACKWARD:
                            driveAMotor.stopMotor();
                            driveBMotor.stopMotor();
                            VLOG(1) << "Got a drive backwards command... driving backward";
                            driveAMotor.startMotor(100, MotorDirection::REVERSE);
                            driveBMotor.startMotor(100, MotorDirection::REVERSE);
//                            stop = true;
                            break;
                        case CommandType::TURN_LEFT:
                            driveAMotor.stopMotor();
                            driveBMotor.stopMotor();
                            VLOG(1) << "Got a turning left command... turning left";
                            driveAMotor.startMotor(100, MotorDirection::FORWARD);
                            driveBMotor.startMotor(75, MotorDirection::FORWARD);
//                            stop = true;
                            break;
                        case CommandType::TURN_RIGHT:
                            driveAMotor.stopMotor();
                            driveBMotor.stopMotor();
                            VLOG(1) << "Got a turning right command... turning right";
//                            driveAMotor.startMotor(90, MotorDirection::REVERSE);
                            driveBMotor.startMotor(100, MotorDirection::FORWARD);
//                            stop = true;
                            break;
                        case CommandType::STOP_DRIVE:
                            VLOG(1) << "Got a stop command... stopping";
                            driveAMotor.stopMotor();
                            driveBMotor.stopMotor();
//                            stop = true;
                            break;
                    }
                }
                break;
            case DataType::STATUS:
                VLOG(2) << "Received a status chunk";
                { //extra brackets needed for scoping
                    Status stat = Status(*nc);
                    switch (stat.getStatusType())
                    {
                        case StatusType::CHARGING:
                            VLOG(1) << "Got a charging status";
                            stop = true;
                            break;
                        case StatusType::NOT_CHARGING:
                            VLOG(1) << "Got a not charging status";
                            stop = true;
                            break;
                    }
                    break;
                }
            case DataType::CAMERA:
                VLOG(2) << "Received a camera chunk";
                // Not yet implemented
                break;
            case DataType::TEXT:
                VLOG(2) << "Received a text chunk";
                // Code
                break;
            case DataType::NONE:
                VLOG(2) << "Received a chunk of type NONE";
                // Not yet implemented
                break;
        }
        usleep(100000);
    }


    return 0;
}