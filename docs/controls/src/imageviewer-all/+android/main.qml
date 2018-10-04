import QtQuick 2.0
import QtQuick.Controls 2.4
import QtQuick.Layouts 1.0
import QtQuick.Controls.Material 2.1

ImageViewerWindow {

    // ...

    id: window

    width: 360
    height: 520

    Drawer {
        id: drawer

        // ...

        width: Math.min(window.width, window.height) / 3 * 2
        height: window.height

        ListView {

            // ...

            focus: true
            currentIndex: -1
            anchors.fill: parent

            delegate: ItemDelegate {
                width: parent.width
                text: model.text
                highlighted: ListView.isCurrentItem
                onClicked: {
                    drawer.close()
                    model.triggered()
                }
            }

            model: ListModel {
                ListElement {
                    text: qsTr("Open...")
                    triggered: function(){ window.openFileDialog(); }
                }
                ListElement {
                    text: qsTr("About...")
                    triggered: function(){ window.openAboutDialog(); }
                }
            }

            // ...

            ScrollIndicator.vertical: ScrollIndicator { }
        }
    }

    header: ToolBar {

        // ...

        Material.background: Material.Orange

        RowLayout {
            anchors.fill: parent
            ToolButton {
                id: menuButton
                icon.source: "images/baseline-menu-24px.svg"
                onClicked: drawer.open()
            }
            Label {
                id: titleLabel
                text: "Image Viewer"
                font.pixelSize: 20
                elide: Label.ElideRight
                horizontalAlignment: Qt.AlignHCenter
                verticalAlignment: Qt.AlignVCenter
                Layout.fillWidth: true
            }
            Item {
                width: menuButton.width
            }
        }
    }

    // ...

}
