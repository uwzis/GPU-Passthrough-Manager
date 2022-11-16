#!/bin/bash
echo "Removing configuration file..."
rm /etc/modprobe.d/vfio.conf
echo "Rebuilding system images..."
mkinitcpio -P linux