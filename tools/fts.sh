#!/bin/bash
i=0
#Add IOMMU to GRUB conf, then make the config.
GRUB=/etc/default/grub
if [ -f "$GRUB" ]; then
	echo "IOMMU -> GRUB"
	if grep -q iommu "/etc/default/grub"
	then
		echo "IOMMU already enabled"
	else
		if grep -q GenuineIntel "/proc/cpuinfo"
		then
			echo "intel cpu detected"
			sed -i 's/GRUB_CMDLINE_LINUX_DEFAULT="/&intel_iommu=on /' /etc/default/grub
			echo "IOMMU enabled"
		else
			echo "amd cpu detected"
			sed -i 's/GRUB_CMDLINE_LINUX_DEFAULT="/&amd_iommu=on /' /etc/default/grub
			echo "IOMMU enabled"
		fi
		i=1
	fi	
	if grep -q rd.driver.pre=vfio-pci "/etc/default/grub"
	then
		echo "VFIO preload already enabled"
	else
		sed -i 's/GRUB_CMDLINE_LINUX_DEFAULT="/&rd.driver.pre=vfio-pci /' /etc/default/grub
		echo "VFIO preload enabled"
		i=1
	fi
	if [ $i -gt 0 ]; then
	echo "Updating GRUB"
	grub-mkconfig -o /boot/grub/grub.cfg
	else
		echo "GRUB already configured"
	fi
fi

	

#Add IOMMU to systemd-boot conf
SYSD=/boot/loader/loader.conf
if [ -f "$SYSD" ]; then
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
fi

x=0
#adding VFIO modules to mkinitcpio then generate conf
MKINIT=/etc/mkinitcpio.conf
if [ -f "$MKINIT" ]; then
	echo "VFIO -> mkinitcpio"
	if grep -q vfio "/etc/mkinitcpio.conf"
	then
		echo "vfio module already added"
	else
		sed -i 's/MODULES="/&vfio /' /etc/mkinitcpio.conf
		sed -i 's/MODULES=(/&vfio /' /etc/mkinitcpio.conf
		echo "added vfio module"
		x=1
	fi
	if grep -q vfio_iommu_type1 "/etc/mkinitcpio.conf"
	then
	    echo "vfio_iommu_type1 module already added"
	else	
	    sed -i 's/MODULES="/&vfio_iommu_type1 /' /etc/mkinitcpio.conf
	    sed -i 's/MODULES=(/&vfio_iommu_type1 /' /etc/mkinitcpio.conf
	    echo "added vfio_iommu_type1 module"
		x=1
	fi
	if grep -q vfio_virqfd "/etc/mkinitcpio.conf"
	then
	    echo "vfio_virqfd module already added"
	else	
	    sed -i 's/MODULES="/&vfio_virqfd /' /etc/mkinitcpio.conf
	    sed -i 's/MODULES=(/&vfio_virqfd /' /etc/mkinitcpio.conf
	    echo "added vfio_vriqfd module"
		x=1
	fi
	if grep -q vfio_pci "/etc/mkinitcpio.conf"
	then
	   echo "vfio_pci module already added"
	else	
	    sed -i 's/MODULES="/&vfio_pci /' /etc/mkinitcpio.conf
	    sed -i 's/MODULES=(/&vfio_pci /' /etc/mkinitcpio.conf
	    echo "added vfio_pci module"
		x=1
	fi
	if grep -q modconf "/etc/mkinitcpio.conf"
	then
		echo "modconf hook already added"
	else
		sed -i 's/HOOKS="/&modconf /' /etc/mkinitcpio.conf
		echo "added modconf hook"
		x=1
	fi

	if [ $x -gt 0 ]; then
		echo "updating mkinitcpio"
		mkinitcpio -p linux
	else
		echo "mkinitcpio already configured"
	fi
fi

INITRAM=/etc/initramfs-tools/modules
if [ -f "$INITRAM" ]; then
	echo "VFIO -> initramfs"
	if grep -q vfio "/etc/initramfs-tools/modules"
	then
		echo "vfio module already added"
	else
		echo "vfio" >> /etc/initramfs-tools/modules
		echo "added vfio module"
		x=1
	fi
	if grep -q vfio_iommu_type1 "/etc/initramfs-tools/modules"
	then
	    echo "vfio_iommu_type1 module already added"
	else	
	    echo "vfio_iommu_type1 " >> /etc/initramfs-tools/modules
	    echo "added vfio_iommu_type1 module"
		x=1
	fi
	if grep -q vfio_virqfd "/etc/initramfs-tools/modules"
	then
	    echo "vfio_virqfd module already added"
	else	
	    echo "vfio_virqfd" >> /etc/initramfs-tools/modules
	    echo "added vfio_vriqfd module"
		x=1
	fi
	if grep -q vfio_pci "/etc/initramfs-tools/modules"
	then
	   echo "vfio_pci module already added"
	else	
	    echo "vfio_pci" >> /etc/initramfs-tools/modules
	    echo "added vfio_pci module"
		x=1
	fi
	if [ $x -gt 0 ]; then
		echo "updating initramfs"
		update-initramfs -u
	else
		echo "initramfs already configured"
	fi
fi

# Dracut VFIO hooks
DRACUT=/etc/dracut.conf
if [ -f "$DRACUT" ]; then
	echo "Writing /etc/dracut.conf.d/10-vfio.conf..."
	echo 'force_drivers+= "vfio-pci vfio vfio_iommu_type1 vfio_virqfd"' >> /etc/dracut.conf.d/10-vfio.conf
	dracut -f
fi
