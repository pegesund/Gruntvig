<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet 
    xmlns:TEI="http://www.tei-c.org/ns/1.0" 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    version="1.0"
    exclude-result-prefixes="#all"
    >

<!-- KSR: 2011.11.03 -->



    <xsl:template match="TEI:TEI">
        
        <div>
                <xsl:apply-templates select="//TEI:row">
                    <xsl:sort select="translate(concat(TEI:cell[@rend='normForm'], TEI:cell[@rend='epithet'], TEI:cell[@rend='latin'], TEI:cell[@rend='pseudoEpithet']), 'æøåÆØÅ', '{|}{|}')"/>
                </xsl:apply-templates>
        </div>
        
    </xsl:template>
    
    <!--
        93A Nordens Mytologi
        436A Ansgar
    -->
    
    <xsl:template match="TEI:row[@n='93A' or @n='436A']"/>
    
       
    <xsl:template match="TEI:row">
        <div class="row myth" id="{@xml:id}">
            <xsl:apply-templates/>
            <xsl:choose>
                <xsl:when test="//TEI:row[@sameAs=current()/@xml:id and TEI:cell[@rend='epithet']]">
                    <i><xsl:text>Kaldes også: </xsl:text></i>
                    <xsl:for-each select="//TEI:row[@sameAs=current()/@xml:id]">
                        <span>
                            <xsl:apply-templates select="./TEI:cell[@rend='epithet']/text()"/>
                            <xsl:call-template name="delimiter"/>
                        </span>
                    </xsl:for-each>                    
                </xsl:when>
                <xsl:when test="//TEI:row[@sameAs=current()/@xml:id and TEI:cell[@rend='pseudoEpithet']]">
                    <i><xsl:text>Kaldes også: </xsl:text></i>
                    <xsl:for-each select="//TEI:row[@sameAs=current()/@xml:id]">
                        <span>
                            <xsl:apply-templates select="./TEI:cell[@rend='pseudoEpithet']/text()"/>
                            <xsl:call-template name="delimiter"/>
                        </span>
                    </xsl:for-each>                    
                </xsl:when>
                <xsl:when test="//TEI:row[@sameAs=current()/@xml:id and TEI:cell[@rend='latin']]">
                    <i><xsl:text>Kaldes også: </xsl:text></i>
                    <xsl:for-each select="//TEI:row[@sameAs=current()/@xml:id]">
                        <span>
                            <xsl:apply-templates select="./TEI:cell[@rend='latin']/text()"/>
                            <xsl:call-template name="delimiter"/>
                        </span>
                    </xsl:for-each> 
                </xsl:when>
            </xsl:choose>
        </div>
    </xsl:template>
    
    <xsl:template match="TEI:cell">
        <div class="{@rend}">
            <xsl:if test="@rend='normForm'">
                <xsl:apply-templates/>
            </xsl:if>
            <xsl:if test="@rend='popUp'">
                <xsl:apply-templates/>
            </xsl:if>
            <xsl:if test="@rend='encyc'">
                <xsl:apply-templates/>
            </xsl:if>
            <xsl:if test="@rend='epithet' or @rend='latin' or @rend='pseudoEpithet'">
                <xsl:variable name="sameAs" select="../@sameAs"/>
                <xsl:apply-templates/>
                <span class="sameAs">
                    <a href="#{$sameAs}">
                        <xsl:text> > </xsl:text>                    
                        <xsl:apply-templates select="//TEI:row[@xml:id=$sameAs]/TEI:cell[@rend='normForm']/text()"/>
                    </a>
                </span>
            </xsl:if>
        </div>
    </xsl:template>
    
    <xsl:template match="TEI:cell[@rend='orthography']">
        <span class="orthography">
            <xsl:apply-templates/>
            <xsl:if test="following-sibling::TEI:cell[@rend='orthography']">
                <xsl:choose>
                    <xsl:when test="following-sibling::TEI:cell[@rend='orthography'][position()!=last()]">
                        <xsl:call-template name="delimiterKomma"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <i>
                            <xsl:text> eller </xsl:text>
                        </i>                
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:if>
        </span>
    </xsl:template>
    
    <xsl:template match="TEI:hi">
        <span class="{@rend}">
            <xsl:apply-templates/>
        </span>
    </xsl:template>    
    
    <xsl:template name="delimiter">
        <xsl:choose>
            <xsl:when test="position()=1">.</xsl:when>
            <xsl:when test="position()=1 and position()=last">.</xsl:when>
            <xsl:when test="position()=last()">.</xsl:when>
            <xsl:when test="position()=last()-1"> eller </xsl:when>
            <xsl:otherwise>, </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    <xsl:template name="delimiterKomma">
        <xsl:if test="following-sibling::TEI:cell[@rend='orthography']">
            <xsl:text>,</xsl:text>
        </xsl:if>
    </xsl:template>
    
    <xsl:template name="fullStop">
        <xsl:if test="following-sibling::TEI:cell[@rend='orthography'][position()=last()]">
            <xsl:text>.</xsl:text>
        </xsl:if>
    </xsl:template>

</xsl:stylesheet>