#!/bin/bash
cd ..
echo "Setting up GPUPM"
sudo mkdir /usr/share/gpu-passthrough-manager/
sudo mv ./gpu-passthrough-manager /usr/share/gpu-passthrough-manager
sudo mv /usr/share/gpu-passthrough-manager/gpu-passthrough-manager /usr/bin/
sudo mv /usr/share/gpu-passthrough-manager/icons/GPU\ Passthrough\ Manager.desktop /usr/share/applications/
echo "SETUP IS COMPLETE!"
