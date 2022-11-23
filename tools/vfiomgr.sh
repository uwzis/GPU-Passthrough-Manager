#!/bin/bash
echo "Copying configuration file..."
cp ./vfio.conf /etc/modprobe.d/
echo "Rebuilding system images..."
INITRAM=/etc/initramfs-tools/modules
if [ -f "$INITRAM" ]; then
    update-initramfs -u
fi
MKINIT=/etc/mkinitcpio.conf
if [ -f "$MKINIT" ]; then
	mkinitcpio -P linux
fi
