import Felgo 3.0
import QtQuick 2.0

 App {
   Page {
     id: page

     // property with json data
     property var jsonData: [
       {
         "id": 1,
         "title": "Entry 1"
       },
       {
         "id": 2,
         "title": "Entry 2"
       },
       {
         "id": 3,
         "title": "Entry 3"
       }
     ]

     // list model for json data
     JsonListModel {
       id: jsonModel
       source: page.jsonData
       keyField: "id"
     }

     // list view
     AppListView {
       anchors.fill: parent
       model: jsonModel
       delegate: SimpleRow {
         text: model.title
       }
     }
   }
 }
