import QtQuick 2.5
import QtQuick.Controls 1.5
import QtQuick.Window 2.2
import QtQuick.Dialogs 1.2

import org.example.io 1.0

ApplicationWindow {
    id: root
    title: qsTr("Hello World")
    width: 640
    height: 480
    visible: true

    Action {
        id: save
        text: qsTr("&Save")
        shortcut: StandardKey.Save
        onTriggered: {
            saveDocument()
        }
    }

    Action {
        id: open
        text: qsTr("&Open")
        shortcut: StandardKey.Open
        onTriggered: openDialog.open()
    }

    Action {
        id: exit
        text: qsTr("E&xit")
        onTriggered: Qt.quit();
    }

    menuBar: MenuBar {
        Menu {
            title: qsTr("&File")
            MenuItem { action: open }
            MenuItem { action: save }
            MenuSeparator {}
            MenuItem { action: exit }
        }
    }


    function readDocument() {
        io.source = openDialog.fileUrl
        io.read()
        view.model = JSON.parse(io.text)
    }

    function saveDocument() {
        var data = view.model
        io.text = JSON.stringify(data, null, 4)
        io.write()
    }

    TableView {
        id: view
        anchors.fill: parent
        TableViewColumn {
            role: 'city'
            title: "City"
            width: 120
        }
        TableViewColumn {
            role: 'country'
            title: "Country"
            width: 120
        }
        TableViewColumn {
            role: 'area'
            title: "Area"
            width: 80
        }
        TableViewColumn {
            role: 'population'
            title: "Population"
            width: 80
        }
        TableViewColumn {
            delegate: Item {
                Image {
                    anchors.centerIn: parent
                    source: 'flags/' + styleData.value
                }
            }
            role: 'flag'
            title: "Flag"
            width: 40
        }
        TableViewColumn {
            delegate: Button {
                iconSource: "remove.png"
                onClicked: {
                    var data = view.model
                    data.splice(styleData.row, 1)
                    view.model = data
                }
            }
            width: 40
        }
    }

    FileDialog {
        id: openDialog
        onAccepted: {
            root.readDocument()
        }
    }

    FileIO {
        id: io
    }

}
