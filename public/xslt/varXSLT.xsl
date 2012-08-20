<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet 
    xmlns:TEI="http://www.tei-c.org/ns/1.0" 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    version="1.0"
    exclude-result-prefixes="#all"
    >

<!-- KSR: 2011.09.26 -->
    <xsl:include href="popups.xsl"/>
    <xsl:template match="TEI:TEI">
        
        <div class="variantMain">
                
                <div class="head">
                    <xsl:if test="TEI:teiHeader/TEI:fileDesc/TEI:titleStmt/TEI:title[@rend='main']">
                        <i><xsl:apply-templates select="TEI:teiHeader/TEI:fileDesc/TEI:titleStmt/TEI:title[@rend='main']"/></i>                        
                    </xsl:if>                    
                    <xsl:if test="TEI:teiHeader/TEI:fileDesc/TEI:titleStmt/TEI:title[@rend='part']"> 
                        &#x201C;<xsl:apply-templates select="TEI:teiHeader/TEI:fileDesc/TEI:titleStmt/TEI:title[@rend='part']"/>&#x201D;
                    </xsl:if>
                    <xsl:choose>
                        <xsl:when test="//TEI:note[@xml:id='thisFile' and @type='var']">
                            <xsl:apply-templates select="TEI:text"/>
                        </xsl:when>
                        <xsl:when test="//TEI:note[@xml:id='thisFile' and @type='minusVar']">
                            <div>
                                <xsl:text>GV udgiver ikke varianter til dette værk. </xsl:text>
                            </div>
                        </xsl:when>
                        <xsl:when test="//TEI:note[@xml:id='thisFile' and @type='unknownVar']">
                            <div>
                                <xsl:text>Der kendes ikke varianter til dette værk.</xsl:text>
                            </div>
                        </xsl:when>
                        <xsl:when test="//TEI:note[@xml:id='thisFile' and @type='noVar']">
                            <div>
                                <xsl:text>Varianter er endnu ikke etableret.</xsl:text>
                            </div>
                        </xsl:when>
                    </xsl:choose>
                </div>
                <br/>    
                
                <xsl:apply-templates select="//TEI:note[@type='editor']" mode="editor"/>
        </div>
        
    </xsl:template>
    
    <xsl:template match="TEI:editor[@role='editionPhilologist']">
        <div class="editor">
            <xsl:apply-templates/>
        </div>
    </xsl:template>
    
    <xsl:template match="TEI:head">        
        <div class="head{@rend}">
            <xsl:apply-templates/>
        </div>
    </xsl:template>
    
    <xsl:template match="TEI:lg">
        <div class="lg">
            <xsl:apply-templates/>
        </div>
    </xsl:template>
    
    <xsl:template match="TEI:l">
        <div class="{@rend}">
            <xsl:apply-templates/>
        </div>
    </xsl:template>
    
    <xsl:template match="TEI:anchor">
        <span class="anchor">
            <xsl:choose>
                <xsl:when test="contains(@id, 'a')">
                    &#x25B8;
                </xsl:when>
                <xsl:otherwise>
                    &#x25C2;
                </xsl:otherwise>
            </xsl:choose>
        </span>
    </xsl:template>
    
    <xsl:template match="TEI:p">
        <div class="{@rend}">
            <xsl:apply-templates/>
        </div>
    </xsl:template>
    
    <xsl:template match="TEI:note[@type='editor']">
        <xsl:variable name="id">
            <xsl:number level="any" from="TEI:text"/>
        </xsl:variable>
        <a id="retur{$id}" href="#note{$id}">
            <span class="footMarker">
                <xsl:value-of select="$id"/>
            </span>
        </a>                            
    </xsl:template>
    
    <xsl:template match="TEI:note[@type='editor']" mode="editor">
        <xsl:variable name="id">
            <xsl:number level="any" from="TEI:text"/>
        </xsl:variable>
        <a id="note{$id}" href="#retur{$id}">
            <span class="footMarker">
                <xsl:value-of select="$id"/>
            </span>
        </a>               
        <div class="footnote">
            <xsl:apply-templates/>
        </div>
    </xsl:template>
    
    <xsl:template match="TEI:hi">
        <span class="{@rend}">
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    
    
    <!-- added by pe 16/1 -->
    
    <xsl:template match="TEI:app">
        <span>
            <xsl:attribute name="class">
                <xsl:choose>
                    <xsl:when test="@type='sub'">
                        <xsl:text>substantial </xsl:text>
                    </xsl:when>
                    <xsl:when test="@type='sub int'">
                        <xsl:text>substantial </xsl:text>
                    </xsl:when>
                    <xsl:when test="@type='sub ort'">
                        <xsl:text>substantial </xsl:text>
                    </xsl:when>
                    <xsl:when test="@type='sub int ort'">
                        <xsl:text>substantial </xsl:text>
                    </xsl:when>
                    <xsl:when test="@type='int'">
                        <xsl:text>interpunction </xsl:text>
                    </xsl:when>
                    <xsl:when test="@type='int ort'">
                        <xsl:text>interpunction </xsl:text>
                    </xsl:when>
                    <xsl:when test="@type='ide'">
                        <xsl:text>identical </xsl:text>
                    </xsl:when>
                    <xsl:when test="@type='ort'">
                        <xsl:text>orthographic </xsl:text>
                    </xsl:when>
                </xsl:choose>
                <xsl:text>variantScrollTarget </xsl:text>
                <xsl:value-of select="@id" />
            </xsl:attribute>
            <xsl:call-template name="variantMouseOver" />
            <xsl:apply-templates/>
        </span>
    </xsl:template>

    <xsl:template match="TEI:rdg">
        <xsl:choose>
            <xsl:when test="@type='empty'">
                <span class="seg">
                    <img src="images/squared_times.png"/>
                </span>
            </xsl:when>
            <xsl:otherwise>
                <xsl:apply-templates/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <xsl:template name="variantMouseOver">
        <xsl:if test="@type">
            <xsl:attribute name="onmouseover">
                <xsl:text>Tip("</xsl:text>
                <xsl:choose>
                    <xsl:when test="@type='sub'">
                        <xsl:text>ord</xsl:text>
                    </xsl:when>
                    <xsl:when test="@type='sub int'">
                        <xsl:text>ord og tegn</xsl:text>
                    </xsl:when>
                    <xsl:when test="@type='sub ort'">
                        <xsl:text>ord og stavning</xsl:text>
                    </xsl:when>
                    <xsl:when test="@type='sub int ort'">
                        <xsl:text>ord, tegn og stavning</xsl:text>
                    </xsl:when>
                    <xsl:when test="@type='int'">
                        <xsl:text>tegn</xsl:text>
                    </xsl:when>
                    <xsl:when test="@type='int ort'">
                        <xsl:text>tegn og stavning</xsl:text>
                    </xsl:when>
                    <xsl:when test="@type='ide'">
                        <xsl:text>invarians</xsl:text>
                    </xsl:when>
                    <xsl:when test="@type='ort'">
                        <xsl:text>stavning</xsl:text>
                    </xsl:when>
                </xsl:choose>
                <xsl:text>", WIDTH, 0)</xsl:text>
            </xsl:attribute>
        </xsl:if>
    </xsl:template>

    
</xsl:stylesheet>
