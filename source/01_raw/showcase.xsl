<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet
	version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
>

<xsl:include href="[utility/datasource.xsl]"/>

<xsl:variable name="meta">
	<datasource type="main"    mode="xpath" source="$source_tree/directory[@name = '00_content']/directory[@name = 'showcase']/file"  target="links"/>
	<datasource type="support" mode="xpath" source="$source_tree/directory[@name = '00_content']/directory[@name = 'tree']/directory" target="files"/>
	<target     mode="plain"   value="showcase.xml"/>
</xsl:variable>

<xsl:template match="directory | file" mode="serialize">
	<xsl:apply-templates select="parent::directory" mode="serialize"/>
	<xsl:text>/</xsl:text>
	<xsl:value-of select="@name"/>
</xsl:template>

<xsl:template match="file" mode="resolve">
	<xsl:variable name="path">
		<xsl:apply-templates select="." mode="serialize"/>
	</xsl:variable>

	<entry handle="{$path}"/>
</xsl:template>

<xsl:template match="links/file/full">
	<xsl:apply-templates select="/datasource/files//file[full/text() = current()/text()]" mode="resolve"/>
</xsl:template>

</xsl:stylesheet>
