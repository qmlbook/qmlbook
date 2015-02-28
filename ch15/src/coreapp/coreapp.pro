# build an application
TEMPLATE = app

# use the core module and do not use the gui module
QT       += core
QT       -= gui

# name of the executable
TARGET = CoreApp

# allow console output
CONFIG   += console

# for mac remove the application bundling
macx {
    CONFIG   -= app_bundle
}

# sources to be build
SOURCES += main.cpp
