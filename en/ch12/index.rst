=======
Storage
=======

.. issues:: ch12

.. sectionauthor:: `jryannel <https://github.com/jryannel>`_

.. note::

    Last Build: |today|

    The source code for this chapter can be found in the `assets folder <../../assets>`_.


This chapter will cover storing data using Qt Quick in Qt 5. Qt Quick offers only limited ways of storing local data directly. In this sense it acts more like a browser. In many projects storing data is handled by the C++ backend and the required functionality is exported to the Qt Quick frontend side. Qt Quick does not provide you with access to the host file system to read and write files as you are used from the Qt C++ side. So it would be the task of the backend engineer to write such a plugin or maybe use a network channel to communicate with a local server, which provides these capabilities.

Every application need to store smaller and larger information persistently. This can be done locally on the file system or remote on a server. Some information will be structured and simple (e.g. settings), some will be large and complicated for example documentation files and some will be large and structured and will require some sort of database connection. Here we will mainly cover the built in capabilities of Qt Quick to store data as also the networked ways.

Settings
========

Qt comes on its native side with the C++ ``QSettings`` class, which allows you to store the application settings (aka options, preferences) in a system dependent way. It uses the infrastructure available from your OS. Additional it supports a common INI file format for handling cross platform settings files.

In Qt 5.2 ``Settings`` have entered the QML world. The API is still in the labs module, which means the API may break in the future. So be aware.

Here is a small example, which applies a color value to a base rectangle. Every time the user clicks on the window a new random color is generated. When the application is closed and relaunched again you should see your last color. The default color should be the color initially set on the root rectangle.

::

    import QtQuick 2.5
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


Local Storage - SQL
===================

.. issues:: ch12

Qt Quick supports an local storage API known from the web browsers the local storage API. the API is available under "import QtQuick.LocalStorage 2.0".

In general it stores the content into a SQLITE database in system specific location in an unique ID based file based on the given database name and version. It is not possible to list or delete existing databases. You can find the storage location from ``QQmlEngine::offlineStoragePath()``.

You use the API by first creating a database object and then creating transactions on the database. Each transaction can contain one or more SQL queries. The transaction will roll-back when a SQL query will fail inside the transaction.

For example to read from a simple notes table with a text column you could use the local storage like this::

    import QtQuick 2.5
    import QtQuick.LocalStorage 2.0

    Item {
        Component.onCompleted: {
            var db = LocalStorage.openDatabaseSync("MyExample", "1.0", "Example database", 10000);
            db.transaction( function(tx) {
                var result = tx.executeSql('select * from notes');
                for(var i = 0; i < result.rows.length; i++) {
                        print(result.rows[i].text);
                    }
                }
            });
        }
    }

.. rubric:: Crazy Rectangle

As an example assume we would like to store the position of a rectangle on our scene.


.. figure:: images/crazy_rect.png

Here our base example.

::

    import QtQuick 2.5

    Item {
        width: 400
        height: 400

        Rectangle {
            id: crazy
            objectName: 'crazy'
            width: 100
            height: 100
            x: 50
            y: 50
            color: "#53d769"
            border.color: Qt.lighter(color, 1.1)
            Text {
                anchors.centerIn: parent
                text: Math.round(parent.x) + '/' + Math.round(parent.y)
            }
            MouseArea {
                anchors.fill: parent
                drag.target: parent
            }
        }
    }

You can drag the rectangle freely around. When you close the application and launch it again the rectangle is at the same position.

Now we would like to add that the x/y position of the rectangle is stored inside the SQL DB. For this we need to add an ``init``, ``read`` and ``store`` database function. These function are called when on component completed and on component destruction.

::

    import QtQuick 2.5
    import QtQuick.LocalStorage 2.0

    Item {
        // reference to the database object
        property var db;

        function initDatabase() {
            // initialize the database object
        }

        function storeData() {
            // stores data to DB
        }

        function readData() {
            // reads and applies data from DB
        }


        Component.onCompleted: {
            initDatabase();
            readData();
        }

        Component.onDestruction: {
            storeData();
        }
    }

You could also extract the DB code in an own JS library, which does all the logic. This would be the preferred way if the logic gets more complicated.

In the database initialization function we create the DB object and ensure the SQL table is created.

::

    function initDatabase() {
        print('initDatabase()')
        db = LocalStorage.openDatabaseSync("CrazyBox", "1.0", "A box who remembers its position", 100000);
        db.transaction( function(tx) {
            print('... create table')
            tx.executeSql('CREATE TABLE IF NOT EXISTS data(name TEXT, value TEXT)');
        });
    }

The application next calls the read function to read existing data back from the database. Here we need to differentiate if there is already data in the table. To check we look into how many rows the select clause has returned.

::

    function readData() {
        print('readData()')
        if(!db) { return; }
        db.transaction( function(tx) {
            print('... read crazy object')
            var result = tx.executeSql('select * from data where name="crazy"');
            if(result.rows.length === 1) {
                print('... update crazy geometry')
                // get the value column
                var value = result.rows[0].value;
                // convert to JS object
                var obj = JSON.parse(value)
                // apply to object
                crazy.x = obj.x;
                crazy.y = obj.y;
            }
        });
    }

We expect the data is stored a JSON string inside the value column. This is not typical SQL like, but works nicely with JS code. So instead of storing the x,y as properties in the table we store them as a complete JS object using the JSON stringify/parse methods. At the end we get a valid JS object with x and y properties, which we can apply on our crazy rectangle.

To store the data, we need to differentiate the update and insert cases. We use update when a record already exists and insert if no record under the name "crazy" exists.

::

    function storeData() {
        print('storeData()')
        if(!db) { return; }
        db.transaction( function(tx) {
            print('... check if a crazy object exists')
            var result = tx.executeSql('SELECT * from data where name = "crazy"');
            // prepare object to be stored as JSON
            var obj = { x: crazy.x, y: crazy.y };
            if(result.rows.length === 1) {// use update
                print('... crazy exists, update it')
                result = tx.executeSql('UPDATE data set value=? where name="crazy"', [JSON.stringify(obj)]);
            } else { // use insert
                print('... crazy does not exists, create it')
                result = tx.executeSql('INSERT INTO data VALUES (?,?)', ['crazy', JSON.stringify(obj)]);
            }
        });
    }

Instead of selecting the whole record set we could also use the SQLITE count function like this: ``SELECT COUNT(*) from data where name = "crazy"`` which would return use one row with the amount of rows affected by the select query. Otherwise this is common SQL code. As an additional feature, we use the SQL value binding using the ``?`` in the query.

Now you can drag the rectangle and when you quit the application the database stores the x/y position and applies it on the next application run.

Other Storage APIs
==================

To store directly from within QML these are the major storage types. The real strength of Qt Quick comes from the fact to extend it with C++ to interface with your native storage systems or use the network API to interface with a remote storage system, like the Qt cloud.


