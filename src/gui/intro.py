# Import dependencies
from PyQt5.QtGui import *
from PyQt5.QtWidgets import *
from PyQt5.QtCore import *

# Import local dependencies
from ..setup import setup

# Define window constructor
class window(QWidget):
    def __init__(self, *args, **kwargs):
        QWidget.__init__(self, *args, **kwargs)

        # Set window contexts/values
        self.setWindowTitle("GPU Passthrough Manager")
        self.setWindowFlags(Qt.WindowCloseButtonHint | Qt.WindowMinimizeButtonHint)
        self.setWindowIcon(QIcon("GPUPM.png"))
        
        # Set layout
        self.layout = QGridLayout()

        # Initialize GUI elements
        # Title
        self.firstMessageTitle = QLabel("Welcome to GPU Passthrough Manager!", self)
        self.firstMessageTitle.setFont(QFont('default', 15))
        
        # Body
        self.firstMessageBody = QLabel("This program is used for assisting in passing through graphics/audio devices to virtual machines. To begin, click the button below to run initial compatibility checks and configuration adjustments. Once it finishes, your system will automatically reboot to apply the changes.")
        self.firstMessageBody.setFont(QFont("default", 11))
        self.firstMessageBody.setWordWrap(True)

        # Warning
        self.firstMessageWarning = QLabel("Before continuing, ensure your system supports IOMMU and virtualization is enabled in BIOS. Installation will fail if these requirements are not met, and your operating system may become unstable and/or unusable.")
        self.firstMessageWarning.setFont(QFont("default", 11, weight=QFont.Bold))
        self.firstMessageWarning.setWordWrap(True)

        # Button
        self.firstMessageButton = QPushButton("Start")
        self.firstMessageButton.setFont(QFont("default", 12))
        self.firstMessageButton.clicked.connect(self.btnstate)

        # Add GUI elements to layout
        self.layout.addWidget(self.firstMessageTitle, 0, 0)
        self.layout.addWidget(self.firstMessageBody, 1, 0)
        self.layout.addWidget(self.firstMessageWarning, 2, 0)
        self.layout.addWidget(self.firstMessageButton, 3, 0)

        # Display window
        self.setLayout(self.layout)
        self.setFixedSize(QSize(400, 300))
        self.show()

    # Button event handler
    def btnstate(self):
        self.firstMessageButton.setEnabled(False)
        setup.main(self)
