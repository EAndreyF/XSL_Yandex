exports.run = function(query) {
	// Если id формы не указан, то считаем что первый id
	var id = query && query.id || 1;
	
		xslt = require('node_xslt'),
		fs = require('fs'),
		libxml = require('libxmljs'),
		xml = '/ad.xml',
		template = './1/template.xsl',
		schema = '/schema.xsd',

		schema_text = libxml.parseXml(fs.readFileSync(__dirname + schema)),
		xml_text = libxml.parseXml(fs.readFileSync(__dirname + xml)),

		stylesheet = xslt.readXsltFile(template),
		doc = xslt.readXmlFile('./1' + xml);
	// Если форма проходит валидацию то выполняем преобразование
	if (xml_text.validate(schema_text)) {
		return xslt.transform(stylesheet, doc, ['id', id]);
	} else {
		return 'invalid xml';
	}
            

};