
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
        }
      }
