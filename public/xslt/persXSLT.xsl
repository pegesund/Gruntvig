<?xml version="1.0" encoding="ISO-8859-1"?>
<xsl:stylesheet
  xmlns="http://www.w3.org/1999/xhtml"
  exclude-result-prefixes="#default a fo local dbk xlink xhtml rng tei teix xd"
  version="2.0"
  xmlns:xlink="http://www.w3.org/1999/xlink"
  xmlns:dbk="http://docbook.org/ns/docbook"
  xmlns:rng="http://relaxng.org/ns/structure/1.0"
  xmlns:tei="http://www.tei-c.org/ns/1.0"
  xmlns:teix="http://www.tei-c.org/ns/Examples"
  xmlns:xhtml="http://www.w3.org/1999/xhtml"
  xmlns:a="http://relaxng.org/ns/compatibility/annotations/1.0"
  xmlns:fo="http://www.w3.org/1999/XSL/Format"
  xmlns:html="http://www.w3.org/1999/xhtml"
  xmlns:local="http://www.pantor.com/ns/local"
  xmlns:xd="http://www.pnp-software.com/XSLTdoc"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

    <xsl:template match="/">
            <div class="root">
                <xsl:apply-templates/>
            </div>
    </xsl:template>

    <xsl:template match="tei:teiHeader">
    </xsl:template>

    <xsl:template match="tei:head">
            <xsl:apply-templates/>
    </xsl:template>


    <xsl:template match="tei:text">
            <xsl:apply-templates/>
    </xsl:template>
    
    <!--
    <xsl:template match="tei:table">
        <xsl:apply-templates>
            <xsl:sort select="translate(concat(tei:note[@type='lastName'], tei:note[@type='firstName']), 'æøåÆØÅ ', '{|}{|}')"/>
        </xsl:apply-templates>
    </xsl:template>
    
    <xsl:template match="tei:row"/>
    
    <Patn, version 14:
    
    ='T' or @n='28' or @n='29' or @n='34' or @n='52' or @n='61' or @n='63' or @n='65' or @n='67' or @n='68' or @n='73' or @n='76' or @n='80' or @n='81' or @n='82' or @n='83' or @n='84' or @n='85' or @n='86' or @n='87' or @n='88' or @n='89' or @n='93A' or @n='94' or @n='96' or @n='97' or @n='99A' or @n='105' or @n='106' or @n='107' or @n='108' or @n='109' or @n='111' or @n='113' or @n='115' or @n='116' or @n='117' or @n='118' or @n='121' or @n='122' or @n='123' or @n='125' or @n='169A' or @n='130' or @n='131' or @n='132' or @n='133' or @n='134' or @n='136' or @n='137' or @n='139A' or @n='140A' or @n='141' or @n='143' or @n='144' or @n='147' or @n='148A' or @n='149' or @n='157' or @n='193A' or @n='227A' or @n='255' or @n='281' or @n='308' or @n='329' or @n='330' or @n='331' or @n='332' or @n='342' or @n='397' or @n='413A' or @n='415' or @n='416' or @n='417' or @n='421A' or @n='433A' or @n='436A' or @n='487A' or @n='563' or @n='573' or @n='580' or @n='593' or @n='603' or @n='617' or @n='624a' or @n='680' or @n='741' or @n='874' or @n='891' or @n='898' or @n='896A' or @n='1155' or @n='1403'
   -->
   
    <xsl:template match="tei:row[@n]">
        <div class="person refdiv">
             <xsl:attribute name="id">
                 <xsl:value-of select="@xml:id"/>
             </xsl:attribute>
            <xsl:apply-templates select="tei:cell[@rend='name']"/>
        </div>
        <xsl:apply-templates select="tei:cell[@rend='altName']"/>
    </xsl:template>    
    
    <xsl:template match="tei:note[@type='firstName']">
        <xsl:apply-templates select="text()|tei:hi|tei:addName[@type!='birthName' and @type!='ladyName' and @type!='original']"/><!--  and @type!='patronym' and @type!='metronym' -->
    </xsl:template>
    
    <xsl:template match="tei:note[@type='lastName']">
        <xsl:apply-templates select="text()|tei:hi|tei:addName[@type!='birthName' and @type!='ladyName' and @type!='orthography' and @type!='original']"/>
    </xsl:template>
    
    <xsl:template match="tei:cell[@rend='name']">
        <!-- <div class="row" id="{parent::tei:row/@xml:id}"> -->
            <div class="row">
            <span class="name">
                <xsl:call-template name="name"/>
            </span>
            <xsl:apply-templates select="following-sibling::tei:cell[@rend='year']"/>
            <xsl:if test="following-sibling::tei:cell[@rend='encyc']">
                <xsl:text>, </xsl:text>
            </xsl:if>
            <xsl:apply-templates select="tei:note/tei:addName[@type='birthName']"/>
            <xsl:apply-templates select="tei:note/tei:addName[@type='ladyName']"/>
            <!--<xsl:apply-templates select="tei:note/tei:addName[@type='orthography']"/>-->
            <xsl:apply-templates select="tei:note/tei:addName[@type='original']"/>
            <xsl:apply-templates select="following-sibling::tei:cell[@rend='nation']"/>
            <xsl:apply-templates select="following-sibling::tei:cell[@rend='encyc']"/>
            <xsl:text>.</xsl:text>
        </div>
    </xsl:template>
    
    <xsl:template match="tei:cell[@rend='altName']">
      <div class="person refdiv">
        <div class="row">
            <span class="altName name">
                <xsl:call-template name="name"/>
            </span>
            <span class="gotoName">
                    <xsl:text> &#x2003;&#8594;&#x2003; </xsl:text>
                    <a href="#{parent::tei:row/@xml:id}">
                        <xsl:for-each select="preceding-sibling::tei:cell[@rend='name']">                        
                            <xsl:call-template name="name"/>
                        </xsl:for-each>                
                    </a>
                </span>
        </div>  
      </div>      
    </xsl:template>

    <xsl:template name="name">        
        <xsl:if test="tei:note[@type='lastName']">
            <xsl:apply-templates select="tei:note[@type='lastName']"/>
            <xsl:text>, </xsl:text>
        </xsl:if>
        <xsl:apply-templates select="tei:note[@type='firstName']"/>
    </xsl:template>
    
    <!--
    <xsl:template match="tei:note">
        firstName eller lastName springer addName= etc over 
        <xsl:apply-templates select="text()|tei:hi|tei:addName[@type!='birthName' and @type!='ladyName']"/>
    </xsl:template>
    -->
    
     <xsl:template match="tei:addName">
        <div class="addName">
            <xsl:if test="@type='birthName'">
                <xsl:text> f. </xsl:text>
                <xsl:apply-templates/>
                <xsl:text>, </xsl:text>                
            </xsl:if>
            <xsl:if test="@type='epithet'">
                <xsl:text> (</xsl:text>
                <xsl:apply-templates/>
                <xsl:text>)</xsl:text>
            </xsl:if>
            <xsl:if test="@type='ladyName'">
                <xsl:text> g. </xsl:text>
                <xsl:apply-templates/>
                <xsl:text>, </xsl:text>
            </xsl:if>
            <xsl:if test="@type='nickName'">
                <xsl:text> (</xsl:text>
                <xsl:apply-templates/>
                <xsl:text>)</xsl:text>
            </xsl:if>
            <xsl:if test="@type='orthography'">
                <xsl:text> (eller: </xsl:text>
                <xsl:apply-templates/>
                <xsl:text>)</xsl:text>
            </xsl:if>
            <xsl:if test="@type='original'">
                <xsl:text> egl. </xsl:text>
                <xsl:apply-templates/>
                <xsl:text>, </xsl:text>
            </xsl:if>
            <xsl:if test="@type='patronym'">
                <xsl:apply-templates/>
            </xsl:if>
            <xsl:if test="@type='metronym'">
                <xsl:apply-templates/>
            </xsl:if>
        </div>
    </xsl:template>
    
    <xsl:template match="tei:cell[@rend='year']">
        <span class="year">
            (<xsl:apply-templates/>
            <xsl:text>)</xsl:text>
        </span>
    </xsl:template>
    
    <xsl:template match="tei:cell[@rend='nation']">
        <span class="nation">
            <xsl:apply-templates/>
            <xsl:choose>
                <xsl:when test="@select='comma'">
                    <xsl:text>, </xsl:text>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:text> </xsl:text>
                </xsl:otherwise>
            </xsl:choose>                    
        </span>
    </xsl:template>
    
    <!-- mest specifikke giver komma, ellers uden ?? -->
    
    <xsl:template match="tei:cell[@rend='encyc']">
        <span class="encyk">
            <xsl:apply-templates/>            
        </span>
    </xsl:template>
    
    <xsl:template match="tei:hi">
        <span class="{@rend}">
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    
    <xsl:template match="tei:cell[@rend='facts']"/>
    
    <xsl:template name="delimiterComma">
        <xsl:if test="following-sibling::tei:cell">
                <xsl:text>, </xsl:text>
        </xsl:if>
    </xsl:template>
    
</xsl:stylesheet>