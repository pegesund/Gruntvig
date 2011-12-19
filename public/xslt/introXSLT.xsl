<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet 
    xmlns:TEI="http://www.tei-c.org/ns/1.0" 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    version="1.0">

<!-- KSR: 2011-063.24 -->
    <xsl:include href="popups.xsl"/>
    <xsl:template match="TEI:TEI">
        
        <div class="mainIntro">
                <p class="author">Forfatter:</p>
                <i>
                <xsl:apply-templates select="TEI:teiHeader/TEI:fileDesc/TEI:titleStmt/TEI:author"/>
                </i>
                <p class="author">Redaktør:</p>
                <i>
                <xsl:apply-templates select="TEI:teiHeader/TEI:fileDesc/TEI:titleStmt/TEI:editor[@role='editor']"/>
                </i>
                <hr/>
                <div class="head">
                    <xsl:if test="TEI:teiHeader/TEI:fileDesc/TEI:titleStmt/TEI:title[@rend='main']">
                        Indledning til
                        <i>
                            <xsl:apply-templates select="TEI:teiHeader/TEI:fileDesc/TEI:titleStmt/TEI:title"/>
                        </i>
                    </xsl:if>
                    <xsl:if test="TEI:teiHeader/TEI:fileDesc/TEI:titleStmt/TEI:title[@rend='part']">
                        Indledning til &#x201C;<xsl:apply-templates select="TEI:teiHeader/TEI:fileDesc/TEI:titleStmt/TEI:title"/>&#x201D;
                    </xsl:if>                    
                </div>
                <xsl:apply-templates mode="toc" select="TEI:text/TEI:body/TEI:div"/>                
                <xsl:apply-templates select="TEI:text"/>
        </div>
        
    </xsl:template>
    
    <xsl:template match="TEI:div" mode="toc">
        <div class="toc">
            <a class="toc">
                <xsl:attribute name="href">
                    <xsl:text>#A</xsl:text>
                    <xsl:number level="multiple" count="TEI:div"/>
                </xsl:attribute>
                <xsl:number level="multiple" count="TEI:div"/>
                <xsl:text> </xsl:text>
                <xsl:value-of select="TEI:head"/>
            </a>
            <xsl:for-each select="TEI:div">
                <xsl:apply-templates mode="toc" select="."/>
            </xsl:for-each>
        </div>
    </xsl:template>
    
    <xsl:template match="TEI:author">        
        <div class="author">
            <xsl:apply-templates/>
        </div>
    </xsl:template>
    
    <xsl:template match="TEI:teiHeader/TEI:fileDesc/TEI:titleStmt/TEI:editor[@role='editor']">        
        <div class="editor">
            <xsl:apply-templates/>
        </div>
    </xsl:template>
    
    <xsl:template match="TEI:head">
        <a>
            <xsl:attribute name="id">
                <xsl:text>A</xsl:text>
                <xsl:number level="multiple" count="TEI:div"/>
            </xsl:attribute>
        </a>
        <div class="head{@rend}">
            <xsl:number level="multiple" count="TEI:div"/>
            <xsl:text> </xsl:text>
            <xsl:apply-templates/>
        </div>
    </xsl:template>
    
    <xsl:template match="TEI:hi">        
        <span class="{@rend}">
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    
    <xsl:template match="TEI:div">        
        <div class="div">
            <xsl:apply-templates/>
        </div>
    </xsl:template>
    
    <xsl:template match="TEI:fw[@type='longLine']">
        <hr class="fwLongLine"/>        
    </xsl:template>
    
    <xsl:template match="TEI:fw[@type='shortLine']">
        <hr class="fwShortLine"/>
    </xsl:template>
    
    <xsl:template match="TEI:lb">        
        <br>
            <xsl:apply-templates/>
        </br>        
    </xsl:template>

<!--
    henter nummer på stofe; konflikt med næste template?
    <xsl:template match="TEI:lg[@n]">        
        <div class="lgNumber">
                <xsl:value-of select="@n"/>
            <xsl:apply-templates/>
            <br/>
        </div>        
    </xsl:template>
-->

    <xsl:template match="TEI:lg|TEI:l">
        <div class="{name()}">
            <!--xsl:attribute name="class"><xsl:value-of select="name()"/></xsl:attribute-->
            <xsl:apply-templates/>
        </div>
    </xsl:template>
    
    <xsl:template match="TEI:div[@type='litList']">
        <div class="litList">
            <xsl:apply-templates/>
        </div>
    </xsl:template>
    
    <xsl:template match="TEI:list[@type='simple']">
        <ul class="ul">
            <xsl:apply-templates/>
        </ul>
        
    </xsl:template>
    
    <xsl:template match="TEI:item">
        <li class="liSimple">
            <xsl:apply-templates/>
        </li>
    </xsl:template>
    
    <xsl:template match="TEI:note[@type='sic']">
        <span class="sic">
            <xsl:apply-templates/>
            <xsl:text>
                [sic]
            </xsl:text>
        </span>
    </xsl:template>
    
    <xsl:template match="TEI:note[@type='supp']">
        <span class="supp">
            <xsl:text>[</xsl:text>
            <xsl:apply-templates/>
            <xsl:text>]</xsl:text>
        </span>
    </xsl:template>
    
    <xsl:template match="TEI:p[@rend]">        
        <div class="{@rend}">
            <xsl:apply-templates/>            
        </div>
    </xsl:template>
    
    <xsl:template match="TEI:table">        
        <div class="table">
            <xsl:apply-templates/>
        </div>
    </xsl:template>
    
    <xsl:template match="TEI:row">        
        <div class="row">
            <xsl:apply-templates/>
        </div>
    </xsl:template>
    
    <xsl:template match="TEI:cell">        
        <span class="cell">
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    
</xsl:stylesheet>