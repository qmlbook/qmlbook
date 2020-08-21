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
