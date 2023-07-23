<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:msxsl="urn:schemas-microsoft-com:xslt" exclude-result-prefixes="msxsl"
>   
  <xsl:import href="homebrewery_npcstatblock.xsl" />
  
<xsl:preserve-space elements="desc" />
<xsl:template match="/root">

# Encounters
<xsl:apply-templates select="encounter" />

---

# Cast of Characters

<xsl:apply-templates select="npc" />

---

# Battles
<xsl:apply-templates select="battle" />

\page
---

# Quests
<xsl:apply-templates select="quest" />

\page
---

# Reference Manual
<xsl:apply-templates select="reference/refmanualdata" />

---

</xsl:template>

<xsl:template match="category">
## <xsl:value-of select="@name" />
  <xsl:apply-templates select="./*" />
</xsl:template>

<xsl:template match="battle/category/*">
### Battle: <xsl:value-of select="name" />
<xsl:text>

</xsl:text>
  *Challenge Rating <xsl:value-of select="cr" />, <xsl:value-of select="exp" /> XP*
  <xsl:for-each select="npclist/*">
    <xsl:choose><xsl:when test="contains(token, '@')">
      <xsl:text>
- </xsl:text>(<xsl:value-of select="substring-after(token, '@')" />)
</xsl:when>
<xsl:otherwise><xsl:text>
![- ](</xsl:text>
<xsl:value-of select="token"/>
	<xsl:text> "</xsl:text>
	<xsl:value-of select="name"/>
	<xsl:text>"</xsl:text>
<xsl:text>)</xsl:text> {width:60px,mix-blend-mode:multiply}</xsl:otherwise></xsl:choose> **<xsl:value-of select="count" /><xsl:text> </xsl:text><xsl:value-of select="name" />**<xsl:text>

  </xsl:text>
  </xsl:for-each>
</xsl:template>

<xsl:template match="encounter/category/*">
### Encounter: <xsl:value-of select="name" />
<xsl:text>

</xsl:text>
  <xsl:apply-templates select="text" />
\page
</xsl:template>
  
<xsl:template match="quest/category/*">
### Quest: <xsl:value-of select="name" /> (<xsl:value-of select="xp" /> XP)
<xsl:text>

</xsl:text>
  <xsl:apply-templates select="description/*" /> 
</xsl:template>

<xsl:template match="reference/refmanualdata/*">
### <xsl:value-of select="name" />
  <xsl:for-each select="blocks/*">
    <xsl:apply-templates select="image" /><xsl:text>

</xsl:text><xsl:apply-templates select="text" />
\page
  </xsl:for-each>
</xsl:template>

<xsl:template match="blocks/*/image">
  <xsl:for-each select="layers/layer">
![IMAGE: <xsl:value-of select="name"/>](<xsl:value-of select="bitmap"/>)
  </xsl:for-each>
</xsl:template>

<xsl:template match="blocks/*/text">
  <xsl:apply-templates select="* | text()" />
</xsl:template>

<xsl:template match="p">
<xsl:apply-templates select="* | text()"/><xsl:text>

</xsl:text>
</xsl:template>

<xsl:template match="h">
<xsl:text>##### </xsl:text><xsl:apply-templates select="* | text()"/>

<xsl:text>

</xsl:text>
</xsl:template>

<xsl:template match="b">
<xsl:text> **</xsl:text><xsl:apply-templates select="* | text()"/><xsl:text>** </xsl:text>
</xsl:template>

<xsl:template match="*/i[not(self::b)]">
<xsl:text> _</xsl:text><xsl:apply-templates select="* | text()"/><xsl:text>_ </xsl:text>
</xsl:template>

<xsl:template match="b/i">
<xsl:text>*</xsl:text><xsl:apply-templates select="* | text()"/><xsl:text>*</xsl:text>
</xsl:template>

<xsl:template match="list">
  <xsl:apply-templates select="li"/>
</xsl:template>

<xsl:template match="li">
  - <xsl:apply-templates select="text()" />
</xsl:template>

<xsl:template match="linklist">
<xsl:apply-templates select="link"/>
</xsl:template>

<xsl:template match="frame">
{{descriptive
<xsl:apply-templates select="* | text()"/><xsl:text>
</xsl:text>
}}
</xsl:template>

<xsl:template match="text()">
<xsl:value-of select="normalize-space(.)"/>
</xsl:template>

<xsl:template match="linklist/link">
<xsl:text>
- </xsl:text><xsl:value-of select="upper-case(@class)" />: <xsl:apply-templates select="* | text()" /> <xsl:choose>
<xsl:when test="contains(@recordname, '@')">(<xsl:value-of select="substring-after(@recordname, '@')" />)</xsl:when>
</xsl:choose>
<xsl:text>
</xsl:text>
</xsl:template>
	
<xsl:template name="markdown-code-block">
<xsl:param name="input"/>
<xsl:param name="value">
	<xsl:choose>
	<xsl:when test="contains($input,'&#xa;')">
		<xsl:value-of select="substring-before($input,'&#xa;')"/>
	</xsl:when>
	<xsl:otherwise>
		<xsl:value-of select="$input"/>
	</xsl:otherwise>
	</xsl:choose>
</xsl:param>
<xsl:param name="remaining-values" select="substring-after($input,'&#xa;')"/>
<xsl:value-of select="substring-before($input,'&#xa;')"/><xsl:text>&#xa;    </xsl:text>
<xsl:if test="$remaining-values != ''">
	<xsl:call-template name="markdown-code-block">
	<xsl:with-param name="input" select="$remaining-values"/>
	</xsl:call-template>
</xsl:if>
</xsl:template>

<xsl:template match="img" priority="1">
<xsl:text>![</xsl:text>
<xsl:value-of select="@alt"/>
<xsl:text>](</xsl:text>
<xsl:value-of select="@src"/>
<xsl:if test="@title">
	<xsl:text> "</xsl:text>
	<xsl:value-of select="@title"/>
	<xsl:text>"</xsl:text>
</xsl:if>
<xsl:text>)</xsl:text>
</xsl:template>

</xsl:stylesheet>
