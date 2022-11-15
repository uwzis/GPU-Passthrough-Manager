#!/bin/bash

#Intel and amd IOMMU then make grub
if grep -q iommu "/etc/default/grub"; then
	echo "[PASS] Iommu is enabled"
else
	if grep -q GenuineIntel "/proc/cpuinfo"; then
		echo "[PASS] Intel CPU detected"
		sed -i 's/GRUB_CMDLINE_LINUX_DEFAULT="/&intel_iommu=on /' /etc/default/grub
	else
		echo "[PASS] AMD CPU detected"
		sed -i 's/GRUB_CMDLINE_LINUX_DEFAULT="/&amd_iommu=on /' /etc/default/grub
	fi
fi
grub-mkconfig -o /boot/grub/grub.cfg
#adding VFIO modules to mkinitcpio then generate conf
if grep -q vfio "/etc/mkinitcpio.conf"; then
	echo "[PASS] VFIO is enabled"
else
	sed -i 's/MODULES="/&vfio /' /etc/mkinitcpio.conf
	echo "[FAIL] VFIO is not enabled. Enabling..."
fi
if grep -q vfio_iommu_type1 "/etc/mkinitcpio.conf"; then
	echo "[PASS] VFIO_IOMMU_TYPE1 is enabled"
else
	sed -i 's/MODULES="/&vfio_iommu_type1 /' /etc/mkinitcpio.conf
	echo "[FAIL] VFIO_IOMMU_TYPE1 is not enabled. Enabling..."
fi
if grep -q vfio_virqfd "/etc/mkinitcpio.conf"; then
	echo "[PASS] vfio_virqfd module is enabled"
else
	sed -i 's/MODULES="/&vfio_virqfd /' /etc/mkinitcpio.conf
	echo "[FAIL] vfio_virqfd module is not enabled. Enabling..."
fi
if grep -q vfio_pci "/etc/mkinitcpio.conf"; then
	echo "[PASS] vfio_pci module is enabled"
else
	sed -i 's/MODULES="/&vfio_pci /' /etc/mkinitcpio.conf
	echo "[FAIL] vfio_pci module is not enabled. Enabling..."
fi
if grep -q modconf "/etc/mkinitcpio.conf"; then
	echo "[PASS] modconf hook is enabled"
else
	sed -i 's/HOOKS="/&modconf /' /etc/mkinitcpio.conf
	echo "[FAIL] modconf hook is not enabled. Enabling..."
fi
echo "Rebuilding system images..."
mkinitcpio -p linux
echo "REBOOT SYSTEM"
