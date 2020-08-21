import QtQuick 2.0
import Felgo 3.0

App {
  Page {

    AppButton {
      text: qsTr("Click me")
      anchors.centerIn: parent
      onClicked: nativeUtils.displayTextInput(null, qsTr("Insert your name"))
    }

    Connections {
      target: nativeUtils
      onTextInputFinished: function (accepted, result) {
      console.log("Here's the result " + result)
    }
  }
}
