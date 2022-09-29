# Import dependencies
import json
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
            self.layout.addWidget(button, i, 0)

        # Display window
        self.setLayout(self.layout)
        self.setFixedSize(QSize(400, 300))
        self.show()
    
    # Button press handler
    def buttonManager(self):
        for i in range(len(self.devices)):
            if self.devices[i]["name"] == self.sender().text():
                print(f'{self.devices[i]["id"]} | {self.sender().isChecked()}')
