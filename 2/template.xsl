<?xml version="1.0" ?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<xsl:template match="/">
		<!-- выводим значения переданых параметров -->
		----- year - 
		<xsl:value-of select="$year" />
		----- sort - 
		<xsl:value-of select="$sort" />
		----- order - 
		<xsl:value-of select="$order" />
		---- artist - 
		<xsl:value-of select="$artist" />
		<ul>
			<xsl:apply-templates />
		</ul>
	</xsl:template>

	<xsl:template match="audios" >
		<!-- Ыильтруем по переданным параметрам -->
		<xsl:apply-templates select='audio[artist[$artist=text() or $artist=""]][year[$year=text() or $year=""]]'>
			<!-- Сортируем то что получилось после фильтра-->
			<xsl:sort select="*[name()=$sort]" order="{$order}" />
		</xsl:apply-templates>
	</xsl:template>

	<!-- Выводи отфильтрованные и отсортированные данные-->
	<xsl:template match="audio">
		<li>
			<xsl:value-of select="year" /> - 
			<xsl:value-of select="artist" /> - 
			<xsl:value-of select="studio" /> - 
			<xsl:apply-templates select="tracks/track" /> - 
			<xsl:value-of select="cover" />
		</li>
	</xsl:template>

	<xsl:template match="track">
		<xsl:value-of select="." />;
	</xsl:template>

</xsl:stylesheet>