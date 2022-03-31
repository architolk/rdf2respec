<xsl:stylesheet version="2.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:xs="http://www.w3.org/2001/XMLSchema"
	xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
	xmlns:rdfs="http://www.w3.org/2000/01/rdf-schema#"
	xmlns:sh="http://www.w3.org/ns/shacl#"
  xmlns:skos="http://www.w3.org/2004/02/skos/core#"
>

<xsl:output method="text" omit-xml-declaration="yes"/>

<xsl:template match="sh:name" mode="properties">
  <xsl:text>|Gebruikte term|[</xsl:text>
  <xsl:value-of select="."/>
  <xsl:text>](</xsl:text>
  <xsl:value-of select="../sh:targetClass/@rdf:resource"/>
  <xsl:text>)
</xsl:text>
</xsl:template>

<xsl:template match="rdfs:comment" mode="properties">
  <xsl:text>|Uitleg </xsl:text>
  <xsl:value-of select="@xml:lang"/>
  <xsl:text>|</xsl:text>
  <xsl:value-of select="."/>
  <xsl:text>
</xsl:text>
</xsl:template>

<xsl:template match="skos:example" mode="properties">
  <xsl:text>|Voorbeeld </xsl:text>
  <xsl:value-of select="@xml:lang"/>
  <xsl:text>|</xsl:text>
  <xsl:value-of select="."/>
  <xsl:text>
</xsl:text>
</xsl:template>

<xsl:template match="sh:NodeShape" mode="properties">
  <xsl:text>|!form data#</xsl:text>
  <xsl:value-of select="substring-after(@rdf:about,'#')"/>
  <xsl:text>!Klasse|</xsl:text>
  <xsl:value-of select="rdfs:label[@xml:lang='nl']"/>
  <xsl:text>
|----------|------
</xsl:text>
  <xsl:apply-templates select="sh:name" mode="properties"/>
  <xsl:apply-templates select="rdfs:comment" mode="properties"/>
  <xsl:apply-templates select="skos:example" mode="properties"/>
  <xsl:text>|Eigenschappen en relaties|</xsl:text>
  <xsl:for-each select="sh:property/sh:PropertyShape">
    <xsl:if test="position()!=1">, </xsl:if>
    <xsl:text>[</xsl:text>
    <xsl:value-of select="rdfs:label[@xml:lang='nl']"/>
    <xsl:text>](#</xsl:text>
    <xsl:value-of select="substring-after(@rdf:about,'#')"/>
    <xsl:text>)</xsl:text>
  </xsl:for-each>
</xsl:template>

<xsl:template match="rdf:RDF">
  <xsl:for-each select="sh:NodeShape[exists(rdfs:label)]">
    <xsl:text>## </xsl:text><xsl:value-of select="rdfs:label[@xml:lang='nl']"/><xsl:text>

</xsl:text>
  <xsl:apply-templates select="." mode="properties"/>
  </xsl:for-each>
</xsl:template>

</xsl:stylesheet>
