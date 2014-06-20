exports.run = function() {
	var xslt = require('node_xslt'),
		fs = require('fs'),
		xml = './3/form.xml',
		template = './3/template.xsl',

		stylesheet = xslt.readXsltFile(template),
		doc = xslt.readXmlFile(xml);

		return xslt.transform(stylesheet, doc, []);
};