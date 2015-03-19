<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet 
    xmlns:TEI="http://www.tei-c.org/ns/1.0" 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    version="1.0"
    exclude-result-prefixes="#all"
    >

<!-- KSR: 2011.11.03
     KK:  2014-04-29 -->
    
    <xsl:template match="TEI:TEI">
        <div>
            <xsl:apply-templates select="//TEI:row">
                <xsl:sort select="translate(concat(TEI:cell[@rend='normForm'], TEI:cell[@rend='epithet'], TEI:cell[@rend='latin'], TEI:cell[@rend='pseudoEpithet']), 'æøåÆØÅ', '{|}{|}')"/>
            </xsl:apply-templates>
        </div>
    </xsl:template>
       
    <xsl:template match="TEI:row">
        <div class="row myth" id="{@xml:id}">
            <xsl:apply-templates select="TEI:cell[@rend!='orthography']"/>
            <xsl:if test="TEI:cell[@rend='orthography']">
                <div>
                    <i>
                        <xsl:text>Staves også: </xsl:text>
                    </i>
                    <xsl:for-each select="TEI:cell[@rend='orthography']">
                        <xsl:apply-templates select="."/>
                    </xsl:for-each>
                    <xsl:text>.</xsl:text>
                </div>
            </xsl:if>
            <xsl:if test="//TEI:row[@sameAs=current()/@xml:id and TEI:cell[@rend='saxo']]">
                <div>
                    <i>
                        <xsl:text>Latinsk form: </xsl:text>
                    </i>
                    <xsl:for-each select="//TEI:row[@sameAs=current()/@xml:id and TEI:cell[@rend='saxo']]">
                        <span>
                            <xsl:apply-templates select="./TEI:cell[@rend='saxo']/text()"/>
                            <xsl:call-template name="delimiter"/>
                        </span>
                    </xsl:for-each>
                </div> 
            </xsl:if>
            <xsl:if test="//TEI:row[@sameAs=current()/@xml:id and TEI:cell[@rend='epithet']]">
                <div>
                    <i>
                        <xsl:text>Kaldes også: </xsl:text>
                    </i>
                    <xsl:for-each select="//TEI:row[@sameAs=current()/@xml:id and TEI:cell[@rend='epithet']]">
                        <span>
                            <xsl:apply-templates select="./TEI:cell[@rend='epithet']/text()"/>
                            <xsl:call-template name="delimiter"/>
                        </span>
                    </xsl:for-each>
                </div>
            </xsl:if>
            <xsl:if test="//TEI:row[@sameAs=current()/@xml:id and TEI:cell[@rend='pseudoEpithet']]">
                <div>
                    <i><xsl:text>Benævnes også: </xsl:text>
                    </i>
                    <xsl:for-each select="//TEI:row[@sameAs=current()/@xml:id and TEI:cell[@rend='pseudoEpithet']]">
                        <span>
                            <xsl:apply-templates select="./TEI:cell[@rend='pseudoEpithet']/text()"/>
                            <xsl:call-template name="delimiter"/>
                        </span>
                    </xsl:for-each>
                </div>
            </xsl:if>
            <xsl:if test="//TEI:row[@sameAs=current()/@xml:id and TEI:cell[@rend='latin']]">
                <div>
                    <i><xsl:text>I romersk mytologi: </xsl:text>
                    </i>
                    <xsl:for-each select="//TEI:row[@sameAs=current()/@xml:id and TEI:cell[@rend='latin']]">
                        <span>
                            <xsl:apply-templates select="./TEI:cell[@rend='latin']/text()"/>
                            <xsl:call-template name="delimiter"/>
                        </span>
                    </xsl:for-each>
                </div> 
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
                        <xsl:text> eller </xsl:text>                        
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:if>
        </span>
    </xsl:template>
    
    <xsl:template name="delimiter">
        <xsl:choose>
            <xsl:when test="position()=last()"><xsl:text>.</xsl:text></xsl:when>
            <xsl:when test="position()=last()-1"><xsl:text> eller </xsl:text></xsl:when>
            <xsl:otherwise><xsl:text>, </xsl:text></xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    
    <xsl:template match="TEI:cell[@rend='normForm' or @rend='patronym']">
        <div class="{@rend}">
            <xsl:variable name="theId" select="../@xml:id"/>
            <a href="myter#{$theId}">
                <xsl:apply-templates/>
            </a>    
        </div>
    </xsl:template>
    
    
    <xsl:template match="TEI:cell[@rend='popUp' or @rend='encyc']">
        <div class="{@rend}">
            <xsl:apply-templates/>
        </div>
    </xsl:template>
    
    <xsl:template match="TEI:cell[@rend='epithet' or @rend='latin' or @rend='pseudoEpithet' or @rend='saxo']">
        <div class="{@rend} popUp">
            <xsl:variable name="sameAs" select="../@sameAs"/>
            <xsl:apply-templates/>
            <span class="sameAs">
                    <xsl:if test="@rend='latin' or @rend='saxo'">
                        <xsl:text>, latinsk navn for </xsl:text>
                    </xsl:if>   
                    <xsl:if test="@rend='epithet' or @rend='pseudoEpithet'">
                        <xsl:text>, andet navn for </xsl:text>
                    </xsl:if>   
                    <a href="myter#{$sameAs}">
                        <xsl:apply-templates select="//TEI:row[@xml:id=$sameAs]/TEI:cell[@rend='normForm']/text()"/>
                    </a>
            </span>
        </div>
    </xsl:template>
    
    <xsl:template match="TEI:hi">
        <span class="{@rend}">
            <xsl:apply-templates/>
        </span>
    </xsl:template>    
    
    <xsl:template name="delimiterKomma">
        <xsl:if test="following-sibling::TEI:cell[@rend='orthography']">
            <xsl:text>, </xsl:text>
        </xsl:if>
    </xsl:template>

</xsl:stylesheet>