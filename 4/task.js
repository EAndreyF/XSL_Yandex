exports.run = function() {
	var xslt = require('node_xslt'),
		fs = require('fs'),
		xml = './4/input.xml',
		template = './4/template.xsl',

		stylesheet = xslt.readXsltFile(template),
		doc = xslt.readXmlFile(xml),

		result = xslt.transform(stylesheet, doc, []);

	console.log(result);
	return result;		
};