
If you ever wanted to pass through your GPU to a virtual machine easily, then I have a program for all of you "script kiddies" out there.

GPU Passthrough Manager is a GUI application utilizing VFIO drivers to quickly load your default and VFIO drivers with just a few clicks. Passthrough from graphics devices to virtual machines is made easy now.

Run `Build.sh` in the program's directory to build the program. RUN GPUPM AS ROOT!
## Requirements
### !WARNING!
**This program is only compatible with systems that support IOMMU / Virtualization.**
- Make sure you have Intel `VT-d` OR `AMD Vi` enabled in your BIOS.
- More than one graphics device on the system. If you load vfio drivers to your host's main GPU, bad things will happen.

#### Dependencies
- `GTK` is required for this version. see [QT version](https://github.com/89mpxf/GPU-Passthrough-Manager-Python) by 89mpxf
- `jsoncpp`
- `python3`

## First-time configuration
Once GPUPM runs for the first time, it will prompt you to run the "first-time setup". This configures the Grub bootloader to add the IOMMU kernel parameter & adds VFIO modules to the system images. This rebuilds the Grub bootloader & system images. This is required for the program to work correctly otherwise the program will break easily.

## Documentation
GPUPM works by loading drivers to the device the user selects. Select what devices you want to pass through, then press `Load VFIO`. Restart when prompted to load the VFIO drivers on the device(s) you have selected. When the system reboots, you will have the drivers loaded. Use `lspci -k'` to verify the VFIO drivers are loaded. To load the default drivers, press the `Load Default` button to clear the config file of all devices.

The VFIO config is stored in the program's directory as `vfio.conf`. This configuration is copied to `/etc/modprobe.d/` and replaces or creates the file at that location. If you pass through to a device and your system does not boot, then you need to `chroot` into your system and delete the config file from `modprobe.d`, then rebuild your system images to make your system bootable again.

### Optimus Manager Users
For people who use laptops with dedicated or external graphics cards, GPUPM can be used with [Optimus Manager](https://github.com/Askannz/optimus-manager) to throw your graphics card off of the PCI bus. With hybrid mode, you can put it onto the BUS using integrated graphics on the host while having your GPU on the BUS running on your virtual machine. This means your laptop can have great battery life, with the capability to switch to your GPU to do rendering work.


