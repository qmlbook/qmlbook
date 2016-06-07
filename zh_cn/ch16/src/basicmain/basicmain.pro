TEMPLATE = app
TARGET = basicmain

DEPENDPATH += .
INCLUDEPATH += .

# Use the declarative module
QT += quick

# Build outside the source tree
MOC_DIR = build/moc
RCC_DIR = build/rcc
OBJECTS_DIR = build/obj
UI_DIR = build/uic

# Input
SOURCES += main.cpp

OTHER_FILES += main.qml

RESOURCES += \
    basicmain.qrc
