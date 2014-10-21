=======
Storage
=======

.. issues:: ch12

.. sectionauthor:: `jryannel <https://bitbucket.org/jryannel>`_

This chapter will cover storing data using QtQuick in Qt5. QtQuick offers only limited ways of storing local data. In this sense it acts more like a browser. In many projects storing data is handled by the C++ backend and the required functionality is exported to the QtQuick frontend side. QtQuick does not provide you with access to the host file system to read and write files as you are used from the Qt C++ side. So it would be task of the backend engineer to write such a plugin or maybe use a network channel to communicate with a local server, which provides these capabilities.

Every application need to store smaller and larger information persistently. This can be locally on the file system or remote on a server. Some information will be structured and simple (e.g. settings), some will be large and complicated for example documentation files and some will be large and structured and will require some sort of database connection. Here we will mainly cover the built in capabilities of QtQuick to store data as also the networked ways.

.. hint::

	This chapter is about how to store data using Qt5. We hightlight the QML APIs first

	* SQL Offline Storage (http://qt-project.org/doc/qt-5.0/qtquick/qmlmodule-qtquick-localstorage2-qtquick-localstorage-2.html)
	* JsonDB (no coverage)
    * Settings (http://qt-project.org/doc/qt-5/qml-qt-labs-settings-settings.html)
    * FileAPI to store JSON data
    * SQL API via adapted Models
    * Qt-native: http://qt-project.org/doc/qt-5.0/qtdoc/topics-data-storage.html

	Then we show how to use XML to read/write data locally and also via a web-service. At then end we show a simple api to read/store your application settings.

	Maybe we should also cover the QDataStream apis to write binary data is a fast manner.

	.. todo:: Where is file access handled? labs has a file model or using a c++ plugin.
    
* Settings, Local Storage, C++ Plugins, Networked Applications, EngineIO

Storing Settings
================

Qt comes on its native side with the ``QSettings`` class, which allows you to store the application settings (aka options, pereferences) in a system dependend way. It uses the infrastructure available from your OS. Additional it supports a common INI file format for handling cross platform settings files.

In Qt 5.2 ``Settings`` have entered the QML world. The API is still in the labs module, which means the API may break in the future. So be aware.

Here is a small example, which applies a color value to a base rectangle. Everytime the user clicks on the window a new random color is generated. When the application is closed and relaunched again you should see your last color. The default color should be the color initially set on the root rectangle. 

::

    import QtQuick 2.0
    import Qt.labs.settings 1.0
    
    Rectangle {
        id: root
        width: 320; height: 240
        color: '#000000'
        Settings {
            id: settings
            property alias color: root.color
        }
        MousArea {
            anchors.fill: parent
            onClicked: root.color = Qt.hsla(Math.random(), 0.5, 0.5, 1.0);
        }
    }
    
The settings value are stored every time the value changes. This might be not always what you want. To store the settings only when required you can use standard properties.

::

    Rectangle {
        id: root
        color: settings.color
        Settings {
            id: settings
            property color color: '#000000'
        }
        function storeSettings() { // executed maybe on destruction
            settings.color = root.color
        }
    }

It is also possible to store settings into different categories using the ``category`` property.

::

    Settings {
        category: 'window'
        property alias x: window.x
        property alias y: window.x
        property alias width: window.width
        property alias height: window.height
    }
    
The settings are stored according your application name, organization and domain. This information is normally set in the main function of your c++ code.

::

    int main(int argc, char** argv) {
        ...
        QCoreApplication::setApplicationName("Awesome Application");
        QCoreApplication::setOrganizationName("Awesome Company");
        QCoreApplication::setOrganizationDomain("org.awesome");
        ...
    }


SQL
===

.. issues:: ch12

.. hint::

	* `Qt Quick Application Developer Guide for Desktop <http://qt.nokia.com/learning/guides>`_
	* :qt5:`qdeclarativeglobalobject` - Offline Storage API


JsonDB
======

.. issues:: ch12

.. hint::

	* See $QT5/qtjsondb/doc

	There will be a json db daemon to server json query request. A command line jsondb-client to make sampel quesries. The JsonDB can be used from QML and C++.
	We would need typicall CRUD operations (Create/Update/Read/Delete).


XML
===

.. issues:: ch12

.. hint::

	Not sure is this belongs here, but we should at least mention using the QXmlStreamer classes is a pretty efficient xml read/write implementation. If XML is the date wanted. Otherwise XMLListModel, XMLHttpRequest (XQuery?).

	Performance?



Settings
========

.. issues:: ch12

.. hint::

	A typical problem is to store application settings. There is currently no solution for QML (e.g. QSettings for QML) At least i'm not aware.

