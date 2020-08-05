TEMPLATE = app

QT += qml quick

CONFIG += c++11

SOURCES += main.cpp \
    dataentrymodel.cpp \
    roleentrymodel.cpp \
    dynamicentrymodel.cpp

RESOURCES += qml.qrc

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Default rules for deployment.
include(deployment.pri)

HEADERS += \
    dataentrymodel.h \
    roleentrymodel.h \
    dynamicentrymodel.h
