import QtQuick 2.0
import Felgo 3.0

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
