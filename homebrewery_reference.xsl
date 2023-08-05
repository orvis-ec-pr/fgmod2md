<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:msxsl="urn:schemas-microsoft-com:xslt" exclude-result-prefixes="msxsl"
>   
  <xsl:import href="homebrewery_standard.xsl" />
  
<xsl:preserve-space elements="desc" />
<xsl:template match="/root">

# Reference Manual
<xsl:apply-templates select="reference/refmanualdata" />

---

</xsl:template>

<xsl:template match="category">
## <xsl:value-of select="@name" />
  <xsl:apply-templates select="./*" />
</xsl:template>

<xsl:template match="reference/refmanualdata/*">
### <xsl:value-of select="name" />
  <xsl:for-each select="blocks/*">
    <xsl:sort select="order" />
<xsl:apply-templates select=".[./blocktype='header']" />
    <xsl:apply-templates select="image" /><xsl:text>

</xsl:text><xsl:apply-templates select="./*[@type='formattedtext'],./*[starts-with(local-name(self), 'text')]" />
\page
  </xsl:for-each>
</xsl:template>

<xsl:template match="blocks/*/image">
  <xsl:for-each select="layers/layer">
![IMAGE: <xsl:value-of select="name"/>](<xsl:value-of select="bitmap"/>)
  </xsl:for-each>
</xsl:template>

<xsl:template match="blocks/*/*[@type='formattedtext']">
  <xsl:apply-templates select="* | text()" />
</xsl:template>

<xsl:template match="blocks/*[./blocktype='header']">
#### <xsl:value-of select="./text" />
</xsl:template>

</xsl:stylesheet>
