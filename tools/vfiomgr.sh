#!/bin/bash
echo "Copying configuration file..."
cp ./vfio.conf /etc/modprobe.d/
echo "Rebuilding system images..."
mkinitcpio -P linux