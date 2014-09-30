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
    
    <!--

    <xsl:template match="TEI:row"/>
    
    xPath: version 1.4
    
    ='28' or @n='29' or @n='34' or @n='52' or @n='61' or @n='63' or @n='65' or @n='67' or @n='68' or @n='73' or @n='76' or @n='80' or @n='81' or @n='82' or @n='83' or @n='84' or @n='85' or @n='86' or @n='87' or @n='88' or @n='89' or @n='93A' or @n='94' or @n='96' or @n='97' or @n='99A' or @n='105' or @n='106' or @n='107' or @n='108' or @n='109' or @n='111' or @n='113' or @n='115' or @n='116' or @n='117' or @n='118' or @n='121' or @n='122' or @n='123' or @n='125' or @n='169A' or @n='130' or @n='131' or @n='132' or @n='133' or @n='134' or @n='136' or @n='137' or @n='139A' or @n='140A' or @n='141' or @n='143' or @n='144' or @n='147' or @n='148A' or @n='149' or @n='157' or @n='193A' or @n='227A' or @n='255' or @n='281' or @n='308' or @n='329' or @n='330' or @n='331' or @n='332' or @n='342' or @n='397' or @n='413A' or @n='415' or @n='416' or @n='417' or @n='421A' or @n='433A' or @n='436A' or @n='487A' or @n='563' or @n='573' or @n='580' or @n='593' or @n='603' or @n='617' or @n='624a' or @n='680' or @n='741' or @n='874' or @n='891' or @n='898' or @n='896A' or @n='1155' or @n='1403'
    
    -->
    
    <xsl:template match="TEI:text/TEI:p">
        
    </xsl:template>
    
    <xsl:template match="TEI:table">
        <div class="table">
            <xsl:apply-templates select="TEI:row[@n]/TEI:cell[@rend='name' or @rend='altNameDia' or @rend='altNameSyn']">
                <xsl:sort select="translate(., 'æøåÆØÅ ', '{|}{|}')"/>
            </xsl:apply-templates>
        </div>
    </xsl:template>
    
    <xsl:template match="TEI:head">
    </xsl:template>

    <xsl:template match="TEI:del[@rend='afterComma']"/>
    
    <xsl:template match="TEI:del[@rend='afterComma']" mode="afterComma">

        <xsl:text>, </xsl:text>
        <xsl:apply-templates/>

    </xsl:template>
    
    <xsl:template match="TEI:cell[@rend='name']">
        <xsl:param name="copy"/>
        <div class="row">
          <xsl:if test="not($copy)">
                <xsl:attribute name="id"><xsl:value-of select="parent::TEI:row/@xml:id"/></xsl:attribute>
          </xsl:if>
          
          <span class="placeHeader">
            <span class="placeName">
                <xsl:apply-templates/>
                <xsl:apply-templates select="TEI:del[@rend='afterComma']" mode="afterComma"/>
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
         </span>
          <div class="placeContent">
            <xsl:apply-templates select="following-sibling::TEI:cell[@rend='explanation']"/>
            <xsl:apply-templates select="following-sibling::TEI:cell[@rend='facts']"/>
          </div>
            <!--<xsl:apply-templates select="document('placeH.xml')//TEI:placeName[@key=current()/parent::TEI:row/@xml:id]"/>-->
            <xsl:if test="not($copy)">
                <xsl:apply-templates select="//TEI:row[@synch=current()/parent::TEI:row/@xml:id]/TEI:cell[@rend='name']">
                    <xsl:with-param name="copy" select="'yes'"/>
                    <xsl:sort select="translate(., 'æøåÆØÅ ', '{|}{|}')"/>
                </xsl:apply-templates>
            </xsl:if> 
        </div>
    </xsl:template>


    <xsl:template match="TEI:cell[@rend='altNameSyn']" mode="comma-sep">
      <xsl:if test="position()=1"> (</xsl:if>
      <xsl:apply-templates/>
        <xsl:apply-templates select="TEI:del[@rend='afterComma']" mode="afterComma"/>
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

    <xsl:template match="TEI:cell[@rend='name']" mode="par">
      <xsl:text> (</xsl:text>
      <xsl:apply-templates/>
      <xsl:text>)</xsl:text>
    </xsl:template>

    <xsl:template match="@synch">
        <xsl:text> (</xsl:text>
        <a href="steder#{.}">
            <xsl:value-of select="//TEI:row[@xml:id=current()]/TEI:cell[@rend='name']"/>
        </a>
        <xsl:text>)</xsl:text>
    </xsl:template>
    
    <xsl:template match="@select">
        <xsl:text>, </xsl:text><i>se også </i>
        <a href="steder#{.}">
            <xsl:value-of select="//TEI:row[@xml:id=current()]/TEI:cell[@rend='name']"/>
        </a>
    </xsl:template>
    
    <xsl:template name="comma-sep-list"> <!-- modificeres -->
        <xsl:param name="l"/>
        <xsl:if test="$l!='fak'">
            <xsl:text> (</xsl:text>
            <xsl:choose>
                <xsl:when test="$l='fik'">fikt.</xsl:when>
                <xsl:when test="$l='poe'">poet.</xsl:when>
                <xsl:when test="$l='his'">hist.</xsl:when>
            </xsl:choose>
            <xsl:text>)</xsl:text>
        </xsl:if>
    </xsl:template>

<!--
    <xsl:template match="TEI:placeName">
        <div class="txt">
            <a href="{@copyOf}">
                <xsl:value-of select="@rend"/>, <xsl:value-of select="@role"/>
            </a>
        </div>
    </xsl:template>
 -->

  <xsl:template match="TEI:placeName">
    <div>
    <span id="plusv{@key}" class="plus" onclick="showhide(this,'occ{translate(@key,' ','_')}')">+</span>
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
      <tr>
        <td class="shortForm">
          <a href="steder{@copyOf}">
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

    
    <xsl:template match="TEI:cell[@rend='specify']">
        <span>
            <xsl:text> </xsl:text>
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    
    <xsl:template match="TEI:cell[@rend='explanation']">
        <div class="explanation">
            <xsl:apply-templates/>
        </div>
    </xsl:template>
    
    <xsl:template match="TEI:cell[starts-with(@rend,'altName')]"><!--#NHB2012-06-20 ændringer i dette afsnit-->
        <div class="row">
          <span class="placeHeader">  
            <span class="placeAltName">
                <xsl:apply-templates/>
                <xsl:choose>
                    <xsl:when test="contains(@rend,'Dia')">
                        <xsl:text>, </xsl:text><i>nu: </i><!--#NHB2012-06-20 rettet fra: nu > (hist.), se:-->
                    </xsl:when>
                    <xsl:when test="contains(@rend,'Syn')">
                        <xsl:text>, </xsl:text><i>se </i>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:text>, </xsl:text><i>se </i>
                    </xsl:otherwise>
                </xsl:choose>
                <a href="steder#{parent::TEI:row/@xml:id}">
                    <xsl:value-of select="preceding-sibling::TEI:cell[@rend='name']"/>
                </a>
                <xsl:text></xsl:text><!-- slettet parentes; altNameSyn skal tilpasses -->
            </span>
          </span>  
        </div>        
    </xsl:template>
    
    <xsl:template match="TEI:hi">
        <span class="{@rend}">
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    
    <xsl:template match="TEI:cell[@rend='facts']">
        <div class="fact">
            <xsl:apply-templates/>
        </div>
    </xsl:template>

</xsl:stylesheet>