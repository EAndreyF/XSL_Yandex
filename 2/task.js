exports.run = function(query) {
	console.log(query);
	var sort = query && query.sort || 'artist',
		order = query && query.order || 'ascending',
		year = query && query.year || '',
		artist = query && query.artist || '',
		xslt = require('node_xslt'),
		fs = require('fs'),
		libxml = require('libxmljs'),
		xml = '/db.xml',
		template = './2/template.xsl',

		stylesheet = xslt.readXsltFile(template),
		doc  = xslt.readXmlFile('./2' + xml),

		sh = require('execSync'),  

		command = 'xsltproc -stringparam sort "' + sort + '" -stringparam order "' + order + '" -stringparam year "' + year +'" -stringparam artist "' + artist + '" 2/template.xsl 2/db.xml';

	return sh.exec(command).stdout;
};