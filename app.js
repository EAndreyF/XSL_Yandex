(function() {
	var express = require('express'),
		http = require('http'),
		app = express(),
		fs = require('fs');

	app.set('port', 12345);
	// важно что express 3 версии стоит
	app.use(express.bodyParser());

	// заглушка для иконки
	app.get(/favicon.ico/, function(req, res) {
		res.send();
	});

	// js и css файлы отдаём как есть. (настроено на nginx, правило необходимо для локального тестирования)
	app.get(/\.js|\.css/, function(req, res) {
		res.sendfile(__dirname + '/public' + req.url);
	});

	// процессинг форм
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

	// для корневой страницы показываем index.html (тоже настроено на nginx)
	app.get(/^\/$/, function(req, res) {
		res.sendfile(__dirname + '/public/index.html');
	});

	// основной роутер. для папки роутим на файл task.js
	app.get(/.*/, function(req, res) {
		console.log('request: ' + req.url);
		var task = req.path.split('/')[1],
			ex = require('./' + task + '/task.js');
		res.send(ex.run(req.query));
	});

    app.listen(app.get('port'));
})();