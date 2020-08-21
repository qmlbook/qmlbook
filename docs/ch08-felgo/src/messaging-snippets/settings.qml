
App {
  id: app
  //…

        function loadStorageMessages() {
        var messages = app.settings.getValue("messages")
        if (messages === undefined) {
          messages = [
            { text: "There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration.", me: false },
            { text: "Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam erat volutpat.", me: true },
            { text: "All the Lorem Ipsum generators on the Internet tend to repeat predefined chunks as necessary, making this the first true generator on the Internet. It uses a dictionary of over 200 Latin words.", me: false },
            { text: "There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration.", me: false },
            { text: "Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam erat volutpat.", me: true },
            { text: "All the Lorem Ipsum generators on the Internet tend to repeat predefined chunks as necessary, making this the first true generator on the Internet. It uses a dictionary of over 200 Latin words.", me: false }
          ]
        }
        model = messages
      }

      function storeNewMessages() {
        app.settings.setValue("messages", model)
      }
}
