delegate: SimpleRow {
  //...
            onSelected: {
              navigationStack.popAllExceptFirstAndPush(conversationComponent, {
             person: item.text,
              })
}
}
