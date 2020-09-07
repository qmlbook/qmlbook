 import Felgo 3.0
 import QtQuick 2.0

 App {
   id: app
   // uncomment this to remove the resources on startup, so you can test the downloading again
   //Component.onCompleted: pdfResource.remove()
   NavigationStack {
     Page {
       title: "Download PDF"

       Column {
         anchors.centerIn: parent

         AppButton {
           text: "Download / Open"
           onClicked: {
             if(pdfResource.available) openPdf()
             else pdfResource.download()
           }
         }
         AppText {
           text: "Status: " + pdfResource.status
         }
       }
     }
   }
   DownloadableResource {
     id: pdfResource
     source: "http://www.orimi.com/pdf-test.pdf"
     storageLocation: FileUtils.DocumentsLocation
     storageName: "pdf-test.pdf"
     extractAsPackage: false
     // if the download is competed, available will be set to true
     onAvailableChanged: if(available) openPdf()
   }
   function openPdf() {
     // you can also open files with nativeUtils.openUrl() now (for paths starting with "file://")
     //nativeUtils.openUrl(pdfResource.storagePath)
     fileUtils.openFile(pdfResource.storagePath)
   }
 }
