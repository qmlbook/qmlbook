db.getUserValue("myvalue", queryParameters, function(success, key, value) {
                   if(success) {
                     console.log("Read user value for key", key, "from DB:", value)
                   }
                 })
