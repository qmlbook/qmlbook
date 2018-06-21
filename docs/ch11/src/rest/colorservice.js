.pragma library

var BASE = 'http://localhost:5000/colors'

function get_colors(cb) {
    request('GET', null, null, cb)
}

function create_color(entry, cb) {
    request('POST', null, entry, cb)
}

function get_color(name, cb) {
    request('GET', name, null, cb)
}

function update_color(name, entry, cb) {
    request('PUT', name, entry, cb)
}

function delete_color(name, cb) {
    request('DELETE', name, null, cb)
}


function request(verb, endpoint, obj, cb) {
    print('request: ' + verb + ' ' + BASE + (endpoint?'/' + endpoint:''))
    var xhr = new XMLHttpRequest();
    xhr.onreadystatechange = function() {
        print('xhr: on ready state change: ' + xhr.readyState)
        if(xhr.readyState === XMLHttpRequest.DONE) {
            if(cb) {
                var res = JSON.parse(xhr.responseText.toString())
                cb(res);
            }
        }
    }
    xhr.open(verb, BASE + (endpoint?'/' + endpoint:''));
    xhr.setRequestHeader('Content-Type', 'application/json');
    xhr.setRequestHeader('Accept', 'application/json');
    var data = obj?JSON.stringify(obj):''
    xhr.send(data)
}
