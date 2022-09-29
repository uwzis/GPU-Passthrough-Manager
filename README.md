# GPU Passthrough Manager (Python)
[GPU Passthrough Manager](https://github.com/uwzis/GPU-Passthrough-Manager) by [uwzis](https://github.com/uwzis) is a graphical interface utility to aid in passing through graphics devices to virtual machines. This version of GPU Passthrough Manager aims to match/exceed the functionality of the original, while being written in Python instead of C. Whereas the original program is designed for GTK, this program is designed for Qt. At some point in the future, this program will support both GTK and Qt.

**This program is only compatible with systems that support IOMMU/virtualization.**
## Documentation
### Requirements
GPU Passthrough Manager (Python) requires the following:
- `PyQt5` pip package (installed to all users)
- Python3 (tested on Python 3.10, unsure of earliest compatible version)
- A system that has Intel VT-d/AMD-Vi **supported and enabled**

### First time configuration
Upon running GPU Passthrough Manager for the first time, you will be prompted to begin first time setup. In essence, and in the following order, first time setup:
- Configures Grub bootloader to pass IOMMU kernel parameter.
  - If you have an Intel CPU, this will add `intel_iommu=on` to the `GRUB_CMDLINE_LINUX_DEFAULT` line in `/etc/default/grub`.
  - If you have an AMD CPU, this will add `amd_iommu=on` to the `GRUB_CMDLINE_LINUX_DEFAULT` line in `/etc/default/grub`.
- Rebuilds Grub bootloader
- Modify `/etc/mkinitcpio.conf` to load VFIO drivers.
  - Adds `vfio`, `vfio_iommu_type1`, `vfio_virqfd`, and `vfio_pci` to `MODULES` line.
  - Adds `modconf` to `HOOKS` line.
- Rebuilds system images
- Reboots the system

If you have already previously configured VFIO drivers, or wish to do it manually, you can bypass first time setup by manually creating the `data.json` file in the programs' root directory.
  
### How to load VFIO drivers
Once you have completed first time setup, or manually configured VFIO, you are ready to begin using GPU Passthrough manager and passing through devices. To pass through devices, follow these steps:
1. Select the devices you wish to pass through. **Make sure to select the corresponding audio device(s) to the selected video device(s).**
2. Once all the devices you wish to pass through are selected, click the `Load VFIO` button in the bottom right.
3. Wait for GPU Passthrough Manager to load the driver and reboot your system.

GPU Passthrough Manager creates a temporary `vfio.conf` file in the root directory of the program. **The contents of this file will reset everytime GPU Passthrough Manager is run.** PCI device IDs are automatically added to or removed from this file as they are selected/unselected within the program. This ensures only valid configuration files can be applied amd allows the `Load VFIO` button to do the following (in order):
- Copy the temporary `vfio.conf` to `/etc/modprobe.d/` 
- Rebuild system images
- Reboot the system

### How to unload VFIO drivers / load default drivers
To restore the original functionality of passed through devices, simply click the `Load Default` button in the bottom left of the GPU Passthrough Manager menu. Unlike loading VFIO drivers, loading the default drivers does not require device selection; the `Load Default` button does the following:
- Deletes `/etc/modprobe.d/vfio.conf`
- Rebuild system images
- Reboot the systemcooper.violette
