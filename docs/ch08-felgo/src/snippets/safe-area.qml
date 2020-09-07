Page {
   useSafeArea: false // page content can cover whole screen

   // This will be drawn under the cutout or gesture areas
   Rectangle {
     anchors.fill: parent
     color: "red"
   }

   // This is anchored to the safe area so it won’t be cut
   Rectangle {
     anchors.fill: parent.safeArea
     color: "lightgreen"
   }
 }
