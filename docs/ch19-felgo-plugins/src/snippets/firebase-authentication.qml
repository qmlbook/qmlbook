import Felgo 3.0
import QtQuick 2.0

App {

  //…

  FirebaseAuth {
    id: auth
           config: fbConfig
  }

  Page {
    Column {
      spacing: Theme.contentPadding
      anchors.centerIn: parent

      AppTextField {
        id: username
        width: dp(200)
      }

      AppTextField {
        id: password
        inputMode: inputModePassword
        width: dp(200)
      }

      AppButton {
        text: qsTr("Sign-Up")
        anchors.horizontalCenter: parent.horizontalCenter
        onClicked: auth.registerUser(username.text, password.text)
      }
    }
  }
}
