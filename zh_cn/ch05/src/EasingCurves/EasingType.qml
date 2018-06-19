import QtQuick 2.5

Rectangle {
    id: root
    width: 100
    height: 100
    clip: true
    property real value: 0.0
    property int pointCount: 100
    property string title
    signal clicked()

    property alias easingType: anim.easing.type


    Image {
        anchors.fill: parent
        source: "blueprint.jpg"
    }

    Rectangle {
        anchors.fill: view
        anchors.leftMargin: -8
        anchors.rightMargin: -8
        color: 'transparent'
        border.color: "#53d769"
        border.width: 4
        opacity: 0.5

    }


    NumberAnimation {
        id: anim
        target: root
        property: 'value'
        from: 0
        to: 1
        duration: 2000
    }

    ListModel {
        id: valueModel
    }

    AnimationController {
        id: controller
        animation: anim
        Component.onCompleted: {
            valueModel.clear()
            for(var i=0; i<root.pointCount; i++) {
                progress = i/root.pointCount
                valueModel.append({value: root.value})
            }
        }
    }

    PathView {
        id: view
        anchors.fill: parent
        anchors.topMargin: root.height*0.2
        anchors.bottomMargin: root.height*0.2
        model: valueModel
        pathItemCount: root.pointCount
        delegate: Item {
            width: 4; height: 4
            Rectangle {
                width: parent.width; height: width; radius: width/2
                y: -model.value*view.height
                color: "#ff8800"
                border.color: Qt.lighter(color, 1.2)
                opacity: 0.5
            }
        }
        path: Path {
            startX: 0
            startY: view.height
            PathLine {
                x: view.width
                y: view.height
            }
        }
    }

    Text {
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom
        color: '#fff'
        font.pixelSize: 14
        text: root.title
    }

    MouseArea {
        anchors.fill: parent
        onClicked: root.clicked()
    }
}

