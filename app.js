(function() {
	var express = require('express'),
		http = require('http'),
		app = express();

		app.set('port', 12345);
		app.get(/favicon.ico/, function(req, res) {
			res.send();
		});

		app.get(/.*/, function(req, res) {
			console.log('request: ' + req.url);
			var task = req.path.split('/')[1],
				ex = require('./' + task + '/task.js');
			res.send(ex.run(req.query));
		});

    http.createServer(app).listen(app.get('port'), function(){
      console.log('Express server listening on port ' + app.get('port'));
    });
})();