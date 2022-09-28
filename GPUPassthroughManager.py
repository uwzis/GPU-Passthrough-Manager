# Import dependencies
import sys, os
from PyQt5.QtGui import *
from PyQt5.QtWidgets import *
from PyQt5.QtCore import *

# Define window constructor
class window(QWidget):
    def __init__(self, *args, **kwargs):
        QWidget.__init__(self, *args, **kwargs)

        # Set window contexts/values
        self.setWindowTitle("GPU Passthrough Manager")
        self.setWindowFlags(Qt.WindowCloseButtonHint | Qt.WindowMinimizeButtonHint)
        
        # Set layout
        self.layout = QGridLayout()

        # Initialize GUI elements
        # Title
        self.firstMessageTitle = QLabel("Welcome to GPU Passthrough Manager!", self)
        self.firstMessageTitle.setFont(QFont('default', 15))
        
        # Body
        self.firstMessageBody = QLabel("This program is used for assisting in passing through graphics/audio devices to virtual machines. To begin, click the button below to run initial compatibility checks and configuration adjustments.")
        self.firstMessageBody.setFont(QFont("default", 11))
        self.firstMessageBody.setWordWrap(True)

        # Button
        self.firstMessageButton = QPushButton("Start")
        self.firstMessageButton.setFont(QFont("default", 12))

        # Add GUI elements to layout
        self.layout.addWidget(self.firstMessageTitle, 0, 0)
        self.layout.addWidget(self.firstMessageBody, 1, 0)
        self.layout.addWidget(self.firstMessageButton, 2, 0)

        # Display window
        self.setLayout(self.layout)
        self.setFixedSize(QSize(400, 175))
        self.show()

# Prevent running from imports
if __name__ == "__main__":
    if os.geteuid() == 0:
        app = QApplication(sys.argv)
        win = window()
        sys.exit(app.exec_())
    else:
        sys.exit("You must run GPU Passthrough Manager as root.")
