<?xml version="1.0" encoding="UTF-8"?>
<!--
  bible_XSLT.xsl
  (c) Karsten Kynde 2011-12-03
  til brug for Grundtvigs Værker
-->
<xsl:stylesheet
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:TEI="http://www.tei-c.org/ns/1.0"
  version="1.0">

  <xsl:template match="/">
    <div class="bible_content">
        <h1 class="head">
          <xsl:apply-templates select="//TEI:teiHeader/TEI:title"/>
        </h1>
        <xsl:apply-templates select="//TEI:text"/>
    </div>
  </xsl:template>

  <xsl:template match="TEI:div">
      <div id="{@xml:id}" class="book">
        <span id="plusb{@xml:id}" class="plusBook" onclick="showhide(this,'verse{@xml:id}')">+</span>
        <xsl:text> </xsl:text>
        <xsl:value-of select="translate(@xml:id,'_',' ')"/>
        <span id="verse{@xml:id}" class="verse">
          <xsl:apply-templates select="TEI:rs[1]"/>          
        </span>        
      </div>
  </xsl:template>

  <xsl:template match="TEI:rs">
    <div>
    <span id="plusv{@key}" class="plusVerse" onclick="showhide(this,'occ{translate(@key,' ','_')}')">+</span>
    <xsl:text> </xsl:text>
    <xsl:value-of select="@key"/>
    <table id="occ{translate(@key,' ','_')}" class="occur">
      <xsl:call-template name="occ"/>
      <xsl:for-each select="following-sibling::TEI:rs[@key=current()/@key]">
        <xsl:call-template name="occ"/>
      </xsl:for-each>
    </table>
    </div>
    <xsl:apply-templates select="following-sibling::TEI:rs[@key!=current()/@key][1]"/>
  </xsl:template>
  
  <xsl:template name="occ">
      <tr class="occur">
        <td class="shortForm">
          <a href="{@copyOf}">
            <td class="shortForm">
            <a href="{@copyOf}">
              <xsl:value-of select="@rend"/>
            </a>
          </td>
            <!--
              skel mellem selvstændig titel og titel fra værk
              <xsl:choose>
              <xsl:when test="@rendition='part'">
                &#x201C;<xsl:value-of select="@rend"/>&#x201D;                
              </xsl:when>
              <xsl:when test="@rendition='main'">
                <i><xsl:value-of select="@rend"/></i>                
              </xsl:when>
            </xsl:choose>-->
          </a>
        </td>
        <td class="textType">
          <xsl:choose>
            <!--<xsl:when test="@role='txt'">&#x25B8; Tekst</xsl:when>-->
            <xsl:when test="@role='com'">&#x25B8; Kommentarer</xsl:when>
            <xsl:when test="@role='txr'">&#x25B8; Tekstredegørelse</xsl:when>
            <xsl:when test="@role='intro'">&#x25B8; Indledning</xsl:when>
          </xsl:choose>
        </td>
      </tr>
    
    
    
  </xsl:template>

</xsl:stylesheet>
