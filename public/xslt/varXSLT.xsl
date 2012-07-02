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
                <p class="witness">Teksten er etableret af:</p>
                <i>
                <xsl:apply-templates select="TEI:teiHeader/TEI:fileDesc/TEI:titleStmt/TEI:editor[@role='editionPhilologist']"/>
                </i>
                <p class="witness">Tekstkilde:</p>
                <i>
                    <p class="witness">
                        <xsl:apply-templates select="TEI:teiHeader/TEI:fileDesc/TEI:sourceDesc/TEI:listWit[@xml:id='variantList']/TEI:witness"/>
                    </p>                
                </i>
                <!-- vil andre udgaver afgive varianter?
                <p class="witness">Anvendte udgaver:</p>
                <i>
                <xsl:apply-templates select="TEI:teiHeader/TEI:fileDesc/TEI:sourceDesc/TEI:listWit[@xml:id='pageNumber']/TEI:witness"/>
                </i>
                -->
                <hr/>
                <xsl:apply-templates select="TEI:text"/>
                <br/>    
                <hr class="footLine"/>
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
        <div class="anchor">
            <xsl:text>anchor: </xsl:text>
            <xsl:value-of select="@id"/>
            <xsl:apply-templates/>
        </div>
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
                    <xsl:when test="sub">
                        <xsl:text>ord</xsl:text>
                    </xsl:when>
                    <xsl:when test="sub int">
                        <xsl:text>ord og tegn</xsl:text>
                    </xsl:when>
                    <xsl:when test="substring(@type,1,3)='int'">
                        <xsl:text>tegn</xsl:text>
                    </xsl:when>
                    <xsl:when test="substring(@type,1,3)='ide'">
                        <xsl:text>invarians</xsl:text>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:text>stavning</xsl:text>
                    </xsl:otherwise>
                </xsl:choose>
                <xsl:text>", WIDTH, 0)</xsl:text>
            </xsl:attribute>
        </xsl:if>
    </xsl:template>

    
</xsl:stylesheet>