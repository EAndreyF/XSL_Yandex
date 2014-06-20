<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

	<!-- вывод нод как есть -->
    <xsl:template match="*" mode='all'>
      <xsl:copy>
        <xsl:apply-templates select="node()|@*"  mode='all'/>
      </xsl:copy>
    </xsl:template>

    

	<!-- декларативный подход - обрабатываем всё что есть -->

	<!-- изменяем шаблоны по умолчанию для узлов-->
	<xsl:template match="*">
        <xsl:apply-templates />
    </xsl:template>

	<xsl:template match="/">
		<html>
			<head>
				<link type="css/stylesheet" src="1/main.css" />
			</head>
			<style>
				.wrapper {
					width: 500px;
					margin:0 auto;
					border: 5px solid black;
				}

				section {
					border: 1px solid red;
					margin: 5px;
				}

				title {
					font-size: larger;
					display: block;
					font-weight: bold;
				}
				para {
					display: block;
				}
			</style>
			<body>
				<xsl:apply-templates />
			</body>
		</html>
	</xsl:template>

	<xsl:template match="root">
		<div class='wrapper'>
			<xsl:apply-templates />
		</div>
	</xsl:template>

	<xsl:template match="form">
		<xsl:if test="@id = $id">
			<xsl:apply-templates select="../../section" mode="all" />
		</xsl:if>
	</xsl:template>

	<xsl:template match="section">
	</xsl:template>
	<!-- декларативный подход конец -->

	<!-- адресный подход  - ожидаем конкретный тег->
	<xsl:template match="/">
		<html>
			<head>
				<link type="css/stylesheet" src="1/main.css" />
			</head>
			<style>
				.wrapper {
					width: 500px;
					margin:0 auto;
					border: 5px solid black;
				}

				section {
					border: 1px solid red;
					margin: 5px;
				}

				title {
					font-size: larger;
					display: block;
					font-weight: bold;
				}
				para {
					display: block;
				}
			</style>
			<body>
				<xsl:apply-templates select="root"/>
			</body>
		</html>
	</xsl:template>

	<xsl:template match="root">
		<div class='wrapper'>
			<xsl:apply-templates select="ad" />
		</div>
	</xsl:template>

	<xsl:template match="ad">
		<xsl:apply-templates select="forms/form" />
	</xsl:template>

	<xsl:template match="form">
		<xsl:if test="@id = $id">
			<xsl:apply-templates select="../../section"  mode='all'/>
		</xsl:if>
	</xsl:template>
	<!- адресный подход конец -->


</xsl:stylesheet>