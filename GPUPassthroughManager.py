# Import dependencies
import sys
import os
from PyQt5.QtWidgets import QApplication, QMainWindow, QVBoxLayout, QLabel, QWidget

class window(QMainWindow):
    def __init__(self):
        super(window, self).__init__()
        
        # Set window contexts        
        self.setGeometry(50, 50, 500, 300)
        self.setWindowTitle("GPUPassthroughManager")
        self.layout = QVBoxLayout()

        # Create main GUI object
        self.mainWidget = QWidget(self)
        self.setCentralWidget(self.mainWidget)
        self.mainWidget.setLayout(self.layout)

        # Create GUI contents
        self.firstRunMessage = QLabel("Welcome to GPU Passthrough Manager")
        self.layout.addWidget(self.firstRunMessage)

        # Display window
        self.show()
        
if __name__ == "__main__":
    app = QApplication(sys.argv)
    GUI = window()
    sys.exit(app.exec_())


