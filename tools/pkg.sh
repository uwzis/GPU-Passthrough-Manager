#!/bin/bash
cd ..
echo "Setting up GPUPM"
sudo mv -r ./gpu-passthrough-manager /usr/share/
cd /usr/share/gpu-passthrough-manager/
sudo mv ./gpu-passthrough-manager /usr/bin/
sudo mv ./icons/GPU\ Passthrough\ Manager.desktop /usr/share/applications/
echo "SETUP IS COMPLETE!"
