import Felgo 3.0

App {
  licenseKey: "<generate one from https://felgo.com/licenseKey>"

  NotificationManager {
    id: notificationManager

    onNotificationFired: {
      console.debug("Notification with id " + notificationId + " fired")
    }
  }

  Notification {
    id: staticNotification
    notificationId: "static_notification"
    message: "I'm statically defined in the app"
    // Time in seconds when the notification should be fired
    timeInterval: 5
  }

  NavigationStack {
    Page {
      id: page
      title: qsTr("Local Notification")

      AppButton {
        text: "Schedule Notification"
        anchors.centerIn: parent
        onClicked: {
          // Trigger notification in 5 seconds
          notificationManager.scheduleNotification(staticNotification)
        }
      }
    }
  }
}
