TEMPLATE = app
TARGET = 

DEPENDPATH += .
INCLUDEPATH += .

# Use the declarative module
QT += declarative

# Build outside the source tree
MOC_DIR = build/moc
RCC_DIR = build/rcc
OBJECTS_DIR = build/obj
UI_DIR = build/uic

# Input
HEADERS += stockimageprovider.h
SOURCES += main.cpp stockimageprovider.cpp

OTHER_FILES += main.qml
