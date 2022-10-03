# Import dependencies
from PyQt5.QtGui import *
from PyQt5.QtWidgets import *
from PyQt5.QtCore import *

# Import local dependencies
from .gui.reboot import rebootWindow

class prompt(object):
    def rebootPrompt(self):        
        self.subWindow=QMdiSubWindow()
        self.subWindow.setWindowIcon(QIcon("GPUPM.png"))
        self.subWindow.setWindowFlags(Qt.WindowCloseButtonHint | Qt.WindowMinimizeButtonHint)
        self.subWindow.setFixedSize(QSize(350, 100))
        self.subWindow.setWidget(rebootWindow())
        self.subWindow.show()
