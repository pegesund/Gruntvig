<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet
  xmlns="http://www.w3.org/1999/xhtml"
  exclude-result-prefixes="#default a fo html local rng tei teix xd"
  version="2.0"
  xmlns:a="http://relaxng.org/ns/compatibility/annotations/1.0"
  xmlns:fo="http://www.w3.org/1999/XSL/Format"
  xmlns:html="http://www.w3.org/1999/xhtml"
  xmlns:local="http://www.pantor.com/ns/local"
  xmlns:rng="http://relaxng.org/ns/structure/1.0"
  xmlns:tei="http://www.tei-c.org/ns/1.0"
  xmlns:teix="http://www.tei-c.org/ns/Examples"
  xmlns:xd="http://www.pnp-software.com/XSLTdoc"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">


    <xsl:template match="tei:persName">
        <a class="persName">
            <xsl:attribute name="href">
                <xsl:value-of select="concat('ajax/getReference/', @key)"/>
            </xsl:attribute>
            <xsl:attribute name="rel">
                <xsl:value-of select="concat('ajax/getReference/', @key)"/>
            </xsl:attribute>
            <xsl:apply-templates/>
        </a>
    </xsl:template>

    <xsl:template match="tei:placeName">
        <a class="placeName">
            <xsl:attribute name="href">
                <xsl:value-of select="concat('ajax/getReference/', @key)"/>
            </xsl:attribute>
            <xsl:attribute name="rel">
                <xsl:value-of select="concat('ajax/getReference/', @key)"/>
            </xsl:attribute>
            <xsl:apply-templates/>
        </a>
    </xsl:template>

    <xsl:template match="tei:rs[@type='myth']">
        <a class="myth rs_myth">
            <xsl:attribute name="href">
                <xsl:value-of select="concat('ajax/getReference/', @key)"/>
            </xsl:attribute>
            <xsl:attribute name="rel">
                <xsl:value-of select="concat('ajax/getReference/', @key)"/>
            </xsl:attribute>
            <xsl:apply-templates/>
        </a>
    </xsl:template>
    
     <xsl:template match="tei:rs[@type='rs_bible']">
        <a class="rs_bible comment_ref">
            <xsl:attribute name="href">
                <xsl:value-of select="concat('ajax/getReference/', @key)"/>
            </xsl:attribute>
            <xsl:attribute name="rel">
                <xsl:value-of select="concat('ajax/getReference/', @key)"/>
            </xsl:attribute>
            <xsl:attribute name="rend">
                <xsl:value-of select="concat('ajax/getReference/', @rend)"/>
            </xsl:attribute>
            <xsl:apply-templates/>
        </a>
    </xsl:template>

    <xsl:template match="tei:rs[@type='title']">
        <span class="rs_title">
            <xsl:apply-templates/>
        </span>
    </xsl:template>
                

    <xsl:template match="tei:ref">
        <a class="comment_ref">
            <xsl:apply-templates/>
        </a>
    </xsl:template>

    </xsl:stylesheet>
    
