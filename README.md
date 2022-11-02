# GPU Passthrough Manager

[![Showcase Video](https://img.youtube.com/vi/ttMAGxJ4pUo/0.jpg)](https://youtu.be/ttMAGxJ4pUo)

If you ever wanted to pass through your GPU to a virtual machine and wanted to do it quickly and easily, then I have a program for all of you "script kiddies" out there.

GPU Passthrough Manager is a GUI application utilizing vfio drivers to quickly load your default and VFIO drivers with just a few clicks. passthrough a graphics devices to virtual machines is made easy now.

Run `Build.sh` in the program's directory to build the program. RUN GPUPM AS ROOT!
## Requirements
### !WARNING!
**This program is only compatible with systems that support IOMMU / Virtualization.**
- make sure you have Intel VT-d or AMD Vi enabled in your bios.
- more than one graphics device on the system. If you load vfio drivers to your host's main GPU, bad things will happen.
#### Dependencies
- `gtk` is required for this version. see [QT version](https://github.com/89mpxf/GPU-Passthrough-Manager-Python) by 89mpxf
- `jsoncpp`
- `python3`

## First time configuration
Once GPUPM is runs for the first time, it will prompt you to run the first time setup. This Configures Grub bootloader to add IOMMU kernel parameter and adds VFIO modules to the system images. This rebuilds Grub bootloader and rebuilds system images. This is required for the program to work right or things will really break. 

## Documentation
GPUPM works by loading drivers to the device the user selects. Select what devices you want to pass through, then press `Load VFIO`. Then restart when prompted to load the vfio drivers on the devices you have selected. When the system is rebooted, you will have the drivers loaded. use `lspci -k'` to verify the vfio drivers are loaded. To load the default drivers, press the `Load Default` button to clear the config file of all devices.

The vfio config is stored at the programs directory as `vfio.conf`. This configuration is copied to `/etc/modprobe.d/` and replaces or creates the file there. If you pass through a device and your system does not boot, then you need to `chroot` into your system and delete the config file from modprobe.d, then rebuild your system images to make your system bootable again..

#### Optimus Manager Users
For people who use laptops with dedicated or external graphics cards, GPUPM can be used with [Optimus Manager](https://github.com/Askannz/optimus-manager) to throw your graphics card off of the pci bus. With hybrid mode, you can put it onto the bus using integrated graphics on the host while having your GPU on the bus to running in your virtual machine. This means your laptop has great battery life, with the capability to switch to your GPU to do rendering work on.


