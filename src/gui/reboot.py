# Import dependencies
from PyQt5.QtWidgets import *
from PyQt5.QtCore import *
from PyQt5.QtGui import *
import os

class rebootWindow(QWidget):
    def __init__(self):
        QWidget.__init__(self)
        
        # Set layout
        self.layout = QGridLayout()

        # Create rebooting message
        self.rebootMessage = QLabel("Configuration changes have been applied that require a reboot in order to take effect.")
        self.rebootMessage.setFont(QFont("default", 11))
        self.rebootMessage.setAlignment(Qt.AlignCenter)
        self.rebootMessage.setWordWrap(True)
        self.layout.addWidget(self.rebootMessage, 0, 0)

        # Create reboot button
        self.rebootButton = QPushButton("Reboot")
        self.rebootButton.clicked.connect(lambda: os.system("systemctl reboot -i"))
        self.layout.addWidget(self.rebootButton, 1, 0)

        # Display window
        self.setLayout(self.layout)
        self.setWindowFlag(Qt.WindowCloseButtonHint, False)
        self.setWindowFlag(Qt.WindowMaximizeButtonHint, False)
        self.setFixedHeight(100)
        self.setFixedWidth(350)
