# Import dependencies
import json
from PyQt5.QtGui import *
from PyQt5.QtWidgets import *
from PyQt5.QtCore import *

# Import local dependencies
from ..tools.confmgr import main as confmgr
from ..drivermgr import DriverManager as drivermgr

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

        # Load device data
        fs = open("./data.json", "r")
        data = json.load(fs)
        self.devices = data["devices"]
        fs.close()

        # Dynamically create GUI elements
        for i in range(len(self.devices)):
            button = QPushButton(self.devices[i]["name"])
            button.setCheckable(True)
            button.clicked.connect(self.buttonManager)
            self.layout.addWidget(button, i, 0, 1, 2)

        # Create load default button
        button = QPushButton("Load Default")
        button.clicked.connect(self.buttonManager)
        self.layout.addWidget(button, len(self.devices), 0, 1, 1)

        # Create load VFIO button
        button = QPushButton("Load VFIO")
        button.clicked.connect(self.buttonManager)
        self.layout.addWidget(button, len(self.devices), 1, 1, 1)

        # Display window
        self.setLayout(self.layout)
        self.setFixedSize(QSize(400, (80 + (len(self.devices) * 25))))
        self.show()
    
    # Button press event handler
    def buttonManager(self):
        if self.sender().text() == "Load VFIO":
            drivermgr.main(self, "vfio")
        elif self.sender().text() == "Load Default":
            drivermgr.main(self, "default")
        else:
            for i in range(len(self.devices)):
                if self.devices[i]["name"] == self.sender().text():
                    if self.sender().isChecked():
                        confmgr("./vfio.conf", "add", self.devices[i]["id"])
                    else:
                        confmgr("./vfio.conf", "remove", self.devices[i]["id"])
