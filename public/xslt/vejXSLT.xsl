<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet 
    xmlns:TEI="http://www.tei-c.org/ns/1.0" 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    version="1.0">
    
<!-- Kim Steeen Ravn
     2011.07.01
     2012.07.31: forfatter skal ikke behandles
     2012.10.25: graphic og ref type image
-->
    
    <xsl:template match="TEI:TEI">        
      <div class="mapVej">
          <xsl:apply-templates select="TEI:text"/>
      </div>        
    </xsl:template>
    
    <xsl:template match="TEI:head">        
        <div class="head">
            <xsl:apply-templates/>
        </div>
    </xsl:template>
    
    <xsl:template match="TEI:div">
        <div class="div">
            <xsl:apply-templates/>
        </div>
    </xsl:template>
    
    <xsl:template match="TEI:p">        
        <div class="p">
            <xsl:apply-templates/>
        </div>
    </xsl:template>
    
    <xsl:template match="TEI:hi">        
        <span class="{@rend}">
            <xsl:apply-templates/>
            <xsl:text>HAT</xsl:text>
        </span>
    </xsl:template>
    
    <xsl:template match="TEI:lb">        
        <br>
            <xsl:apply-templates/>
        </br>        
    </xsl:template>
    
    <xsl:template match="TEI:lg|TEI:l">
        <div class="{name()}">
            <!--xsl:attribute name="class"><xsl:value-of select="name()"/></xsl:attribute-->
            <xsl:apply-templates/>
        </div>
    </xsl:template>
    
    <xsl:template match="TEI:list">        
        <ul class="{@type}">
            <xsl:apply-templates/>
        </ul>
    </xsl:template>
    
    <xsl:template match="TEI:item">        
        <li class="item">
            <xsl:apply-templates/>
        </li>
    </xsl:template>
    
    <xsl:template match="TEI:table"> 
        <table>
            <xsl:apply-templates/>
        </table>
    </xsl:template>
    
    <xsl:template match="TEI:row[@rend='head']">        
        <tr class="rowHead">
            <xsl:apply-templates/>
        </tr>
    </xsl:template>
    
    <xsl:template match="TEI:row[not(@rend='head')]"> 
        <tr class="row">
            <xsl:apply-templates/>
        </tr>
    </xsl:template>
    
    <xsl:template match="TEI:cell">        
        <td>
            <xsl:apply-templates/>
        </td>
    </xsl:template>
    
    <xsl:template match="TEI:ref">
        <span class="web">
            <a href="/viskort/{@target}">
                <xsl:apply-templates/>
            </a>
        </span>
    </xsl:template>
    
    <!-- landkort START -->
    
    <xsl:template match="TEI:graphic">
        <img src="/img/{@select}" alt="" width="100%"/>
    </xsl:template>
    
    <xsl:template match="TEI:ref[@type='image']">
        <div>
            <a href="/viskort/{@next}">
                <img src="/img/{@target}" alt="" height="100"/>
            </a>
        </div>
    </xsl:template>
    
    <!-- landkort END -->
    
</xsl:stylesheet>