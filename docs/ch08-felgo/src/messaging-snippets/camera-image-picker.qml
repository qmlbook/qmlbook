import QtQuick 2.0
import Felgo 3.0

Page {
  Column {
    id: column
    anchors.centerIn: parent

    AppButton {
      text: qsTr("Pick from Gallery")
      onClicked: nativeUtils.displayImagePicker(text)
    }

    AppButton {
      text: qsTr("Pick from Camera")
      onClicked: nativeUtils.displayCameraPicker(text)
    }
  }

  Connections {
    target: nativeUtils
    onImagePickFinished: function (accepted, filePath) {
      console.log("Here's the picked image: " + filePath)
    }
    onCameraPickFinished: function (accepted, filePath) {
      console.log("Here's the camera image:" + filePath)
    }
  }
}
