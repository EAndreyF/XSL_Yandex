exports.run = function(query) {
	console.log(query);
	// устанавливаем значения по умолчанию и оборачиваем в кавычки, чтобы не вычислялись значения
	var sort = "'" + (query && query.sort || 'artist') + "'",
		order = "'" + (query && query.order || 'ascending') + "'",
		year = "'" + (query && query.year || '') + "'",
		artist = "'" + (query && query.artist || '') + "'",
		
		xslt = require('node_xslt'),
		fs = require('fs'),
		xml = '/db.xml',
		template = './2/template.xsl',

		stylesheet = xslt.readXsltFile(template),
		doc  = xslt.readXmlFile('./2' + xml);

	return xslt.transform(stylesheet, doc, ['sort', sort, 'order', order, 'year', year, 'artist', artist]);
};