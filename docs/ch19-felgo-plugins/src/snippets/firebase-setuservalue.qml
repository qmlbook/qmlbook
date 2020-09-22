db.setUserValue("myObject", {
   keyA: 17,
   keyB: "this is my DB object"
 }, function(success, message) {
   if(success) {
     console.log("successfully written user object to DB")
   } else {
     console.log("DB write error:", message)
   }
 })
