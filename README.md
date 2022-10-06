# GPU Passthrough Manager

If you ever wanted to pass through your GPU to a virtual machine and wanted to do it quickly and easily, then I have a program for all you "script kiddies" out there.

GPU Passthrough Manager is a GUI application utilizing vfio drivers to quickly load your default and VFIO drivers with just a few clicks. You can passthrough a graphics card to a virtual machine in just a few clicks.

Run `Build.sh` to build the program.
## Requirements
### !WARNING!
**This program is only compatible with systems that support IOMMU/virtualization.**
- make sure you have Intel VT-d or AMD Vi in your bios.
- more than one graphics device on the system. If you load vfio drivers to your host's main GPU, bad things will happen.
- `GTK` is required for this version. see [QT version](https://github.com/89mpxf/GPU-Passthrough-Manager-Python) by 89mpxf
- 
## First time configuration
Once GPUPM is ran for the first time, it will prompt you run the first time setup. This Configures Grub bootloader to pass IOMMU kernel parameter and adds VFIO modules. This rebuilds Grub bootloader and rebuilds system images. This required for the program to work right or things will really break. 
## Documentaion
GPUPM works by loading drivers to the device the user selects. Select what devices you want to pass through, then press `Load VFIO`. Then restart when prompted to load the vfio drivers on the devices you have selected. When system is rebooted, you will have the drivers loaded. use `lspci -k | grep -E 'Audio device|VGA'` to verify the vfio drivers are loaded. To load the defualt drivers, press the `Load Default` button to clear the config file of all devices.

The vfio config is stored at the programs directory as `vfio.conf`. This configuration is copied to `/etc/modprobe.d/` and replaces or creates the file there. If you pass through a device and your system does not boot, then you need to `chroot` into your system and delete the config file from modprobe.d, then rebuild your system images.

#### Optimus Manager Users
