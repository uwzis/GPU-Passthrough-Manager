#!/bin/bash

#Add IOMMU to GRUB conf, then make the config.
if grep -q iommu "/etc/default/grub"
then
	echo "check Iommu enabled"
else
	if grep -q GenuineIntel "/proc/cpuinfo"
	then
		echo "check intel"
		sed -i 's/GRUB_CMDLINE_LINUX_DEFAULT="/&intel_iommu=on /' /etc/default/grub
	else
		echo "check amd"
		sed -i 's/GRUB_CMDLINE_LINUX_DEFAULT="/&amd_iommu=on /' /etc/default/grub
	fi
fi
grub-mkconfig -o /boot/grub/grub.cfg

#Add IOMMU to systemd-boot conf
SYSTEMD_BOOT_DEFAULT_ENTRY="/boot/loader/entries/$(awk -F " +" '/default/ {gsub(/ /, "", $2); print $2}' /boot/loader/loader.conf)"
if [ -f "$SYSTEMD_BOOT_DEFAULT_ENTRY" ]; then
    echo "$SYSTEMD_BOOT_DEFAULT_ENTRY is the default systemd-boot menu entry."

	if grep -q iommu "$SYSTEMD_BOOT_DEFAULT_ENTRY"
	then
		echo "check Iommu enabled"
	else
		if grep -q GenuineIntel "/proc/cpuinfo"
		then
			echo "check intel"
			sed -i '/^options/ s/$/ intel_iommu=on/' "$SYSTEMD_BOOT_DEFAULT_ENTRY"
		else
			echo "check amd"
			sed -i '/^options/ s/$/ amd_iommu=on/' "$SYSTEMD_BOOT_DEFAULT_ENTRY"
		fi
	fi
fi

#adding VFIO modules to mkinitcpio then generate conf
if grep -q vfio "/etc/mkinitcpio.conf"
then
	echo "check vfio"
else
	sed -i 's/MODULES="/&vfio /' /etc/mkinitcpio.conf
	echo "added vfio module"
fi
if grep -q vfio_iommu_type1 "/etc/mkinitcpio.conf"
then
    echo "check vfio_iommu_type1 module"
else	
    sed -i 's/MODULES="/&vfio_iommu_type1 /' /etc/mkinitcpio.conf
    echo "added vfio_iommu_type1 module"
fi
if grep -q vfio_virqfd "/etc/mkinitcpio.conf"
then
    echo "check vfio_virqfd module"
else	
    sed -i 's/MODULES="/&vfio_virqfd /' /etc/mkinitcpio.conf
    echo "added vfio_vriqfd module"
fi
if grep -q vfio_pci "/etc/mkinitcpio.conf"
then
    echo "check vfio_pci module"
else	
    sed -i 's/MODULES="/&vfio_pci /' /etc/mkinitcpio.conf
    echo "added vfio_pci module"
fi
if grep -q modconf "/etc/mkinitcpio.conf"
then
	echo "check modconf hook"
else
	sed -i 's/HOOKS="/&modconf /' /etc/mkinitcpio.conf
	echo "added modconf hook"
fi
echo "Rebuilding system images..."
mkinitcpio -p linux
echo "REBOOT SYSTEM"
