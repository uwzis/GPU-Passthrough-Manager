#!/bin/bash
cd ..
echo "Setting up GPUPM"
sudo mkdir -p /usr/share/gpu-passthrough-manager
sudo mv ./gpu-passthrough-manager /usr/bin/gpu-passthrough-manager
sudo mv ./icons/GPU\ Passthrough\ Manager.desktop /usr/share/applications/GPU\ Passthrough\ Manager.desktop
sudo mv ./GPUPM /usr/share/gpu-passthrough-manager/GPUPM
sudo mv ./style.css /usr/share/gpu-passthrough-manager/style.css
sudo mv ./README.md /usr/share/doc/gpu-passthrough-manager/README.md
sudo mkdir -p /usr/share/gpu-passthrough-manager/tools
sudo mv ./tools/Reboot /usr/share/doc/gpu-passthrough-manager/tools/Reboot
sudo mv ./tools/defaultmgr.sh /usr/share/doc/gpu-passthrough-manager/tools/defaultmgr.sh 
sudo mv ./tools/fts.sh /usr/share/doc/gpu-passthrough-manager/tools/fts.sh 
sudo mv ./tools/vfiomgr.sh /usr/share/doc/gpu-passthrough-manager/tools/vfiomgr.sh
sudo mkdir -p /usr/share/gpu-passthrough-manager/py
sudo mv ./py/load.py /usr/share/doc/gpu-passthrough-manager/py/load.py
sudo mv ./py/confmgr.py /usr/share/doc/gpu-passthrough-manager/py/confmgr.py
sudo mkdir -p /usr/share/gpu-passthrough-manager/icons
sudo mv ./icons/GPUPM.png /usr/share/doc/gpu-passthrough-manager/icons/GPUPM.png
sudo mv ./icons/GPUPMBn.png /usr/share/doc/gpu-passthrough-manager/icons/GPUPMBn.png
sudo mv ./icons/GPUPM_intel.png /usr/share/doc/gpu-passthrough-manager/icons/GPUPM_intel.png
sudo mv ./icons/GPUPM_nvidia.png /usr/share/doc/gpu-passthrough-manager/icons/GPUPM_nvidia.png
sudo mv ./icons/GPUPM_radeon.png /usr/share/doc/gpu-passthrough-manager/icons/GPUPM_radeon.png
echo "SETUP IS COMPLETE!"
