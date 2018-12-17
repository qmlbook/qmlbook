// M1>>
// Button.qml

import QtQuick 2.5

Rectangle {
    width: 90
    height: 30
    color: '#ccc'
    border.color: '#666'
    property string text
    signal clicked()
    Text {
        anchors.centerIn: parent
        text: parent.text
    }
    MouseArea {
        anchors.fill: parent
        onClicked: parent.clicked()
    }
}
// <<M1
