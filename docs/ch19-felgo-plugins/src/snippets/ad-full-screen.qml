import Felgo 3.0

App {
  licenseKey: "<generate one from https://felgo.com/licenseKey>"

  NavigationStack {
    Page {
      title: qsTr("AdMob Interstitial")

      AppButton {
        text: "Show Interstitial"
        anchors.centerIn: parent
        onClicked: {
          adInerstitial.loadInterstitial()
        }
      }

      AdMobInterstitial {
        id: adInerstitial
        adUnitId: "ca-app-pub-3940256099942544/1033173712" // interstitial test ad by AdMob

        onInterstitialReceived: {
          showInterstitialIfLoaded()
        }
      }
    }
  }
}
