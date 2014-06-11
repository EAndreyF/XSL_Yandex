(function() {
	var express = require('express'),
		http = require('http'),
		app = express();

		app.set('port', 12345);

		app.get(/.*/, function(req, res) {
			res.send('result');
		});

    http.createServer(app).listen(app.get('port'), function(){
      console.log('Express server listening on port ' + app.get('port'));
    });
})();