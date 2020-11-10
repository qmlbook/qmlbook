import Felgo 3.0

App {
  licenseKey: "<generate one from https://felgo.com/licenseKey>"
  
  NavigationStack {
    Page {
      title: qsTr("AdMob Banner")

      AdMobBanner {
        id: adMobBanner
        adUnitId: "ca-app-pub-9155324456588158/9913032020"
        banner: AdMobBanner.Standard

        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom
      }
    }
  }
}
