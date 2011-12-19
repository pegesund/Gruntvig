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
    </xsl:template>


    <xsl:template match="tei:text">
        <xsl:apply-templates/>
    </xsl:template>

    <xsl:template match="tei:table">
            <xsl:apply-templates>
              <xsl:sort select="tei:cell[@type='norm']"/>
            </xsl:apply-templates>
    </xsl:template>

    <xsl:template match="tei:row">
        <div class="place_title refdiv">
            <xsl:attribute name="id">
                <xsl:value-of select="@xml:id"/>
            </xsl:attribute>
            <xsl:apply-templates/>
        </div>
    </xsl:template>

    <xsl:template match="tei:cell[@type='norm']">
        <b>
            <xsl:apply-templates/>
        </b>
    </xsl:template>

    <xsl:template match="tei:cell[@type='place']">
        <i>
            <xsl:apply-templates/>
        </i>
    </xsl:template>


</xsl:stylesheet>