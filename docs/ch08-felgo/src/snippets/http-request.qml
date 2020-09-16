import Felgo 3.0
 import QtQuick 2.0

 App {
   Component.onCompleted: {
     HttpRequest
       .get("http://httpbin.org/get")
       .timeout(5000)
       .then(function(res) {
         console.log(res.status);
         console.log(JSON.stringify(res.header, null, 4));
         console.log(JSON.stringify(res.body, null, 4));
       })
       .catch(function(err) {
         console.log(err.message)
         console.log(err.response)
       });
   }
 }
