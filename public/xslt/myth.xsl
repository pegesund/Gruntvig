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

    <xsl:template match="tei:body">
            <xsl:apply-templates>
              <xsl:sort select="tei:p[@rend='normForm']"/>
            </xsl:apply-templates>
    </xsl:template>

  
    <xsl:template match="tei:text">
            <xsl:apply-templates/>
    </xsl:template>


    <xsl:template match="tei:div">
        <div class="myth refdiv">
             <xsl:attribute name="id">
                 <xsl:value-of select="@xml:id"/>
             </xsl:attribute>
            <xsl:apply-templates/>
        </div>
    </xsl:template>


    <xsl:template match="tei:p[@rend='normForm']">
        <p class="comment_title myth_title">
            <b>
                <xsl:apply-templates/>
            </b>
        </p>
    </xsl:template>

    <xsl:template match="tei:p[@rend='encyk']">
        <p class="encyk">
            <xsl:apply-templates/>
        </p>
    </xsl:template>

    <xsl:template match="tei:p[@rend='altForm']">
        <p class="altForm">
            Se også 
            <i>
                <xsl:apply-templates/>
            </i>
        </p>
    </xsl:template>

    <xsl:template match="tei:hi[@rend='italic']">
            <i>
                <xsl:apply-templates/>
            </i>
    </xsl:template>

    <xsl:template match="tei:hi[@rend='bold']">
            <b>
                <xsl:apply-templates/>
            </b>
    </xsl:template>

    <xsl:template match="tei:persName">
        <a class="persName">
                <xsl:attribute name="href">
                    <xsl:value-of select="@key"/>
                </xsl:attribute>
                <xsl:apply-templates/>
        </a>
    </xsl:template>

    <xsl:template match="tei:placeName">
        <a class="placeName">
                <xsl:attribute name="href">
                    <xsl:value-of select="@key"/>
                </xsl:attribute>
                <xsl:apply-templates/>
        </a>
    </xsl:template>

    <xsl:template match="tei:ref">
        <a class="ref">
                <xsl:attribute name="href">
                    <xsl:value-of select="@n"/>
                </xsl:attribute>
                <xsl:apply-templates/>
        </a>
    </xsl:template>


</xsl:stylesheet>