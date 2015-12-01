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
    GpioPin tpos1GPIO = GpioPin(12, GpioDirection::IN);
    GpioPin tpos2GPIO = GpioPin(3, GpioDirection::IN);
    GpioPin tpos3GPIO = GpioPin(2, GpioDirection::IN);

    r12vGpio.setValue(GpioValue::HIGH);
    driveAMotor.setRampTime(100);
    driveBMotor.setRampTime(100);
    treatMotor.setRampTime(100);

    driveAMotor.setCurrentLimit(1000);
    driveBMotor.setCurrentLimit(1000);
    treatMotor.setCurrentLimit(1000);
    cameraMotor.setCurrentLimit(1000);

    driveAMotor.wake();
    driveBMotor.wake();
    treatMotor.wake();
    cameraMotor.wake();


// ==============================================================
// Wifi setup
// ==============================================================
    NetworkManager* netMan = new NetworkManager;

    netMan->initializeNewConnection("COMMANDS", ROVER_IP, APP_IP, 1024, ConnectionInitType::CONNECT, ConnectionProtocol::TCP);
    netMan->initializeNewConnection("CAMERA", ROVER_IP, APP_IP, 1025, ConnectionInitType::CONNECT, ConnectionProtocol::UDP);

#ifdef USING_CAMERA
    Camera* camera = new Camera(netMan);
    try
    {
        VLOG(2) << "Setting stream at YUYV, 640px by 480px @ 30fps";
        camera->setupStream(V4L2_PIX_FMT_MJPEG, CAMERA_RES_WIDTH, CAMERA_RES_HEIGHT, 30);
        camera->setAutoExposure(true);
    }
    catch (std::exception &exception)
    {
        LOG(WARNING) << "FAILED TO SET UP CAMERA: " << exception.what();
    }
#endif

    bool stop = false;

// ==============================================================
// Receive/Execute command loop
// ==============================================================
    NetworkChunk* sNc;
    NetworkChunk* nc = new NetworkChunk();
    while (!stop)
    {
        short cmdShortVal;
        char* cmdValue;

#ifdef USING_CAMERA
        sNc = camera->getFrameNC_BAD_TEMP_FUNC();
        if (sNc->getDataType() != DataType::NONE)
        {
            netMan->sendData("CAMERA", sNc);
//            stop = true;
        }
#endif
        if (netMan->getData("COMMANDS", nc) != ReceiveType::NODATA)
        {
            switch (nc->getDataType())
            {
                case DataType::COMMAND:
                    VLOG(2) << "Received a command chunk";
                    {
                        Command cmd = Command(nc);
                        cmdValue = cmd.getCommandData();
                        cmdShortVal = (cmdValue[2] << 8) | cmdValue[3];

                        VLOG(2) << "The command data is (as a short): " << cmdShortVal;

                        switch (cmd.getCommandType())
                        {
                            case CommandType::DRIVE_FORWARD:
                                if (cmdShortVal < 0)
                                {
                                    driveAMotor.stopMotor();
                                    driveBMotor.stopMotor();
                                }
                                else
                                {
                                    VLOG(1) << "Got a drive forwards command... driving forwards";
                                    driveAMotor.startMotor(100, MotorDirection::FORWARD);
                                    driveBMotor.startMotor(100, MotorDirection::FORWARD);
                                }
                                break;
                            case CommandType::DRIVE_BACKWARD:
                                if (cmdShortVal < 0)
                                {
                                    driveAMotor.stopMotor();
                                    driveBMotor.stopMotor();
                                }
                                else
                                {
                                    VLOG(1) << "Got a drive backwards command... driving backwards";
                                    driveAMotor.startMotor(100, MotorDirection::REVERSE);
                                    driveBMotor.startMotor(100, MotorDirection::REVERSE);
                                }
                                break;
                            case CommandType::TURN_LEFT:
                                if (cmdShortVal < 0)
                                {
                                    driveAMotor.stopMotor();
                                    driveBMotor.stopMotor();
                                }
                                else
                                {
                                    VLOG(1) << "Got a turn left command... turning left";
                                    driveAMotor.startMotor(100, MotorDirection::FORWARD);
                                    driveBMotor.startMotor(100, MotorDirection::REVERSE);
                                }
                                break;
                            case CommandType::TURN_RIGHT:
                                if (cmdShortVal < 0)
                                {
                                    driveAMotor.stopMotor();
                                    driveBMotor.stopMotor();
                                }
                                else
                                {
                                    VLOG(1) << "Got a turn right command... turning right";
                                    driveAMotor.startMotor(100, MotorDirection::REVERSE);
                                    driveBMotor.startMotor(100, MotorDirection::FORWARD);
                                }
                                break;
                            case CommandType::STOP_DRIVE:
                                VLOG(1) << "Got a stop command... stopping";
                                driveAMotor.stopMotor();
                                driveBMotor.stopMotor();
                                break;
                            case CommandType::DISPENSE_TREAT:
                                break;
                            case CommandType::START_STREAM:
                                VLOG(2) << "Got a start stream command... streaming";
#ifdef USING_CAMERA
                                camera->startStream();
#else
                                char* dataToSend = new char[500000];
                                for (int i = 0; i < 5000; i++)
                                {
                                    for (int j = 0; j < 100; j++)
                                    {
                                        dataToSend[i * 100 + j] = i+1;
                                    }
                                }
                                NetworkChunk* chunk = new NetworkChunk();
                                chunk->setDataType(DataType::CAMERA);
                                chunk->setData(dataToSend);
                                chunk->setLength(500000);
                                netMan->sendData("CAMERA", chunk);
#endif
                                break;
                        }
                    }
                    break;
                case DataType::STATUS:
                    VLOG(2) << "Received a status chunk";
                    {
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
        }else{
            VLOG(3) << "getData function returned ReceiveType::NODATA";
        }
    }
    return 0;
}