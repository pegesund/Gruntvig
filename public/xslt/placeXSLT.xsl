<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet 
    xmlns:TEI="http://www.tei-c.org/ns/1.0" 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    version="1.0">
        
    <xsl:strip-space elements="*"/>
    
    <!-- 2012.06.20: Karsten Kynde & Kim Steen Ravn
         2012.07.03: Karsten Kynde og Niels Holger Berg -->

    <xsl:template match="TEI:TEI">        
                <xsl:apply-templates select="TEI:text"/>
    </xsl:template>
    
    <xsl:template match="TEI:table">
        <div class="table">
            <xsl:apply-templates select="TEI:row/TEI:cell[@rend='name' or @rend='altNameDia' or @rend='altNameSyn']|TEI:row/TEI:cell/TEI:del">
                <xsl:sort select="translate(concat(text(),parent::TEI:cell), 'æøåÆØÅ ', '{|}{|}')"/>
            </xsl:apply-templates>
        </div>
    </xsl:template>
    
    <xsl:template match="TEI:head">
        <div class="head">
            <xsl:apply-templates/>
        </div>
    </xsl:template>
    
    <xsl:template match="TEI:cell[@rend='name']">
        <xsl:param name="copy"/>
        <div class="row">
            <xsl:if test="not($copy)">
                <xsl:attribute name="id"><xsl:value-of select="parent::TEI:row/@xml:id"/></xsl:attribute>
            </xsl:if>
            <span class="name">
                <xsl:call-template name="name-form">
                    <xsl:with-param name="name" select="."/>
                </xsl:call-template>
            </span>
            <xsl:call-template name="comma-sep-list">
                <xsl:with-param name="l" select="substring(parent::TEI:row/@xml:id,1,3)"/>
            </xsl:call-template>
            <xsl:apply-templates select="following-sibling::TEI:cell[@rend='altNameSyn']" mode="comma-sep"/>
            <xsl:apply-templates select="following-sibling::TEI:cell[@rend='altNameDia']" mode="comma-sep"/>
            <xsl:if test="not($copy or parent::TEI:row/@rend='noSynch')">
                <xsl:apply-templates select="parent::TEI:row/@synch"/>
            </xsl:if>
            <xsl:apply-templates select="following-sibling::TEI:cell[@rend='specify']"/>
            <xsl:apply-templates select="parent::TEI:row/@select"/>
            <xsl:apply-templates select="following-sibling::TEI:cell[@rend='explanation']"/>
            <xsl:call-template name="occurrences">
               <xsl:with-param name="key" select="parent::TEI:row/@xml:id"/>
               <xsl:with-param name="copy" select="$copy"/>
            </xsl:call-template>
            <xsl:apply-templates select="//TEI:row[@synch=current()/parent::TEI:row/@xml:id]/TEI:cell[@rend='name' or @rend='altNameDia' or @rend='altNameSyn']">
                <xsl:with-param name="copy" select="'yes'"/>
                <xsl:sort select="translate(., 'æøåÆØÅ ', '{|}{|}')"/>
            </xsl:apply-templates>
        </div>
    </xsl:template>

    <xsl:template match="TEI:cell[@rend='altNameSyn']" mode="comma-sep">
      <xsl:if test="position()=1"> (</xsl:if>
      <xsl:apply-templates/>
      <xsl:choose>
          <xsl:when test="following-sibling::TEI:cell[starts-with(@rend,'altName')]">
            <xsl:text>, </xsl:text>
          </xsl:when>
          <xsl:otherwise>
            <xsl:text>)</xsl:text>
          </xsl:otherwise>
      </xsl:choose>
    </xsl:template>

    <xsl:template match="TEI:cell[@rend='altNameDia']" mode="comma-sep">
      <xsl:if test="position()=1">
        <xsl:if test="not(preceding-sibling::TEI:cell[@rend='altNameSyn'])">
          <xsl:text> (</xsl:text>
        </xsl:if>
        <i>før </i>
      </xsl:if>
      <xsl:apply-templates/>
      <xsl:choose>
          <xsl:when test="following-sibling::TEI:cell[starts-with(@rend,'altName')]">
            <xsl:text>, </xsl:text>
          </xsl:when>
          <xsl:otherwise>
            <xsl:text>)</xsl:text>
          </xsl:otherwise>
      </xsl:choose>
    </xsl:template>

    <xsl:template match="@synch">
        <xsl:text> (</xsl:text>
        <a href="#{.}">
            <xsl:call-template name="name-form">
                <xsl:with-param name="name" select="//TEI:row[@xml:id=current()]/TEI:cell[@rend='name']"></xsl:with-param>
            </xsl:call-template>
        </a>
        <xsl:text>)</xsl:text>
    </xsl:template>
    
    <xsl:template match="@select">
        <xsl:text>, </xsl:text><i>se også </i>
        <a href="#{.}">
            <xsl:call-template name="name-form">
                <xsl:with-param name="name" select="//TEI:row[@xml:id=current()]/TEI:cell[@rend='name']"></xsl:with-param>
            </xsl:call-template>
        </a>
    </xsl:template>
    
    <xsl:template name="comma-sep-list"> <!-- modificeres -->
        <xsl:param name="l"/>
        <xsl:if test="$l!='fak'">
            <xsl:text>, </xsl:text>
            <xsl:choose>
                <xsl:when test="$l='fik'">fikt.</xsl:when>
                <xsl:when test="$l='poe'">poet.</xsl:when>
                <xsl:when test="$l='his'">hist.</xsl:when>
            </xsl:choose>
        </xsl:if>
    </xsl:template>
    
    <xsl:template match="TEI:cell[@rend='specify']">
        <span>
            <xsl:text>, </xsl:text>
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    
    <xsl:template match="TEI:cell[@rend='explanation']">
        <div>
            <xsl:text>[explanation: </xsl:text>
            <xsl:apply-templates/>
            <xsl:text>]</xsl:text>
        </div>
    </xsl:template>
    
    <xsl:template match="TEI:cell[starts-with(@rend,'altName')]"><!--#NHB2012-06-20 ændringer i dette afsnit-->
        <div class="row">
            <span class="altName">
                <xsl:call-template name="name-form">
                    <xsl:with-param name="name" select="."/>
                </xsl:call-template>
                <xsl:choose>
                    <xsl:when test="contains(@rend,'Dia')">
                        <xsl:text>, </xsl:text><i>nu </i><!--#NHB2012-06-20 rettet fra: nu > (hist.), se:-->
                    </xsl:when>
                    <xsl:when test="contains(@rend,'Syn')">
                        <xsl:text>, </xsl:text><i>se </i>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:text>, </xsl:text><i>se </i>
                    </xsl:otherwise>
                </xsl:choose>
                <a href="#{parent::TEI:row/@xml:id}">
                    <xsl:call-template name="name-form">
                        <xsl:with-param name="name" select="preceding-sibling::TEI:cell[@rend='name']"></xsl:with-param>
                    </xsl:call-template>
                </a>
                <xsl:text></xsl:text><!-- slettet parentes; altNameSyn skal tilpasses -->
            </span>
        </div>        
    </xsl:template>

    <xsl:template match="TEI:cell[@rend='name']/TEI:del[@rend='afterComma']">
        <div class="row">
            <span class="altName">
                <xsl:apply-templates/><xsl:text> </xsl:text><xsl:value-of select="normalize-space(parent::TEI:cell/text())"/>
                <xsl:text>, </xsl:text><i>se </i>
                <a href="#{ancestor::TEI:row/@xml:id}">
                    <xsl:call-template name="name-form">
                        <xsl:with-param name="name" select="parent::TEI:cell[@rend='name']"></xsl:with-param>
                    </xsl:call-template>
                </a>
            </span>
        </div>        
    </xsl:template>

    <xsl:template name="name-form">
        <xsl:param name="name"/>
        <xsl:value-of select="normalize-space($name/text())"/>
        <xsl:if test="$name/TEI:del[@rend='afterComma']">
            <xsl:text>, </xsl:text><xsl:value-of select="$name/TEI:del[@rend='afterComma']/text()"/>
        </xsl:if>
    </xsl:template>
    
    <xsl:template match="TEI:hi">
        <span class="{@rend}">
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    
    <xsl:template match="TEI:cell[@rend='facts']"/>

<!-- Forekomster -->

  <xsl:template name="occurrences">
    <xsl:param name="key"/>
    <xsl:param name="copy"/>
    <div>
    <span id="totp{$key}{$copy}" class="plus" onclick="showhide(this,'tot{$key}{$copy}')">+</span>
    <xsl:text> Forekomster</xsl:text>
    <xsl:apply-templates select="document('placeH.xml')//TEI:placeName[@key=current()/parent::TEI:row/@xml:id][1]">
      <xsl:with-param name="copy" select="$copy"/>
    </xsl:apply-templates>
    </div>
  </xsl:template>

  <xsl:template match="TEI:placeName">
    <xsl:param name="copy"/>
    <div id="tot{@key}{$copy}" class="occur">
    <span id="plusv{@key}{$copy}" class="plus" onclick="showhide(this,'occ{@key}{$copy}')">+</span>
    <xsl:text> </xsl:text>
    <xsl:value-of select="@copyOf"/>
    <table id="occ{@key}{$copy}" class="occur">
      <xsl:call-template name="occ"/>
      <xsl:for-each select="following-sibling::TEI:placeName[@key=current()/@key]">
        <xsl:call-template name="occ"/>
      </xsl:for-each>
    </table>
    </div>
  </xsl:template>
  
  <xsl:template name="occ">
      <tr>
        <td class="shortForm">
          <a href="{@copyOf}">
            <xsl:value-of select="@rend"/>
          </a>
        </td>
        <td class="textType">
          <xsl:choose>
            <xsl:when test="@role='com'">Kommentar</xsl:when>
            <xsl:when test="@role='txr'">Om teksten</xsl:when>
            <xsl:when test="@role='intro'">Indledning</xsl:when>
          </xsl:choose>
        </td>
      </tr>
  </xsl:template>

</xsl:stylesheet>