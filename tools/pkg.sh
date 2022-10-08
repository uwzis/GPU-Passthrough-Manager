#!/bin/bash
cd ..
echo "Setting up GPUPM"
sudo mv ./gpu-passthrough-manager /usr/share/
sudo mv /usr/share/gpu-passthrough-manager/gpu-passthrough-manager /usr/bin/
sudo mv /usr/share/gpu-passthrough-manager/icons/GPU\ Passthrough\ Manager.desktop /usr/share/applications/
echo "SETUP IS COMPLETE!"
