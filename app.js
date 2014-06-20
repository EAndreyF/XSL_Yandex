(function() {
	var express = require('express'),
		http = require('http'),
		app = express();

	app.set('port', 12345);
	app.use(express.bodyParser());

	app.get(/favicon.ico/, function(req, res) {
		res.send();
	});

	app.get(/\.js|\.css/, function(req, res) {
		var fs = require('fs'),
			file = fs.readFileSync(__dirname + req.url);
		res.send(file);
	});

	app.post(/\.process/, function(req, res) {
		console.log('request process: ' + req.url);
		console.log('request params: ');
		console.log(req.body)
		var split = req.path.split('/'),
			task = split[1],
			file = split.slice(-1)[0].split('.')[0],
			ex = require('./' + task + '/' + file);
		res.json(ex.run(req.body));
	});

	app.get(/.*/, function(req, res) {
		console.log('request: ' + req.url);
		var task = req.path.split('/')[1],
			ex = require('./' + task + '/task.js');
		res.send(ex.run(req.query));
	});

    app.listen(app.get('port'));
})();