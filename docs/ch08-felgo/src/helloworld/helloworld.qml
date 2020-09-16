import Felgo 3.0
import QtQuick 2.0

App {
  NavigationStack {
    Page {
      title: qsTr("Welcome to Felgo")

      AppText {
        anchors.centerIn: parent
        text: "Hello World"
      }
    }
  }
}
