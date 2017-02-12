<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet
	version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:xalan="http://xml.apache.org/xalan"
	xmlns:InputXSLT="function.inputxslt.application"
	exclude-result-prefixes="xalan InputXSLT"
>

<xsl:include href="[utility/datasource.xsl]"/>

<xsl:variable name="meta">
	<datasource type="main"  mode="full" source="01_raw/tree.xml" target="tree"/>
	<target     mode="plain" value="digest.xml"/>
</xsl:variable>

<xsl:template match="branch | leaf" mode="serialize">
	<xsl:apply-templates select="parent::branch" mode="serialize"/>
	<xsl:text>/</xsl:text>
	<xsl:value-of select="@name"/>
</xsl:template>

<xsl:template match="tree//leaf">
	<xsl:variable name="path">
		<xsl:apply-templates select="." mode="serialize"/>
	</xsl:variable>

	<entry handle="{$path}">
		<title>
			<xsl:value-of select="title"/>
		</title>
		<digest size="{string-length(content/p[normalize-space(.)][1])}">
			<xsl:copy-of select="content/p[normalize-space(.)][1]/node()"/>
		</digest>
	</entry>
</xsl:template>

</xsl:stylesheet>
