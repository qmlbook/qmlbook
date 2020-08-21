App {  
Component {
    id: conversationComponent
    ListPage {
      property var person
      title: person

      emptyText.text: qsTr("No messages")
    }
  }
}
