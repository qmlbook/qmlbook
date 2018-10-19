import sys
import psutil

from PySide2.QtGui import QGuiApplication
from PySide2.QtQml import QQmlApplicationEngine, qmlRegisterType
from PySide2.QtCore import QUrl, QTimer, QAbstractListModel

from PySide2.QtCore import QObject, Signal, Slot, Property, Qt

class CpuLoadModel(QAbstractListModel):
    def __init__(self):
        QAbstractListModel.__init__(self)
        
        self._cpu_count = psutil.cpu_count()
        self._cpu_load = [0] * self._cpu_count
        
        self._updateTimer = QTimer(self)
        self._updateTimer.setInterval(1000)
        self._updateTimer.timeout.connect(self._update)
        self._updateTimer.start()
        
        # The first call returns invalid data
        psutil.cpu_percent(percpu=True)
            
    def _update(self):
        self._cpu_load = psutil.cpu_percent(percpu=True)
        self.dataChanged.emit(self.index(0,0), self.index(self._cpu_count-1, 0))
        
    def rowCount(self, parent):
        return self._cpu_count
    
    def data(self, index, role):
        if role == Qt.DisplayRole and \
            index.row() >= 0 and \
            index.row() < len(self._cpu_load) and \
            index.column() == 0:
            return self._cpu_load[index.row()]
        else:
            return None

if __name__ == '__main__':
    app = QGuiApplication(sys.argv)
    engine = QQmlApplicationEngine()
    
    qmlRegisterType(CpuLoadModel, 'PsUtils', 1, 0, 'CpuLoadModel')
    
    engine.load(QUrl("main.qml"))
    
    if not engine.rootObjects():
        sys.exit(-1)    
    
    sys.exit(app.exec_())
