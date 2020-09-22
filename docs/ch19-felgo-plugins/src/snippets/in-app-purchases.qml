import Felgo 3.0
import QtQuick 2.0

App {
  licenseKey: "<generate one from https://felgo.com/licenseKey>"
  Store {
    id: store

    version: 1
    secret: "<your-app-secret>"
    androidPublicKey: "<android-public-key>"

    goods: [
      LifetimeGood {
        id: noadsGood
        itemId: "net.felgo.demos.PluginDemo.noads"
        name: "No Ads"
        description: "Buy this item to remove the app banner"
        purchaseType: StorePurchase { id: noAdPurchase; productId: noadsGood.itemId; }
      }
    ]
  }

  NavigationStack {
    Page {
      title: qsTr("In app purchase")

      AppButton {
        anchors.centerIn: parent
        text: "Remove Ad"
        onClicked: {
          store.buyItem(noadsGood.itemId)
        }
      }

      Rectangle {
        id: annoyingAd
        anchors.bottom: parent.bottom
        width: parent.width
        height: dp(50)
        color: "red"

        // Just one line for handling visiblity of the ad banner, you can use property binding for this!
        visible: !noadsGood.purchased

        AppText {
          text: "Annoying Ad"
          color: "white"
          anchors.centerIn: parent
        }
      }
    }
  }
}
