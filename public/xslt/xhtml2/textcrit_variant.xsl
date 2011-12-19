<?xml version="1.0" encoding="utf-8"?>
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
    <xd:doc type="stylesheet">
        <xd:short> TEI stylesheet dealing with elements from the textcrit
      module, making HTML output.
        </xd:short>
        <xd:detail> This library is free software; you can redistribute it and/or
      modify it under the terms of the GNU Lesser General Public License as
      published by the Free Software Foundation; either version 2.1 of the
      License, or (at your option) any later version. This library is
      distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY;
      without even the implied warranty of MERCHANTABILITY or FITNESS FOR A
      PARTICULAR PURPOSE. See the GNU Lesser General Public License for more
      details. You should have received a copy of the GNU Lesser General Public
      License along with this library; if not, write to the Free Software
      Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA xs
        </xd:detail>
        <xd:author>PE</xd:author>
        <xd:cvsId>$Id: textcrit.xsl 5845 2009-03-19 19:22:05Z rahtz $</xd:cvsId>
        <xd:copyright>2008, TEI Consortium</xd:copyright>
    </xd:doc>

    <xsl:template match="tei:app">
        <span>
            <xsl:attribute name="class">
                <xsl:choose>
                    <xsl:when test="substring(@type,1,3) ='sub'">
                        <xsl:text>substantial </xsl:text>
                    </xsl:when>
                    <xsl:when test="substring(@type,1,3) ='int'">
                        <xsl:text>interpunction </xsl:text>
                    </xsl:when>
                    <xsl:when test="substring(@type,1,3) ='ide'">
                        <xsl:text>identical </xsl:text>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:text>orthographic </xsl:text>
                    </xsl:otherwise>
                </xsl:choose>
                <xsl:text>variantScrollTarget </xsl:text>
                <xsl:value-of select="@id" />
            </xsl:attribute>
            <xsl:call-template name="variantMouseOver" />
            <xsl:apply-templates/>
        </span>
    </xsl:template>

    <xsl:template match="tei:lem"/>

    <xsl:template match="tei:rdg">
        <xsl:choose>
            <xsl:when test="@type='empty'">
                <span class="seg">
                    <img
src="images/squared_times.png"/>
                </span>
            </xsl:when>
            <xsl:otherwise>
                <xsl:apply-templates/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <xsl:template match="tei:anchor">
        <span class="anchor">
            <xsl:attribute name="class">
                <xsl:text>anchor anchorScrollTarget </xsl:text>
                <xsl:value-of select="@id" />
            </xsl:attribute>
            <xsl:choose>
                <xsl:when test="contains(@id, 'a')">
                    <img src="images/ms_arrow_right.png"/>
                </xsl:when>
                <xsl:otherwise>
                    <img src="images/ms_arrow_left.png"/>
                </xsl:otherwise>
            </xsl:choose>
        </span>
    </xsl:template>

    <xsl:template name="variantMouseOver">
        <xsl:if test="@type">
            <xsl:attribute name="onmouseover">
<!-- Tip är en javascript-funktion för att visa enkla
tooltips i webbläsaren -->
                <xsl:text>Tip("</xsl:text>
                <xsl:choose>
                    <xsl:when test="substring(@type,1,3)='sub'">
                        <xsl:text>substantiell skille</xsl:text>
                    </xsl:when>
                    <xsl:when test="substring(@type,1,3)='int'">
                        <xsl:text>skille i interpunktion</xsl:text>
                    </xsl:when>
                    <xsl:when test="substring(@type,1,3)='ide'">
                        <xsl:text>identiskt</xsl:text>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:text>ortografisk skille</xsl:text>
                    </xsl:otherwise>
                </xsl:choose>
                <xsl:text>", WIDTH, 0)</xsl:text>
            </xsl:attribute>
        </xsl:if>
    </xsl:template>

</xsl:stylesheet>