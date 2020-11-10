import QtQuick 2.1
import Felgo 3.0

 OneSignal {
   id: onesignal

   appId: "<ONESIGNAL-APP-ID>"
   
   onNotificationReceived: {
      console.debug("Received notification with message:", message)
   }
 }

