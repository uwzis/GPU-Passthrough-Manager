# GPU Passthrough Manager

If you ever wanted to pass through your GPU to a virtual machine and wanted to do it quickly and easily, then I have a program for all you "script kiddies" out there.

GPU Passthrough Manager is a GUI application utilizing vfio drivers to quickly load your default and VFIO drivers with just a few clicks. You can passthrough a graphics card to a virtual machine in just a few clicks.

##Requirements
###WARNING
**This program is only compatible with systems that support IOMMU/virtualization.**
- make sure you have intel VT in your bios.
- more than one graphhics device to pass through, If you load vfio drivers to your main device bad things will happen.
-Packages, 'gtk.h'
