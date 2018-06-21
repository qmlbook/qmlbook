import QtQuick 2.5

Rectangle {
    id: root
    width: 64
    height: 64
    color: "#ffffff"
    border.color: Qt.darker(color, 1.2)
    property alias text: label.text
    property color fontColor: '#1f1f1f'
    Text {
        id: label
        anchors.centerIn: parent
        font.pixelSize: 14
        color: root.fontColor
    }
}
