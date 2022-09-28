# Import dependencies
import os, re

class setup(object):
    def main(self):
        print("Beginning first time setup...")

        # Add IOMMU flag to grub
        print("Opening grub configuration...")
        if "iommu" in open("/etc/default/grub", "r").read():
            print("IOMMU already in Grub configuration. Skipping...")
        else:
            print("Checking CPU...")
            if "GenuineIntel" in open("/proc/cpuinfo", "r").read():
                print("Intel CPU found. Enabling Intel IOMMU in bootloader...")
                os.system("sed -i 's/GRUB_CMDLINE_LINUX_DEFAULT=" + '"/&intel_iommu=on /' + "' /etc/default/grub")
            else:
                print("AMD CPU found. Enabling AMD IOMMU in bootloader...")
                os.system("sed -i 's/GRUB_CMDLINE_LINUX_DEFAULT=" + '"/&amd_iommu=on /' + "' /etc/default/grub")

        # Build updated bootloader configuration
        print("Building new Grub bootloader configuration...")
        os.system("grub-mkconfig -o /boot/grub/grub.cfg")
        print("Grub configuration updated successfully.")

        # Add VFIO/IOMMU modules to mkinitcpio.conf
        print("Appending required modules/hooks to mkinitcpio.conf...")
        conf = open("/etc/mkinitcpio.conf","r").read()
        for mod in ["vfio", "vfio_iommu_type1", "vfio_virqfd", "vfio_pci"]:
            if mod in conf:
                print(f"Module {mod} already configured. Skipping...")
            else:
                print(f"Adding {mod} module to mkinitcpio.conf...")
                os.system("sed -i 's/MODULES=" + f'"/&{mod} /' + "' /etc/mkinitcpio.conf")

        # Add modconf hook to mkinitcpio.conf
        if "modconf" in conf:
            print(f"Modconf hook already configured. Skipping...")
        else:
            print("Adding modconf hook to mkinitcpio.conf...")
            os.system("sed -i 's/HOOKS=" + '"/&modconf /' + "' /etc/mkinitcpio.conf")

        # Rebuild system images
        print("Rebuilding system images...")
        os.system("mkinitcpio -p linux")
        print("Setup completed. Rebooting...")
        os.system("systemctl reboot -i")
