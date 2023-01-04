#!/bin/bash

# Get this script's directory
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

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
source $SCRIPT_DIR/dracut-utils
if [ -f "$DRACUT" ]; then
	update_dracut_image
fi