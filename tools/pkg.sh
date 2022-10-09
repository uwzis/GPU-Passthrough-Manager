#!/bin/bash
cd ..
echo "Setting up GPUPM"
sudo mkdir -p /usr/share/gpu-passthrough-manager
install -Dm775 ./gpu-passthrough-manager /usr/bin/gpu-passthrough-manager
install -Dm775 ./icons/GPU\ Passthrough\ Manager.desktop /usr/share/applications/GPU\ Passthrough\ Manager.desktop
install -Dm775 ./GPUPM /usr/share/gpu-passthrough-manager/GPUPM
install -Dm775 ./style.css /usr/share/gpu-passthrough-manager/style.css
install -Dm775 ./README.md /usr/share/doc/gpu-passthrough-manager/README.md
sudo mkdir -p /usr/share/gpu-passthrough-manager/tools
install -Dm775 ./tools/Reboot /usr/share/doc/gpu-passthrough-manager/tools/Reboot
install -Dm775 ./tools/defaultmgr.sh /usr/share/doc/gpu-passthrough-manager/tools/defaultmgr.sh 
install -Dm775 ./tools/fts.sh /usr/share/doc/gpu-passthrough-manager/tools/fts.sh 
install -Dm775 ./tools/vfiomgr.sh /usr/share/doc/gpu-passthrough-manager/tools/vfiomgr.sh
sudo mkdir -p /usr/share/gpu-passthrough-manager/py
install -Dm775 ./py/load.py /usr/share/doc/gpu-passthrough-manager/py/load.py
install -Dm775 ./py/confmgr.py /usr/share/doc/gpu-passthrough-manager/py/confmgr.py
sudo mkdir -p /usr/share/gpu-passthrough-manager/icons
install -Dm775 ./icons/GPUPM.png /usr/share/doc/gpu-passthrough-manager/icons/GPUPM.png
install -Dm775 ./icons/GPUPMBn.png /usr/share/doc/gpu-passthrough-manager/icons/GPUPMBn.png
install -Dm775 ./icons/GPUPM_intel.png /usr/share/doc/gpu-passthrough-manager/icons/GPUPM_intel.png
install -Dm775 ./icons/GPUPM_nvidia.png /usr/share/doc/gpu-passthrough-manager/icons/GPUPM_nvidia.png
install -Dm775 ./icons/GPUPM_radeon.png /usr/share/doc/gpu-passthrough-manager/icons/GPUPM_radeon.png
echo "SETUP IS COMPLETE!"
