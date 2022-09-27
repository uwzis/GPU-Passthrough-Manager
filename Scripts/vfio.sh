#!/bin/bash
cp ./Scripts/vfio.conf /etc/modprobe.d/
echo "Config Generated"
mkinitcpio -p linux
echo "rebooting"
