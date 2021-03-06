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
	<datasource type="support" mode="full" source="02_data/leaves.xml"   target="leaf"/>
	<datasource type="support" mode="full" source="03_meta/meta.xml"     target="meta"/>
	<target     mode="plain"   value="index.html"/>
</xsl:variable>

<xsl:template name="title-text">/</xsl:template>

<xsl:template match="leaf/entry" mode="page">
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

<xsl:template match="digest/entry" mode="digest">
	<li>
		<span class="arrow">»</span>
		<a href="{@handle}/">
			<span class="title"><xsl:value-of select="title"/></span>
			<span class="text">
				<xsl:apply-templates select="digest/node()" mode="xhtml"/>
			</span>
		</a>
	</li>
</xsl:template>

<xsl:template match="showcase/entry">
	<xsl:apply-templates select="/datasource/digest/entry[@handle = current()/@handle]" mode="digest"/>
</xsl:template>

<xsl:template match="showcase">
	<xsl:choose>
		<xsl:when test="count(entry) &gt; 1">
			<h3>Representative subset of nodes</h3>
			<div class="columns">
				<ul class="prettylist">
					<xsl:apply-templates select="entry"/>
				</ul>
			</div>
		</xsl:when>
		<xsl:otherwise>
			<xsl:variable name="handle" select="/datasource/digest/entry[1]/@handle"/>
			<xsl:apply-templates select="/datasource/leaf/entry[@handle=$handle]" mode="page"/>
		</xsl:otherwise>
	</xsl:choose>
</xsl:template>

</xsl:stylesheet>
