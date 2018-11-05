import sys
import random

from PySide2.QtGui import QGuiApplication
from PySide2.QtQml import QQmlApplicationEngine
from PySide2.QtCore import QUrl

from PySide2.QtCore import QObject, Signal, Slot, Property

class NumberGenerator(QObject):
    def __init__(self):
        QObject.__init__(self)
        self._number = 42
        self._max_number = 99
    
    @Slot()
    def updateNumber(self):
        self._set_number(random.randint(0, self._max_number))

    # maxNumber

    @Signal
    def maxNumberChanged(self):
        pass

    @Slot(int)
    def setMaxNumber(self, val):
        self.set_max_number(val)

    def set_max_number(self, val):
        if val < 0:
            val = 0
        
        if self._max_number != val:
            self._max_number = val
            self.maxNumberChanged.emit()
            
        if self._number > self._max_number:
            self._set_number(self._max_number)
    
    def get_max_number(self):
        return self._max_number

    maxNumber = Property(int, get_max_number, set_max_number, notify=maxNumberChanged)
    
    # number
    
    numberChanged = Signal(int)
    
    def __set_number(self, val):
        if self._number != val:
            self._number = val;
            self.numberChanged.emit(self._number)
    
    def get_number(self):
        return self._number
    
    number = Property(int, get_number, notify=numberChanged)


if __name__ == '__main__':
    app = QGuiApplication(sys.argv)
    engine = QQmlApplicationEngine()
    
    number_generator = NumberGenerator()
    engine.rootContext().setContextProperty("numberGenerator", number_generator)
    
    engine.load(QUrl("main.qml"))
    
    if not engine.rootObjects():
        sys.exit(-1)    
    
    sys.exit(app.exec_())

    # ...
    
