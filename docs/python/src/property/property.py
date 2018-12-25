import sys
import random

from PySide2.QtGui import QGuiApplication
from PySide2.QtQml import QQmlApplicationEngine
from PySide2.QtCore import QUrl

from PySide2.QtCore import QObject, Signal, Slot, Property

class NumberGenerator(QObject):
    def __init__(self):
        QObject.__init__(self)
        self.__number = 42
        self.__max_number = 99
    
    @Slot()
    def updateNumber(self):
        self.__set_number(random.randint(0, self.__max_number))

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
        
        if self.__max_number != val:
            self.__max_number = val
            self.maxNumberChanged.emit()
            
        if self.__number > self.__max_number:
            self.__set_number(self.__max_number)
    
    def get_max_number(self):
        return self.__max_number

    maxNumber = Property(int, get_max_number, set_max_number, notify=maxNumberChanged)
    
    # number
    
    numberChanged = Signal(int)
    
    def __set_number(self, val):
        if self.__number != val:
            self.__number = val;
            self.numberChanged.emit(self.__number)
    
    def get_number(self):
        return self.__number
    
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
    
