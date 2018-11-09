// M1>>
import QtQuick 2.12
// <<M1
import QtQuick.Window 2.0
import "common"

Window {
    width: 320
    height: 320

    visible: true
    Background {
        anchors.fill: parent

// M2>>
TableView {
    id: view
    anchors.fill: parent
    anchors.margins: 20

    rowSpacing: 5
    columnSpacing: 5

    clip: true

    model: tableModel

    delegate: cellDelegate
}
// <<M2
    }

// M3>>
Component {
    id: cellDelegate

    GreenBox {
        implicitHeight: 40
        implicitWidth: 40

        Text {
            anchors.centerIn: parent
            text: display
        }
    }
}
// <<M3
}
