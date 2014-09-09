<?xml version="1.0" encoding="ISO-8859-1"?>
<xsl:stylesheet
  xmlns="http://www.w3.org/1999/xhtml"
  exclude-result-prefixes="#all"
  version="2.0"
  xmlns:xlink="http://www.w3.org/1999/xlink"
  xmlns:dbk="http://docbook.org/ns/docbook"
  xmlns:rng="http://relaxng.org/ns/structure/1.0"
  xmlns:TEI="http://www.tei-c.org/ns/1.0"
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

    <xsl:template match="TEI:teiHeader">
    </xsl:template>

    <xsl:template match="TEI:head">
        <xsl:choose>
            <xsl:when test="@type='title1'">
                <div class="title1">
                    <xsl:apply-templates/>
                </div>
            </xsl:when>
            <xsl:when test="@type='title2'">
                <div class="title2">
                    <xsl:apply-templates/>
                </div>
            </xsl:when>
            <xsl:when test="not(@type)">
                <div class="headFront">
                    <xsl:apply-templates/>
                </div>
            </xsl:when>
        </xsl:choose>
    </xsl:template>
    
    <xsl:template match="TEI:graphic">
        <xsl:choose>
            <xsl:when test="@rend='longLine'">
                <div class="longLine">
                    <hr align="center" width="16%"/>
                </div>
            </xsl:when>
            <xsl:when test="@rend='shortLine'">
                <div class="shortLine">
                    <hr align="center" width="9%"/>
                </div>
            </xsl:when>
        </xsl:choose>
    </xsl:template>
    
    <xsl:template match="TEI:signer">
        <div class="signer">
            <xsl:apply-templates/>
        </div>
    </xsl:template>
    
    <xsl:template match="TEI:text">
        <xsl:apply-templates/>
    </xsl:template>

    <xsl:template match="TEI:p">
        <p class="veiledning">
            <xsl:apply-templates/>
        </p>
    </xsl:template>

    <xsl:template match="TEI:list[@type='decimal']">
        <ol class="decimal">
            <xsl:apply-templates/>
        </ol>
    </xsl:template>

    <xsl:template match="TEI:list[@type='simple']">
        <ul class="simple">
            <xsl:apply-templates/>
        </ul>
    </xsl:template>

    <xsl:template match="TEI:item">
        <li>
            <xsl:apply-templates/>
        </li>
    </xsl:template>
    
    <!--
    <xsl:template match="tei:hi">
        <span>
            <xsl:attribute name="class">
                <xsl:value-of select="concat('teihi ', @rend)"/>
            </xsl:attribute>
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    -->
    
    <xsl:template match="TEI:hi[@rend='italic']"> 
        <span style="font-style: italic">
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    
    <xsl:template match="TEI:hi[@rend='bold']"> 
        <span style="font-weight: bold">
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    
    <xsl:template match="TEI:hi[@rend='size-1']"> 
        <span style="font-size: 80%">
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    
    <xsl:template match="TEI:table"> 
        <table class="guideLine">
            <xsl:apply-templates/>
        </table>
    </xsl:template>
    
    <xsl:template match="TEI:row">        
        <tr>
            <xsl:apply-templates/>
        </tr>
    </xsl:template>
    
    <xsl:template match="TEI:cell">        
        <td style="font-size: 16px">
            <xsl:apply-templates/>
        </td>
    </xsl:template>
    
    <xsl:template match="TEI:ref[@type]">
            <xsl:choose>
                <xsl:when test="@type='docOut'">
                    <!--<a href="{@target}" target="_blank">-->
                       <xsl:apply-templates/>
                    <!--</a>-->
                </xsl:when>
                <xsl:when test="@type='web'">
                    <a href="{@target}" target="_blank">
                       <xsl:apply-templates/>
                    </a>
                </xsl:when>
            </xsl:choose>   
    </xsl:template>

    <xsl:include href="popups.xsl"/>

    <xsl:template match="TEI:div[@rend='treff']">
        <div class="{@rend}" style="background-color:white;padding:2px">
            <xsl:apply-templates/>
        </div>
    </xsl:template>

</xsl:stylesheet>