import QtQuick 2.5

Rectangle {
    id: root
    width: 480
    height: 64
    color: '#333'
    border.color: '#666'

    property alias text: label.text
    property alias iconSource: icon.source

    Image {
        id: icon
        anchors.left: parent.left
        width: height; height: parent.height
        fillMode: Image.PreserveAspectCrop
        asynchronous: true
    }
    Text {
        id: label
        anchors.left: icon.right
        anchors.right: parent.right
        anchors.margins: 8
        height: parent.height
        verticalAlignment: Text.AlignVCenter
        color: '#fff'
        font.pixelSize: 18
        elide: Text.ElideRight
    }
}
