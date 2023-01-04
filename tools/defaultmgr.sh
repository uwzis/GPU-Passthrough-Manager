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
update_dracut_image() {

	DISTRO=$(lsb_release -is)

	# EndeavourOS needs special command
	if [ "$DISTRO" = "EndeavourOS" ]; then

		# If user has grub
		GRUB=/etc/default/grub
		if [ -f "$GRUB" ]; then
			dracut-rebuild
		fi

		# If user has systemd-boot
		SYSD=/boot/loader/loader.conf
		if [ -f "$SYSD" ]; then
			reinstall-kernels
		fi
	
	# default way
	else 
		dracut -f
	fi 
}
if [ -f "$DRACUT" ]; then
	update_dracut_image
fi
