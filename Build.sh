#!/bin/bash
g++ ./GPUPM.cpp -o "GPUPM" `pkg-config --cflags --libs jsoncpp  gtk+-3.0`
gcc ./tools/reboot.c -o "./tools/Reboot" `pkg-config --cflags --libs gtk+-3.0`
gcc ./tools/apphandler.c -o "gpu-passthrough-manager"
rm ./GPUPM.cpp
rm ./tools/reboot.c
rm ./tools/apphandler.c
