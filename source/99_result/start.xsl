<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet
	version="1.0"
	xmlns="http://www.w3.org/1999/xhtml"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
>

<xsl:include href="[utility/master.xsl]"/>
<xsl:include href="[utility/xhtml.xsl]"/>

<xsl:variable name="meta">
	<datasource type="main"    mode="full" source="01_raw/showcase.xml"  target="showcase"/>
	<datasource type="support" mode="full" source="02_data/digest.xml"   target="digest"/>
	<datasource type="support" mode="full" source="03_meta/meta.xml"     target="meta"/>
	<target     mode="plain"   value="index.html"/>
</xsl:variable>

<xsl:template name="title-text">/</xsl:template>

<xsl:template match="digest/entry" mode="digest">
	<li>
		<em>»</em>
		<a href="{@handle}/">
			<strong><xsl:value-of select="title"/></strong>
			<span>
				<xsl:apply-templates select="digest/node()" mode="xhtml"/>
			</span>
		</a>
	</li>
</xsl:template>

<xsl:template match="showcase/entry">
	<xsl:apply-templates select="/datasource/digest/entry[@handle = current()/@handle]" mode="digest"/>
</xsl:template>

<xsl:template match="showcase">
	<h3>Representative subset of nodes</h3>

	<div class="columns">
		<ul class="prettylist">
			<xsl:apply-templates select="entry"/>
		</ul>
	</div>
</xsl:template>

</xsl:stylesheet>
