var WebSocketServer = require('ws').Server;

var server = new WebSocketServer({ port : 3000 });

server.on('connection', function(socket) {
	console.log('client connected');
	socket.on('message', function(msg) {
		console.log('Message: %s', msg);
		socket.send(msg);
	});
	socket.send('Welcome to Awesome Chat');
});

console.log('listening on port ' + server.options.port);

