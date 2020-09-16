HttpRequest
    .get("http://httpbin.org/get")
    .cacheSave(true) // cache the result of this request, regardless of global cache setting
    .cacheLoad(HttpCacheControl.PreferNetwork) // use network if possible, otherwise load from cache
    .then(function(res) {
        console.log(JSON.stringify(res.body))
    })
    .catch(function(err) {
        console.log(err.message)
    });
