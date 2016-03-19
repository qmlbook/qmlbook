import QtQuick 2.5

MouseArea {
    width: 140
    height: 32
    property alias text: label.text
    Rectangle {
        anchors.fill: parent
        border.color: '#fff'
        color: parent.pressed?'#333':'#000'
    }
    Text {
        id: label
        anchors.centerIn: parent
        color: '#fff'
    }
}
