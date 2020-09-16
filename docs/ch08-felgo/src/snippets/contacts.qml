import Felgo 3.0

 App {
   Page {
     AppListView {
       anchors.fill: parent
       model: nativeUtils.contacts

       delegate: SimpleRow {
         text: modelData.name
         detailText: modelData.phoneNumbers.join(", ") // Join all numbers into a string separated by a comma
       }
     }
   }
 }
