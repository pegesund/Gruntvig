<?xml version="1.0" encoding="UTF-8"?>
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

<!-- 
     KSR:
     2011.08.24: addName, delimiter etc
     2011.04.06
-->

    <xsl:template match="tei:TEI">
        
       
                <xsl:apply-templates select="tei:text"/>
        
        
    </xsl:template>
    
    <xsl:template match="tei:table">
        <div class="table">
            <xsl:apply-templates select="tei:row/tei:cell[@rend='name' or @rend='altName']">
                <xsl:sort select="translate(concat(tei:note[@type='lastName'], tei:note[@type='firstName']), 'æøåÆØÅ ', '{|}{|}')"/>
            </xsl:apply-templates>
        </div>
    </xsl:template>
    
    
    <xsl:template match="tei:row">
        <div class="myth refdiv">
             <xsl:attribute name="id">
                 <xsl:value-of select="@xml:id"/>
             </xsl:attribute>
            <xsl:apply-templates/>
        </div>
    </xsl:template>
    
    
    <xsl:template match="tei:cell[@rend='name']">
        <div class="row" id="{parent::tei:row/@xml:id}">
            <span class="name">
                <xsl:call-template name="name"/>
            </span>
            <xsl:apply-templates select="following-sibling::tei:cell[@rend='year']"/>
            <xsl:if test="following-sibling::tei:cell[@rend!='year']">
                <xsl:text>, </xsl:text>
            </xsl:if>
            <xsl:apply-templates select="tei:note/tei:addName[@type='birthName']"/>
            <xsl:apply-templates select="tei:note/tei:addName[@type='ladyName']"/>
            <xsl:apply-templates select="tei:note/tei:addName[@type='original']"/>
            <xsl:apply-templates select="following-sibling::tei:cell[@rend='nation']"/>
            <xsl:apply-templates select="following-sibling::tei:cell[@rend='encyc']"/>
            <xsl:text>.</xsl:text>
        </div>
    </xsl:template>
    
    <xsl:template match="tei:cell[@rend='altName']">
        <div class="row">
            <span class="altName">
                <xsl:call-template name="name"/>
                <xsl:text> (se: </xsl:text>
                <a href="#{parent::tei:row/@xml:id}">
                    <xsl:for-each select="preceding-sibling::tei:cell[@rend='name']">                        
                        <xsl:call-template name="name"/>                        
                    </xsl:for-each>                
                </a>
                <xsl:text>)</xsl:text>
            </span>
        </div>        
    </xsl:template>
    
    <xsl:template name="name">        
        <xsl:if test="tei:note[@type='lastName']">
            <xsl:apply-templates select="tei:note[@type='lastName']"/>
            <xsl:text>, </xsl:text>
        </xsl:if>
        <xsl:apply-templates select="tei:note[@type='firstName']"/>
    </xsl:template>
    
    <xsl:template match="tei:note">
        <!-- firstName eller lastName springer addName="etc" over -->
        <xsl:apply-templates select="text()|tei:hi|tei:addName[@type!='birthName' and @type!='ladyName' and @type!='original']"/>
    </xsl:template>
    
    <!-- prædikat eller choose; when dette er dårlig stil -->
    
    <xsl:template match="tei:addName">
        <span class="addName">
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
                <xsl:text> egl. </xsl:text>
                <xsl:apply-templates/>
                <xsl:text>, </xsl:text>
            </xsl:if>
        </span>
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
    <!-- built-in rule -->
    
    <xsl:template name="delimiterComma">
        <xsl:if test="following-sibling::tei:cell">
                <xsl:text>, </xsl:text>
        </xsl:if>
    </xsl:template>
    
    <!-- intern redaktion etc: -->
    
    <!--
        
        <xsl:template match="tei:row[@xml:id]">
        <div class="row">
        <div class="xmlID">
        <text>xml:id </text>
        <xsl:value-of select="@xml:id"/>
        <text>&#x25AA; SJ-nr: </text>
        <xsl:value-of select="@n"/>
        </div>            
        <xsl:apply-templates/>
        </div>
        </xsl:template>
        
    -->

</xsl:stylesheet>