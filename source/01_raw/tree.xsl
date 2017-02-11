<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet
	version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:xalan="http://xml.apache.org/xalan"
	xmlns:InputXSLT="function.inputxslt.application"
	exclude-result-prefixes="xalan InputXSLT"
>

<xsl:include href="[utility/formatter.xsl]"/>
<xsl:include href="[utility/datasource.xsl]"/>

<xsl:variable name="meta">
	<datasource type="main"  mode="xpath" source="$source_tree/directory[@name = '00_content']/directory" target="files"/>
	<target     mode="plain" value="tree.xml"/> 
</xsl:variable>

<xsl:template match="@*|node()" mode="tree">
	<xsl:copy>
		<xsl:apply-templates select="@*|node()"/>
	</xsl:copy>
</xsl:template>

<xsl:template match="file[@extension = '.md']" mode="tree">
	<xsl:variable name="content">
		<xsl:call-template name="formatter">
			<xsl:with-param name="source" select="InputXSLT:read-file(./full)/text()"/>
		</xsl:call-template>
	</xsl:variable>

	<leaf name="{@name}">
		<title>
			<xsl:value-of select="xalan:nodeset($content)/h1"/>
		</title>
		<content>
			<xsl:copy-of select="xalan:nodeset($content)/*[name() != 'h1']"/>
		</content>
	</leaf>
</xsl:template>

<xsl:template match="directory" mode="tree">
	<branch name="{@name}">
		<xsl:apply-templates select="node()" mode="tree"/>
	</branch>
</xsl:template>

<xsl:template match="files/directory[@name = 'tree']">
	<xsl:apply-templates select="node()" mode="tree"/>
</xsl:template>

</xsl:stylesheet>
