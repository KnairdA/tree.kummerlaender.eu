<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet
	version="1.0"
	xmlns="http://www.w3.org/1999/xhtml"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
>

<xsl:output
	method="xml"
	doctype-public="-//W3C//DTD XHTML 1.0 Strict//EN"
	doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd"
	omit-xml-declaration="yes"
	encoding="UTF-8"
	indent="no"
/>

<xsl:variable name="root" select="datasource"/>

<xsl:template match="/">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<meta name="author"             content="Adrian Kummerländer" />
	<meta name="robots"             content="all"/>
	<meta name="viewport"           content="width=device-width,initial-scale=1.0"/>

	<link rel="stylesheet"    type="text/css"             href="/main.css" />
	<link rel="shortcut icon" type="image/x-icon"         href="/media/favicon.ico" />

	<xsl:if test="//*[(self::p or self::span) and @class = 'math']">
		<link rel="stylesheet" type="text/css" href="https://static.kummerlaender.eu/katex/katex.min.css" />
	</xsl:if>

	<title>
		<xsl:call-template name="title-text"/> @ <xsl:value-of select="$root/meta/title"/>
	</title>
</head>
<body>
	<div id="navigation" class="center border_bottom">
		<h1>
			<xsl:value-of select="$root/meta/title"/>
		</h1>

		<ul class="buttonlist">
			<li>
				<a href="/">Start</a>
			</li>
			<li>
				<a href="/projects">Projects</a>
			</li>
			<li>
				<a href="/contact">Contact</a>
			</li>
		</ul>
	</div>

	<div id="content" class="center">
		<xsl:apply-templates />
	</div>

	<div id="footer" class="center border_top">
		<a href="/projects/xslt/static_xslt/">Made with XSLT</a>

		<ul class="buttonlist">
			<li>
				<a href="/contact">Contact</a>
			</li>
		</ul>
	</div>
</body>
</html>
</xsl:template>

<xsl:template match="text()|@*"/>

</xsl:stylesheet>
