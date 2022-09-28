# Import dependencies
import sys, os
from PyQt5.QtWidgets import QApplication

# Import local dependencies
from src.gui.intro import window as introWindow

# Prevent running from imports
if __name__ == "__main__":
    if os.geteuid() == 0:
        app = QApplication(sys.argv)
        if not os.path.exists("./data.json"):
            win = introWindow()
        sys.exit(app.exec_())
    else:
        sys.exit("You must run GPU Passthrough Manager as root.")
