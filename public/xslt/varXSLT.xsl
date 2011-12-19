<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet 
    xmlns:TEI="http://www.tei-c.org/ns/1.0" 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    version="1.0">

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
    
    <xsl:template match="TEI:app[@type]">
        <span class="{@type}">
            <xsl:if test="@type='ide'">
                <xsl:apply-templates/>
            </xsl:if>
            <xsl:if test="@type='int'">
                <xsl:apply-templates/>
            </xsl:if>
            <xsl:if test="@type='ort'">
                <xsl:apply-templates/>
            </xsl:if>
            <xsl:if test="@type='sub'">
                <xsl:apply-templates/>
            </xsl:if>
        </span>
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
    
</xsl:stylesheet>