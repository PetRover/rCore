//
// Created by Bryce Carter on 8/25/15.
//
#define ELPP_STL_LOGGING

#include "easylogging++.h"

INITIALIZE_EASYLOGGINGPP;
el::Logger *logger = el::Loggers::getLogger("default");

int main(int argc, char *argv[])
{
    START_EASYLOGGINGPP(argc, argv);
    LOG(INFO) << "Starting the main Rover";
    el::Loggers::removeFlag(el::LoggingFlag::AllowVerboseIfModuleNotSpecified);

    return 0;
}