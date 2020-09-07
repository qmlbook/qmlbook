import Felgo 3.0
import QtQuick 2.0

App {
    Navigation {
        NavigationItem {
            title: qsTr("Recent")
            icon: IconType.clocko

            NavigationStack {
                RecentsPage {}
            }
        }
    }

    Component {
        id: conversationComponent
        ConversationPage {}
    }
}
