import Felgo 3.0
import QtQuick 2.0

App {
  Amplitude {
     id: amplitude

     // From Amplitude Settings
     apiKey: "<amplitude-api-key>"

     userProperties: ({
       age: 17,
       weight: 110.3,
       name: "Gregor",
       achievements: [1, 2, 4, 8]
     })

     onPluginLoaded: {
       amplitude.logEvent("App started");
     }
  }


  NavigationStack {
    Page {
      title: "Amplitude"

      Column {
        anchors.centerIn: parent

        AppButton {
          text: "Send Event"
          onClicked: amplitude.logEvent("Button clicked")
        }
      }
    }
  }
}
