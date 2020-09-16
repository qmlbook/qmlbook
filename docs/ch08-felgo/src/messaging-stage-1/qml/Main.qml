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
        }
      }
    }
  }
}
