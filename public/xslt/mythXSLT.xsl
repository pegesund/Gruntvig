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
    
    <xsl:template match="TEI:row"/>
       
    <xsl:template match="TEI:row[@n='28' or @n='29' or @n='34' or @n='52' or @n='61' or @n='63' or @n='65' or @n='67' or @n='68' or @n='73' or @n='76' or @n='80' or @n='81' or @n='82' or @n='83' or @n='84' or @n='85' or @n='86' or @n='87' or @n='88' or @n='89' or @n='93A' or @n='94' or @n='96' or @n='97' or @n='99A' or @n='105' or @n='106' or @n='107' or @n='108' or @n='109' or @n='111' or @n='113' or @n='115' or @n='116' or @n='117' or @n='118' or @n='121' or @n='122' or @n='123' or @n='125' or @n='169A' or @n='130' or @n='131' or @n='132' or @n='133' or @n='134' or @n='136' or @n='137' or @n='139A' or @n='140A' or @n='141' or @n='143' or @n='144' or @n='147' or @n='148A' or @n='149' or @n='157' or @n='193A' or @n='227A' or @n='255' or @n='281' or @n='308' or @n='329' or @n='330' or @n='331' or @n='332' or @n='342' or @n='397' or @n='413A' or @n='415' or @n='416' or @n='417' or @n='421A' or @n='433A' or @n='436A' or @n='487A' or @n='563' or @n='573' or @n='580' or @n='593' or @n='603' or @n='617' or @n='624a' or @n='680' or @n='741' or @n='891' or @n='898' or @n='896A' or @n='1155' or @n='1403']">
        <div class="row myth" id="{@xml:id}">
            <xsl:apply-templates select="TEI:cell[@rend!='orthography']"/>
            <xsl:if test="TEI:cell[@rend='orthography']">
                <div>
                    <i>Staves også: </i>
                    <xsl:for-each select="TEI:cell[@rend='orthography']">
                        <xsl:apply-templates select="."/>
                        <!--x<xsl:call-template name="delimiter"/>y-->
                    </xsl:for-each>
                </div>
            </xsl:if>
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
                    <i><xsl:text>I romersk mytologi: </xsl:text></i>
                    <xsl:for-each select="//TEI:row[@sameAs=current()/@xml:id]">
                        <span>
                            <xsl:apply-templates select="./TEI:cell[@rend='latin']/text()"/>
                            <xsl:call-template name="fullStop"/>
                        </span>
                    </xsl:for-each> 
                </xsl:when>
                <xsl:when test="//TEI:row[@sameAs=current()/@xml:id and TEI:cell[@rend='saxo']]">
                    <i><xsl:text>Latinsk form: </xsl:text></i>
                    <xsl:for-each select="//TEI:row[@sameAs=current()/@xml:id]">
                        <span>
                            <xsl:apply-templates select="./TEI:cell[@rend='saxo']/text()"/>
                            <xsl:call-template name="fullStop"/>
                        </span>
                    </xsl:for-each> 
                </xsl:when>
            </xsl:choose>
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
    
    <xsl:template name="delimiter">
        <xsl:choose>
            <xsl:when test="position()=1"> </xsl:when>
            <xsl:when test="position()=1 and position()=last">. </xsl:when>
            <xsl:when test="position()=last()">. </xsl:when>
            <xsl:when test="position()=last()-1"> eller </xsl:when>
            <xsl:otherwise>, </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    
    <xsl:template match="TEI:cell[@rend='normForm']">
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
            <xsl:text>,</xsl:text>
        </xsl:if>
    </xsl:template>
    
    <xsl:template name="fullStop">
        <xsl:if test="following-sibling::TEI:cell[@rend='orthography'][position()=last()]">
            <xsl:text>.</xsl:text>
        </xsl:if>
        <xsl:if test="TEI:cell[@rend='latin' or @rend='saxo'][position()=last()]">
            <xsl:text>.</xsl:text>
        </xsl:if>
    </xsl:template>

</xsl:stylesheet>
