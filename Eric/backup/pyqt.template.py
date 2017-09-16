#!/usr/bin/env python3

import PyQt5.QtCore as QtCore
import PyQt5.QtGui as QtGui
import PyQt5.QtQuick as QtQuick

from PyQt5.QtCore import QUrl, QObject, pyqtSlot, pyqtSignal, pyqtProperty
from PyQt5.QtGui import QGuiApplication
from PyQt5.QtQuick import QQuickView

class Slots(QObject):
    # TODO: Add slots
    # Slot template
    # @pyqtSlot(int, result=str)
    # def returnValue(self, value=None):
    #     return str(value)
    pass

if __name__ == '__main__':
    # TODO: Replace qmlfile with your mail qml program
    # qmlfile = 'test2.qml'
    
    # Initialization
    app = QGuiApplication([])
    view = QtQuick.QQuickView()

    slots = Slots()
    context = view.rootContext()
    context.setContextProperty("py", slots)

    rootObject = view.rootObject()

    view.engine().quit.connect(app.quit)
    view.setSource(QUrl(qmlfile))
    view.show()

    # End the application
    app.exec_()
