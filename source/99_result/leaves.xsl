<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet
	version="1.0"
	xmlns="http://www.w3.org/1999/xhtml"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:xalan="http://xml.apache.org/xalan"
	exclude-result-prefixes="xalan"
>

<xsl:include href="[utility/master.xsl]"/>
<xsl:include href="[utility/xhtml.xsl]"/>

<xsl:variable name="meta">
	<datasource type="main"    mode="iterate" source="02_data/leaves.xml" target="leaf"/>
	<datasource type="support" mode="full"    source="03_meta/meta.xml"   target="meta"/>
	<target     mode="xpath"   value="concat($datasource/leaf/entry/@handle, '/index.html')"/>
</xsl:variable>

<xsl:template name="title-text">
	<xsl:value-of select="/datasource/leaf/entry/@handle"/>
</xsl:template>

<xsl:template match="leaf/entry">
	<div class="article">
		<h2>
			<span class="arrow">
				<xsl:text>» </xsl:text>
			</span>
			<a href="{@handle}">
				<xsl:value-of select="title"/>
			</a>
		</h2>

		<xsl:apply-templates select="content/node()" mode="xhtml"/>
	</div>
</xsl:template>

</xsl:stylesheet>
