exports.run = function(params) {
	var xslt = require('node_xslt'),
		fs = require('fs'),
		xml = './3/form.xml',
		template = './3/submit.xsl',

		stylesheet = xslt.readXsltFile(template),
		doc = xslt.readXmlFile(xml),

		xsl_param = [],

		result,
		param,
		key;

	for(key in params) {
		param = params[key] ? '"' + params[key] + '"' : 'empty';
		xsl_param.push(key, param);
		xsl_param.push(key + '_empty', params[key] === '');
	}
	console.log(xsl_param);
	result = xslt.transform(stylesheet, doc, xsl_param);
	console.log(result);

	if (!result.trim()) {
		return {status: 'OK'};
	} else {
		return {status: "ERROR", error_message: result};
	}
};