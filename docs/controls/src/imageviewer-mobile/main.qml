import QtQuick 2.0
import QtQuick.Controls 2.4
import QtQuick.Dialogs 1.2
import QtQuick.Layouts 1.0
import QtQuick.Controls.Material 2.1

ApplicationWindow {
    
    // ...
    
    id: window

    visible: true
    width: 360
    height: 520
    title: qsTr("Image Viewer")

    Drawer {
        id: drawer

        width: Math.min(window.width, window.height) / 3 * 2
        height: window.height

        ListView {
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
                    triggered: function(){ fileOpenDialog.open(); }
                }
                ListElement {
                    text: qsTr("About...")
                    triggered: function(){ aboutDialog.open(); }
                }
            }

            ScrollIndicator.vertical: ScrollIndicator { }
        }
    }
    
    header: ToolBar {
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

    background: Rectangle {
        color: "darkGray"
    }

    Image {
        id: image
        anchors.fill: parent
        fillMode: Image.PreserveAspectFit
        smooth: true
        asynchronous: true
    }

    FileDialog {
        id: fileOpenDialog
        title: "Select an image file"
        folder: shortcuts.documents
        nameFilters: [
            "Image files (*.png *.jpeg *.jpg)",
        ]
        onAccepted: {
            image.source = fileOpenDialog.fileUrl
        }
    }

    Dialog {
        id: aboutDialog
        title: qsTr("About")
        Label {
            anchors.fill: parent
            text: qsTr("QML Image Viewer\nA part of the QmlBook\nhttp://qmlbook.org")
            horizontalAlignment: Text.AlignHCenter
        }

        standardButtons: StandardButton.Ok
    }

    // ...

}
