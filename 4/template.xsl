<?xml version="1.0" ?>
<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:exsl="http://exslt.org/common"
                extension-element-prefixes="exsl">
<!-- Получаем текущий элемент меню -->
	<xsl:param name='cur'>
		<xsl:value-of select='/root/request/url' />
	</xsl:param>

<!-- Меняем шаблоны по умолчанию-->
	<xsl:template match='*|@*'>
	</xsl:template>

	<xsl:template match='/' >
<!-- Преобразовываем входние данные в данные для генерации и помещаем в переменную menu-->		
		<xsl:variable name='menu'>
			<xsl:apply-templates />
		</xsl:variable>
<!-- Рендеринг меню -->
		<xsl:apply-templates select='exsl:node-set($menu)' mode='output'/>
	</xsl:template>

	<xsl:template match='root'>
		<xsl:apply-templates />
	</xsl:template>

	<xsl:template match='project'>
		<menu>
			<xsl:apply-templates />
		</menu>
	</xsl:template>

	<xsl:template match='page'>
		<item>
<!-- Если данная нода - текущий элемент, то добавляем аттрибут is-current-->
			<xsl:if test='$cur=.'>
				<xsl:attribute name='is-current'>
					true
				</xsl:attribute>
			</xsl:if>
			<title>
				<xsl:value-of select='@name' />
			</title>
			<url>
				<xsl:value-of select='.' />
			</url>
		</item>
	</xsl:template>

<!-- Генерация вывода -->
	<xsl:template match='menu' mode='output'>
		<div>
			<xsl:apply-templates mode='output' />
		</div>
	</xsl:template>

<!-- Если не текущий элемент - то выводим ссылкой -->
	<xsl:template match='item' mode='output'>
		<a href='{url}'>
			<xsl:value-of select='title' />
		</a>
	</xsl:template>

<!-- Если текущий элемент - то выделяем жирным -->	
	<xsl:template match='item[@is-current=true()]' mode='output'>
		<strong>
			<xsl:value-of select='title' />
		</strong>
	</xsl:template>

</xsl:stylesheet>