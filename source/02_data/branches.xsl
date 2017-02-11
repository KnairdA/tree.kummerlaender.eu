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
	<target     mode="plain" value="branches.xml"/>
</xsl:variable>

<xsl:template match="branch | leaf" mode="serialize">
	<xsl:apply-templates select="parent::branch" mode="serialize"/>
	<xsl:text>/</xsl:text>
	<xsl:value-of select="@name"/>
</xsl:template>

<xsl:template match="@*|node()" mode="include">
	<xsl:copy>
		<xsl:apply-templates select="@*|node()" mode="include"/>
	</xsl:copy>
</xsl:template>

<xsl:template match="leaf" mode="include">
	<xsl:apply-templates select="node()" mode="include"/>
</xsl:template>

<xsl:template match="leaf" mode="digest">
	<node name="{@name}">
		<title>
			<xsl:value-of select="title"/>
		</title>
		<digest size="{string-length(content/p[normalize-space(.)][1])}">
			<xsl:copy-of select="content/p[normalize-space(.)][1]/node()"/>
		</digest>
	</node>
</xsl:template>

<xsl:template match="leaf">
	<xsl:variable name="name" select="@name"/>

	<xsl:if test="not(preceding-sibling::branch[@name = $name])">
		<xsl:apply-templates select="." mode="digest"/>
	</xsl:if>
</xsl:template>

<xsl:template match="branch" mode="digest">
	<xsl:variable name="name" select="@name"/>

	<xsl:apply-templates select="following-sibling::leaf[@name = $name]" mode="digest"/>
</xsl:template>

<xsl:template match="branch">
	<xsl:variable name="path">
		<xsl:apply-templates select="." mode="serialize"/>
	</xsl:variable>

	<entry handle="{$path}">
		<xsl:variable name="name" select="@name"/>

		<payload>
			<xsl:apply-templates select="following-sibling::leaf[@name = $name]" mode="include"/>
		</payload>

		<branches>
			<xsl:apply-templates select="branch" mode="digest"/>
		</branches>

		<leaves>
			<xsl:apply-templates select="leaf"/>
		</leaves>
	</entry>
</xsl:template>

<xsl:template match="tree">
	<xsl:apply-templates select="//branch"/>
</xsl:template>

</xsl:stylesheet>
