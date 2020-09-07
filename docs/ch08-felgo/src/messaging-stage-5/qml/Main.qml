import Felgo 3.0
import QtQuick 2.0

App {
    Navigation {
        NavigationItem {
            title: qsTr("Recent")
            icon: IconType.clocko

            NavigationStack {
                ListPage {
                    title: qsTr("Recent")
                    emptyText.text: qsTr("No conversations yet!")

                    model: [
                        { text: "Tom McEloy", detailText: "Sorry for the late reply ...", image: Qt.resolvedUrl("../assets/portrait0.jpg") },
                        { text: "Leah Douglas", detailText: "Hahaha :D", image: Qt.resolvedUrl("../assets/portrait1.jpg") }
                    ]

                    delegate: SimpleRow {
                        image.radius: image.height
                        image.fillMode: Image.PreserveAspectCrop
                        autoSizeImage: true
                        style.showDisclosure: false
                        imageMaxSize: dp(48)
                        detailTextItem.maximumLineCount: 1
                        detailTextItem.elide: Text.ElideRight

                        onSelected: {
                            navigationStack.popAllExceptFirstAndPush(conversationComponent, { person: item.text })
                        }
                    }
                }
            }
        }
    }

    Component {
        id: conversationComponent
        ListPage {
            id: conversationPage
            emptyText.text: qsTr("No messages")
            listView.anchors.bottomMargin: inputBox.height
            title: person

            property string person

// M1>>
// Inside the conversationComponent ListPage
Storage {
    id: storage
}

function loadStorageMessages() {
    var messages = storage.getValue("messages_" + person)
    if (messages === undefined) {
        messages = [
                    { text: "There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration.", me: false },
                    { text: "Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam erat volutpat.", me: true },
                    { text: "All the Lorem Ipsum generators on the Internet tend to repeat predefined chunks as necessary, making this the first true generator on the Internet. It uses a dictionary of over 200 Latin words.", me: false },
                    { text: "There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration.", me: false },
                    { text: "Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam erat volutpat.", me: true },
                    { text: "All the Lorem Ipsum generators on the Internet tend to repeat predefined chunks as necessary, making this the first true generator on the Internet. It uses a dictionary of over 200 Latin words.", me: false }
                ]
    }
    model = messages
}

Component.onCompleted: loadStorageMessages()

function storeNewMessages() {
    storage.setValue("messages_" + person, model)
}
// <<M1

            delegate: Item {
                id: bubble

                property real spacing: dp(Theme.contentPadding)

                width: conversationPage.width
                height: bubbleBackground.height + 2 * spacing

                Rectangle {
                    id: bubbleBackground
                    color: modelData.me ? Theme.tintColor : "#e9e9e9"
                    radius: bubble.spacing

                    x: modelData.me ? (bubble.width - width - bubble.spacing) : bubble.spacing
                    y: bubble.spacing
                    width: innerText.width + 2 * bubble.spacing
                    height: innerText.implicitHeight + 2 * bubble.spacing

                    AppText {
                        id: innerText
                        x: bubble.spacing
                        y: bubble.spacing
                        width: Math.min(innerText.implicitWidth, bubble.parent.width * 0.75)
                        wrapMode: Text.WordWrap
                        text: modelData.text
                        color: modelData.me ? "white" : "black"
                    }
                }
            }

            // horizontal separator line between input text and
            Rectangle {
                height: px(1)
                anchors.bottom: inputBox.top
                anchors.left: parent.left
                anchors.right: parent.right
                color: "#cccccc"
            }

            AppTextField {
                id: inputBox
                height: dp(48)
                anchors.bottom: parent.bottom
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.leftMargin: Theme.contentPadding
                anchors.rightMargin: Theme.contentPadding
                font.pixelSize: sp(16)
                placeholderText: qsTr("Type a message ...")
                backgroundColor: "white"
                verticalAlignment: Text.AlignVCenter

                onAccepted: {

                    // Here we update the model
                    var newModel = conversationPage.model
                    newModel.push({me: true, text: inputBox.text})
                    conversationPage.model = newModel

                    inputBox.text = ""
                    conversationPage.listView.positionViewAtEnd()
                    conversationPage.storeNewMessages()
                }
            }
        }
    }
}
