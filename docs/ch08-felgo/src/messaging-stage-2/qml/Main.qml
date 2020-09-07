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

// M1>>
// Inside the ListPage
model: [
    { text: "Tom McEloy", detailText: "Sorry for the late reply ...", image: Qt.resolvedUrl("../assets/portrait0.jpg") },
    { text: "Leah Douglas", detailText: "Hahaha :D", image: Qt.resolvedUrl("../assets/portrait1.jpg") }
]
// <<M1

// M2>>
// Inside the ListPage
delegate: SimpleRow {
    image.radius: image.height
    image.fillMode: Image.PreserveAspectCrop
    autoSizeImage: true
    style.showDisclosure: false
    imageMaxSize: dp(48)
    detailTextItem.maximumLineCount: 1
    detailTextItem.elide: Text.ElideRight
}
// <<M2
                }
            }
        }
    }
}
