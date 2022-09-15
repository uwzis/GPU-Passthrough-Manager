#!/bin/bash
rm /etc/modprobe.d/vfio.conf
echo "deleted configuration"
mkinitcpio -p linux
echo "rebooting"
