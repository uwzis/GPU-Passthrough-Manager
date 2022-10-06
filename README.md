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
The
