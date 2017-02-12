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
	<datasource type="main"    mode="iterate" source="02_data/branches.xml" target="branch"/>
	<datasource type="support" mode="full"    source="02_data/digest.xml"   target="digest"/>
	<datasource type="support" mode="full"    source="03_meta/meta.xml"     target="meta"/>
	<target     mode="xpath"   value="concat($datasource/branch/entry/@handle, '/index.html')"/>
</xsl:variable>

<xsl:template name="title-text">
	<xsl:value-of select="/datasource/branch/entry/@handle"/>
</xsl:template>

<xsl:template match="branch/entry">
	<div class="article">
		<h2>
			<xsl:text>» </xsl:text>
			<a href="{@handle}">
				<xsl:value-of select="payload/title"/>
			</a>
		</h2>
		<p class="info"/>

		<xsl:apply-templates select="payload/content/node()" mode="xhtml"/>
	</div>

	<div class="columns">
		<ul class="prettylist">
			<xsl:apply-templates select="branches/node">
				<xsl:sort select="digest/@size" data-type="number" order="descending"/>
			</xsl:apply-templates>
		</ul>
	</div>

	<div class="columns">
		<ul class="prettylist">
			<xsl:apply-templates select="leaves/node">
				<xsl:sort select="digest/@size" data-type="number" order="descending"/>
			</xsl:apply-templates>
		</ul>
	</div>
</xsl:template>

<xsl:template match="entry/*/node">
	<li>
		<em>»</em>
		<a href="{@name}/">
			<strong><xsl:value-of select="title"/></strong>
			<p>
				<xsl:apply-templates select="digest/node()" mode="xhtml"/>
			</p>
		</a>
	</li>
</xsl:template>

</xsl:stylesheet>
