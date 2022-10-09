#!/bin/bash

echo "Setting up GPUPM"
sudo install -Dm775 ./gpu-passthrough-manager /usr/bin/gpu-passthrough-manager
sudo install -Dm775 ./README.md /usr/share/doc/gpu-passthrough-manager/README.md
sudo mkdir -p /usr/share/gpu-passthrough-manager
sudo install -Dm775 ./icons/GPU\ Passthrough\ Manager.desktop /usr/share/applications/GPU\ Passthrough\ Manager.desktop
sudo install -Dm775 ./GPUPM /usr/share/gpu-passthrough-manager/GPUPM
sudo install -Dm775 ./style.css /usr/share/gpu-passthrough-manager/style.css
sudo mkdir -p /usr/share/gpu-passthrough-manager/tools
sudo install -Dm775 ./tools/Reboot /usr/share/gpu-passthrough-manager/tools/Reboot
sudo install -Dm775 ./tools/defaultmgr.sh /usr/share/gpu-passthrough-manager/tools/defaultmgr.sh 
sudo install -Dm775 ./tools/fts.sh /usr/share/gpu-passthrough-manager/tools/fts.sh 
sudo install -Dm775 ./tools/vfiomgr.sh /usr/share/gpu-passthrough-manager/tools/vfiomgr.sh
sudo mkdir -p /usr/share/gpu-passthrough-manager/py
sudo install -Dm775 ./py/load.py /usr/share/gpu-passthrough-manager/py/load.py
sudo install -Dm775 ./py/confmgr.py /usr/share/gpu-passthrough-manager/py/confmgr.py
sudo mkdir -p /usr/share/gpu-passthrough-manager/icons
sudo install -Dm775 ./icons/GPUPM.png /usr/share/gpu-passthrough-manager/icons/GPUPM.png
sudo install -Dm775 ./icons/GPUPMBn.png /usr/share/gpu-passthrough-manager/icons/GPUPMBn.png
sudo install -Dm775 ./icons/GPUPM_intel.png /usr/share/gpu-passthrough-manager/icons/GPUPM_intel.png
sudo install -Dm775 ./icons/GPUPM_nvidia.png /usr/share/gpu-passthrough-manager/icons/GPUPM_nvidia.png
sudo install -Dm775 ./icons/GPUPM_radeon.png /usr/share/gpu-passthrough-manager/icons/GPUPM_radeon.png
echo "SETUP IS COMPLETE!"
