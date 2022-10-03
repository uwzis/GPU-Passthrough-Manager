# Import dependencies
import os

# Import local dependencies
from .prompt import prompt

class DriverManager(object):
    def main(self, mode = None):
        if mode is not None and mode.lower() in ["vfio", "default"]:
            if mode.lower() == "vfio":
                print("Copying configuration file...")
                os.system("cp ./vfio.conf /etc/modprobe.d/")
            elif mode.lower() == "default":
                print("Removing configuration file...")
                os.system("rm /etc/modprobe.d/vfio.conf")
            print("Rebuilding system images...")
            os.system("mkinitcpio -P linux")
            print("Prompting user for reboot...")
            prompt.rebootPrompt(self)
        else:
            print("Invalid argument (vfio or default)")
