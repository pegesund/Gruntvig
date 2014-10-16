<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet 
    xmlns:TEI="http://www.tei-c.org/ns/1.0" 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    version="1.0">

<!-- KSR: 2011.05.11 -->

    <xsl:template match="TEI:TEI">
        
        <div id="bookinventory">
            <xsl:apply-templates select="TEI:text"/>
        </div>
        
    </xsl:template>
    
    <xsl:template match="TEI:head[@type='bookInventory']">
        
        <div class="bookInventory">
            <xsl:apply-templates/>
        </div>
        
        <div class="kbSignatur">
            <xsl:text>Det Kongelige Bibliotek,</xsl:text>
        </div>
        <div class="kbSignatur">
            <xsl:text>katalogsignatur: </xsl:text>
            <xsl:value-of select="//TEI:title[@key='KBsKatalogsignatur']"/>
        </div>
    </xsl:template>
    
    <xsl:template match="TEI:p">
        <div class="frontPage">
            <xsl:apply-templates/>
        </div>
    </xsl:template>
    
    <xsl:template match="TEI:p[@rend='translator']">
        <div class="translator">
            <xsl:text>(oversat af </xsl:text>
            <xsl:apply-templates/>
            <xsl:text>)</xsl:text>
        </div>
    </xsl:template>
    
    <xsl:template match="TEI:hi">
        <span class="{@rend}">
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    
    <xsl:template match="TEI:table">
        <table>
            <xsl:apply-templates/>
        </table>
    </xsl:template>
    
    <xsl:template match="TEI:head">
        <div class="{@rend}">
            <xsl:apply-templates/>
        </div>     
    </xsl:template>
    
    <xsl:template match="TEI:row">
        <tr class="row" id="{@xml:id}">
            <xsl:apply-templates/>
        </tr>
    </xsl:template>
    
    <xsl:template match="TEI:cell[@type='nr']">
        <td class="nr">
            <xsl:apply-templates/>
        </td>
    </xsl:template>
    
    <xsl:template match="TEI:cell[@type='title']">
        <td class="nr">
            <xsl:apply-templates/>
        </td>
    </xsl:template>
    
    <xsl:template match="TEI:cell[@type='add']">
        <td class="nr">
            <xsl:if test="string-length()=0">
                <xsl:text> </xsl:text>
            </xsl:if>
            <xsl:apply-templates/>
        </td>
    </xsl:template>
    
    <xsl:template match="TEI:note[@type='titleNorm']">
        <td class="titleNorm">
            <xsl:apply-templates/>
        </td>
    </xsl:template>
    
    <xsl:template match="TEI:note[@type='author']">
        <span class="authorNorm">
            <xsl:apply-templates/>
            <xsl:call-template name="conjunction"/>
        </span>
    </xsl:template>
    
   <xsl:template match="TEI:note[@type='translator']">
        <td class="translatorNorm">
            <xsl:apply-templates/>
        </td>
    </xsl:template>
    
    <xsl:template match="TEI:note[@type='title']">
        <td class="titleNorm">
            <xsl:if test="string-length()=0">
                <xsl:text>[ikke identificeret]</xsl:text>
            </xsl:if>
            <xsl:apply-templates/>
        </td>
    </xsl:template>
    
    <xsl:template match="TEI:note[@type='year']">
        <td class="yearNorm">
            <xsl:if test="string-length()=0">
                <xsl:text> </xsl:text>
            </xsl:if>
            <xsl:apply-templates/>
        </td>
    </xsl:template>
    
    <xsl:template match="TEI:note[@type='place']">
        <td class="placeNorm">
            <xsl:if test="string-length()=0">
                <xsl:text>[uden sted]</xsl:text>
            </xsl:if>
            <xsl:apply-templates/>
        </td>
    </xsl:template>

    <xsl:template name="conjunction">
        <xsl:if test="following-sibling::TEI:note[@type='author']">;</xsl:if>
    </xsl:template>
    
    
</xsl:stylesheet>