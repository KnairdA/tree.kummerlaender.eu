<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet
	version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
>

<xsl:include href="[utility/datasource.xsl]"/>

<xsl:variable name="meta">
	<datasource type="main"    mode="full" source="00_content/meta.xml"  target="meta"/>
	<datasource type="support" mode="full" source="02_data/leaves.xml"   target="leaves"/>
	<target     mode="plain"   value="meta.xml"/>
</xsl:variable>

<xsl:template match="meta">
	<xsl:copy-of select="*"/>
</xsl:template>

<xsl:template match="leaves/entry">
	<entry handle="{@handle}"/>
</xsl:template>

<xsl:template match="leaves">
	<leaves>
		<xsl:apply-templates select="entry"/>
	</leaves>
</xsl:template>

</xsl:stylesheet>
