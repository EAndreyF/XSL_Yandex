<?xml version="1.0" ?>
<!-- regexp не поддерживается xsltproc -->
<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:dyn="http://exslt.org/dynamic"
                xmlns:regexp="http://exslt.org/regular-expressions"
                xmlns:exsl="http://exslt.org/common"
                extension-element-prefixes="dyn regexp exsl">

    <xsl:output method="html" omit-xml-declaration="yes" indent="no"/>

<!-- Устанавливаем значения по умолчанию -->
    <xsl:template match='*|@*'>
    </xsl:template>

    <xsl:template match='*|@*' mode='check'>
    </xsl:template>

	<xsl:template match="/">
		<xsl:apply-templates />
	</xsl:template>

	<xsl:template match='form'>
		<xsl:apply-templates />
	</xsl:template>

<!-- для каждого инпута вычисляем данные из формы и отдаём дальше на обработку 
	 формируем временное дерево для удобства вывода результата -->
	<xsl:template match='input'>
		<xsl:variable name='result'>
			<!-- вызываем специальный шаблон создания временного дерева -->
			<xsl:call-template select='.' name='checking'>
				<xsl:with-param name='var' select='dyn:evaluate(concat("$", @name))' />
			</xsl:call-template>
		</xsl:variable>

		<xsl:apply-templates select='exsl:node-set($result)' />
	</xsl:template>

	<xsl:template name='checking'>
		<xsl:param name='var'/>
		<result>
			<xsl:copy-of select='@name' />
			<xsl:apply-templates select='error' />
			<!-- Пробегаем по всем атрибутам для проверки -->
			<xsl:apply-templates select='./@*' mode='check' >
				<xsl:with-param name='var' select='$var' />
			</xsl:apply-templates>
		</result>
	</xsl:template>

	<xsl:template match='error'>
		<message>
			<xsl:value-of select='text()' />;
		</message>
	</xsl:template>

<!-- Проверка полей -->	

<!-- Минимум -->
	<xsl:template match='@min' mode='check'>
		<xsl:param name='var'/>
		<xsl:if test='. >= $var'>
			<error>equal or less than <xsl:value-of select='.' />;
			</error>
		</xsl:if>
	</xsl:template>

<!-- Максимум -->
	<xsl:template match='@max' mode='check'>
		<xsl:param name='var'/>
		<xsl:if test='$var >= .'>
			<error>equal or more than <xsl:value-of select='.' />;
			</error>
		</xsl:if>
	</xsl:template>

<!-- Длина -->
	<xsl:template match='@length' mode='check'>
		<xsl:param name='var'/>
		<xsl:if test='not(string-length($var) = .)'>
			<error>
				length isn't <xsl:value-of select='.' />;
			</error>
		</xsl:if>
	</xsl:template>

<!-- Обязательность -->
	<xsl:template match='@required' mode='check'>
		<xsl:param name='var'/>
		<xsl:if test='string-length($var) = 0'>
			<error>
				field is required;
			</error>
		</xsl:if>
	</xsl:template>

<!-- Проверка полей конец -->

<!-- Обработка временного дерева результата -->
	<xsl:template match='result[error]'>
		<xsl:value-of select='@name' />:
		<xsl:apply-templates select='error/text()' />
		<br />
	</xsl:template>

	<xsl:template match='result[message][error]' >
		<xsl:value-of select='@name' />:
		<xsl:value-of select='message/text()' />	
		<br />
	</xsl:template>
</xsl:stylesheet>