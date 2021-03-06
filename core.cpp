//
// Created by Bryce Carter on 8/25/15.
//
#define ELPP_STL_LOGGING

#include "core.h"
#include "easylogging++.h"

INITIALIZE_EASYLOGGINGPP;
el::Logger *logger = el::Loggers::getLogger("default");

using namespace RVR;
    // ==============================================================
// Helper functions
// ==============================================================
    MotorDirection getDirection(RoverDirection rvrDirection, MotorDirection direction)
    {
        switch (rvrDirection)
        {
            case RoverDirection::DIRECTION_A:
                switch (direction)
                {
                    case MotorDirection::FORWARD:
                        return MotorDirection::FORWARD;
                    case MotorDirection::REVERSE:
                        return MotorDirection::REVERSE;
                }
            case RoverDirection::DIRECTION_B:
                switch (direction)
                {
                    case MotorDirection::FORWARD:
                        return MotorDirection::REVERSE;
                    case MotorDirection::REVERSE:
                        return MotorDirection::FORWARD;
                }
        }
    }

    int main(int argc, char *argv[])
    {
// ==============================================================
// Globals setup
// ==============================================================

        roverDirection = RoverDirection::DIRECTION_A;
        MotorDirection cameraMoveDirection;
        Switch *nextCameraSwitch;

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
        DRV8842Motor driveAMotor = DRV8842Motor(2, 86, 81, 81, 81, 81, 81, 32, 45, 61, 77, motorRail, 2500, 125, "DRIVE_A");
        DRV8842Motor driveBMotor = DRV8842Motor(0, 46, 27, 27, 27, 27, 27, 69, 45, 61, 77, motorRail, 2500, 125, "DRIVE_B");
        DRV8842Motor treatMotor = DRV8842Motor(3, 76, 74, 75, 72, 73, 70, 78, 79, 8, 77, motorRail, 2500, 125, "TREAT");
//    DRV8843Motor cameraMotor = DRV8843Motor(88, 89, 87, 10, 75, 72, 73, 70, 67, 68, 31, 77, motorRail, 1750, 250, "CAMERA");
        GPIOStepperMotor cameraMotor = GPIOStepperMotor(44, 26, 23, 47, "CAMERA");

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
// Switches setup
// ==============================================================

        Switch camLim1Switch = Switch(50, SwitchType::GPIO_BASED);
        Switch camLim2Switch = Switch(3, SwitchType::ADC_BASED);

        Switch treatPos1Switch = Switch(2, SwitchType::ADC_BASED);
        Switch treatPos2Switch = Switch(3, SwitchType::GPIO_BASED);
        Switch treatPos3Switch = Switch(2, SwitchType::GPIO_BASED);


// ==============================================================
// Wifi setup
// ==============================================================
        NetworkManager *netMan = new NetworkManager;

    netMan->initializeNewConnectionAndConnect("COMMANDS", ROVER_IP, APP_IP, 1024, ConnectionInitType::CONNECT, ConnectionProtocol::TCP);
//    netMan->initializeNewConnectionAndConnect("HEARTBEAT", ROVER_IP, APP_IP, 1026, ConnectionInitType::CONNECT, ConnectionProtocol::TCP);
    netMan->initializeNewConnectionAndConnect("CAMERA", ROVER_IP, APP_IP, 1039, ConnectionInitType::CONNECT, ConnectionProtocol::UDP);

#ifdef USING_CAMERA
        Camera *camera = new Camera(netMan);
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
        NetworkChunk *sNc;
        NetworkChunk *nc = new NetworkChunk();
        while (!stop)
        {
            short cmdShortVal;
            char *cmdValue;

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
                                        driveAMotor.startMotor(100, getDirection(roverDirection, MotorDirection::FORWARD));
                                        driveBMotor.startMotor(100, getDirection(roverDirection, MotorDirection::FORWARD));
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
                                        driveAMotor.startMotor(100, getDirection(roverDirection, MotorDirection::REVERSE));
                                        driveBMotor.startMotor(100, getDirection(roverDirection, MotorDirection::REVERSE));
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
                                        driveAMotor.startMotor(100, getDirection(roverDirection, MotorDirection::FORWARD));
                                        driveBMotor.startMotor(100, getDirection(roverDirection, MotorDirection::REVERSE));
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
                                        driveAMotor.startMotor(100, getDirection(roverDirection, MotorDirection::REVERSE));
                                        driveBMotor.startMotor(100, getDirection(roverDirection, MotorDirection::FORWARD));
                                    }
                                    break;
                                case CommandType::STOP_DRIVE:
                                    VLOG(1) << "Got a stop command... stopping";
                                    driveAMotor.stopMotor();
                                    driveBMotor.stopMotor();
                                    break;
                                case CommandType::DISPENSE_TREAT:

                                    break;
                                case CommandType::FLIP_CAMPERA:
                                    cameraMotor.enableMotor();
                                    switch (roverDirection)
                                    {
                                        case RoverDirection::DIRECTION_A:
                                            cameraMoveDirection = MotorDirection::FORWARD;
                                            roverDirection = RoverDirection::DIRECTION_B;
                                            nextCameraSwitch = &camLim1Switch;
                                            break;
                                        case RoverDirection::DIRECTION_B:
                                            cameraMoveDirection = MotorDirection::REVERSE;
                                            roverDirection = RoverDirection::DIRECTION_A;
                                            nextCameraSwitch = &camLim2Switch;
                                            break;
                                    }
                                    for (int i = 0; i < 1000; i++)
                                    {
                                        VLOG(1) << "CAM SWTICH 1 = " << (int)camLim1Switch.getState();
                                        VLOG(1) << "CAM SWTICH 2 = " << (int)camLim2Switch.getState();
                                        if (nextCameraSwitch->getState() == SwitchState::LOW)
                                        {
                                            break;
                                        }
                                        cameraMotor.step(cameraMoveDirection);
                                        usleep(10000);
                                    }
                                    cameraMotor.disableMotor();
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

        //check rApp is still connected. If not, reconnect
//        std::chrono::duration<double> timeElapsedSinceHeartBeatSent = std::chrono::duration_cast<std::chrono::duration<double>>(std::chrono::high_resolution_clock::now() - netMan->timeOfLastHeartBeatSent);
//
//        if(timeElapsedSinceHeartBeatSent.count() * 1000000 >= 1 ) //if it's been at least one second since the heartbeat was sent
//        {
//            netMan->sendHeartBeat();
//            netMan->timeOfLastHeartBeatSent = std::chrono::high_resolution_clock::now();
//        }
//        if (netMan->checkConnectionStatus() == ConnectionStatus::NOT_CONNECTED)//TODO-when it tries to reconnects, reports address already in use
//        {
//            std::chrono::duration<double> timeElapsedSinceHeartBeatReceived = std::chrono::duration_cast<std::chrono::duration<double>>(std::chrono::high_resolution_clock::now() - netMan->timeOfLastHeartBeatReceived);
//            if (timeElapsedSinceHeartBeatReceived.count() >= 10){
//                netMan->removeConnections(); //remove existing, dead connections from list
//                netMan->initializeNewConnectionAndConnect("COMMANDS", ROVER_IP, APP_IP, 1024, ConnectionInitType::CONNECT, ConnectionProtocol::TCP);
//                netMan->initializeNewConnectionAndConnect("HEARTBEAT", ROVER_IP, APP_IP, 1026, ConnectionInitType::CONNECT, ConnectionProtocol::UDP);
//                netMan->initializeNewConnectionAndConnect("CAMERA", ROVER_IP, APP_IP, 1025, ConnectionInitType::CONNECT, ConnectionProtocol::UDP);
//
//            }
//        }
    }
    return 0;
}