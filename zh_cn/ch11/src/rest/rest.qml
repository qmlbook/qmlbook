import QtQuick 2.5
import "colorservice.js" as Service

Rectangle {
    width: 480
    height: 320
    color: '#000'

    ListModel {
        id: gridModel
    }
    StatusLabel {
        id: message
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.right: parent.right
    }
    GridView {
        id: view
        anchors.top: parent.top
        anchors.bottom: message.top
        anchors.left: parent.left
        anchors.right: sideBar.left
        anchors.margins: 8
        model: gridModel
        cellWidth: 64; cellHeight: 64
        delegate: Rectangle {
            width: 64; height: 64
            color: model.value
        }
    }
    Column {
        id: sideBar
        width: 160
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.right: parent.right
        anchors.margins: 8
        spacing: 8
        Button {
            text: 'Read Colors';
            onClicked: {
                Service.get_colors( function(resp) {
                    print('handle get colors resp: ' + JSON.stringify(resp))
                    gridModel.clear()
                    var entries = resp.data
                    for(var i=0; i<entries.length; i++) {
                        gridModel.append(entries[i])
                    }
                })
            }
        }
        Button {
            text: 'Create New';
            onClicked: {
                var index = gridModel.count-1
                var entry = {
                    name: 'color-' + index,
                    value: Qt.hsla(Math.random(), 0.5, 0.5, 1.0).toString()
                }
                Service.create_color(entry, function(resp) {
                    print('handle create color resp: ' + JSON.stringify(resp))
                    gridModel.append(resp)
                });
            }
        }
        Button {
            text: 'Read Last Color';
            onClicked: {
                var index = gridModel.count-1
                var name = gridModel.get(index).name
                Service.get_color(name, function(resp) {
                    print('handle get color resp:' + JSON.stringify(resp))
                    message.text = resp.value
                });
            }
        }
        Button {
            text: 'Update Last Color'
            onClicked: {
                var index = gridModel.count-1
                var name = gridModel.get(index).name
                var entry = {
                    value: Qt.hsla(Math.random(), 0.5, 0.5, 1.0).toString()
                }
                Service.update_color(name, entry, function(resp) {
                    print('handle update color resp: ' + JSON.stringify(resp))
                    var index = gridModel.count-1
                    gridModel.setProperty(index, 'value', resp.value)
                });
            }
        }
        Button {
            text: 'Delete Last Color'
            onClicked: {
                var index = gridModel.count-1
                var name = gridModel.get(index).name
                Service.delete_color(name)
                gridModel.remove(index, 1)
            }
        }
    }
}

