<xsl:stylesheet
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	version="3.0"
	xmlns:tei="http://www.tei-c.org/ns/1.0"
	xmlns:xs="http://www.w3.org/2001/XMLSchema"
	xmlns="http://www.w3.org/1999/xhtml"
	xpath-default-namespace="http://www.tei-c.org/ns/1.0">

	<xsl:variable name="title" select="/tei:TEI/tei:teiHeader/tei:fileDesc/tei:titleStmt/tei:title/tei:title"/>
	<xsl:variable name="author" select="/tei:TEI/tei:teiHeader/tei:fileDesc/tei:titleStmt/tei:author/tei:surname"/>
	<xsl:variable name="file-name" select="/tei:TEI/tei:teiHeader/tei:fileDesc/tei:titleStmt/tei:title/tei:idno"/>

	<xsl:template match="/tei:TEI">
		<titleList>
			<title id="title"><xsl:value-of select="$title"/></title>
			<author id="author"><xsl:value-of select="$author"/></author>
			<fileName id="file-name"><xsl:value-of select="$file-name"/></fileName>
		</titleList>
	</xsl:template>
</xsl:stylesheet>
