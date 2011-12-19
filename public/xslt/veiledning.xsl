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
        <h2>
            <xsl:apply-templates/>
        </h2>
    </xsl:template>


    <xsl:template match="tei:text">
        <xsl:apply-templates/>
    </xsl:template>

    <xsl:template match="tei:p">
        <p class="veiledning">
            <xsl:apply-templates/>
        </p>
    </xsl:template>

    <xsl:template match="tei:list">
        <ol style="list-style-type: decimal; margin-left: 15px; padding-left: 15px">
            <xsl:apply-templates/>
        </ol>
    </xsl:template>

    <xsl:template match="tei:item">
        <li>
            <xsl:apply-templates/>
        </li>
    </xsl:template>


    <xsl:template match="tei:hi">
        <span>
            <xsl:attribute name="class">
                <xsl:value-of select="concat('teihi ', @rend)"/>
            </xsl:attribute>
            <xsl:apply-templates/>
        </span>
    </xsl:template>


    <xsl:include href="popups.xsl"/>


</xsl:stylesheet>