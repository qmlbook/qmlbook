import Felgo 3.0
import QtQuick 2.0

 App {
   Page {
     id: page

     //...

     SortFilterProxyModel {
     id: filteredTodoModel
     sourceModel: jsonModel

     // configure sorters
     sorters: [
       StringSorter {
         id: nameSorter
         roleName: "title"
       }]
   }

     AppListView {
       //...
       model: filteredTodoModel
       //...
     }
   }
 }  
