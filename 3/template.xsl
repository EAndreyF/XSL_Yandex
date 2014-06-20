<?xml version="1.0" ?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

	<xsl:template match="/">
		<xsl:apply-templates />
		<!-- подключаем скрипты для валидации на стороне клиента -->
		<script src="https://code.jquery.com/jquery-2.1.1.min.js">window
		</script>
		<script src="script.js">window
		</script>
	</xsl:template>

	<!-- Отрисовка формы -->
	<xsl:template match='form'>
		<form action='{@action}' method='{@method}'>
			<div class='errors' style='color:red; border: 1px solid black; display: none;'>Errors:</div>
			<div class='ok' style='color:green; border: 1px solid black; display: none;'>Form sending successfully!</div>
			<xsl:apply-templates />
			<input type='submit' />
		</form>
	</xsl:template>

	<xsl:template match='input'>
		<label>
			<xsl:value-of select='label' />
			<input name='{@name}' type='{@type}' mn='{@min}' mx='{@max}' regexp='{@regexp}' len='{@length}' req='{@required}' value='{value}' error='{error}' />
		</label>
		<br />
	</xsl:template>

</xsl:stylesheet>