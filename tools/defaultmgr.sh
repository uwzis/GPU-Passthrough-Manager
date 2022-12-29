#!/bin/bash
echo "Removing configuration file..."
rm /etc/modprobe.d/vfio.conf
echo "Rebuilding system images..."
INITRAM=/etc/initramfs-tools/modules
if [ -f "$INITRAM" ]; then
    update-initramfs -u
fi
MKINIT=/etc/mkinitcpio.conf
if [ -f "$MKINIT" ]; then
	mkinitcpio -P linux
fi
DRACUT=/etc/dracut.conf
if [ -f "$DRACUT" ]; then
	dracut -f
fi
