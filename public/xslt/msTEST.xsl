<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet 
    xmlns:TEI="http://www.tei-c.org/ns/1.0" 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    version="1.0">

<!-- KSR: 2011.12.09 -->

    <xsl:template match="TEI:TEI">
        
        <html>
            <head>
                <link rel="stylesheet" href="msCSS.css" type="text/css"/>
                <!--<link rel="stylesheet" href="EditCSS.css" type="text/css"/>-->
                <title><xsl:apply-templates select="TEI:teiHeader/TEI:fileDesc/TEI:titleStmt/TEI:title"/></title>
            </head>
            <body>
                
                <div class="head">
                    <xsl:apply-templates select="TEI:teiHeader/TEI:fileDesc/TEI:titleStmt/TEI:title"/>
                </div>
                
                <xsl:apply-templates select="TEI:text"/>
                
                <br/>
                
                <hr class="footLine"/>
                
                <xsl:apply-templates select="//TEI:note[@type='footnote']" mode="foot"/>
                
            </body>
        </html>
        
    </xsl:template>
    
    <xsl:template match="TEI:lb">        
        <br>
            <xsl:apply-templates/>
        </br>        
    </xsl:template>
    
    <!-- titelblad start -->
    
    <xsl:template match="TEI:titlePage">
        <div class="titlePage">
            <xsl:apply-templates/>
        </div>
    </xsl:template>
    
    <xsl:template match="TEI:titlePart">
        <div class="{@type}">
            <xsl:apply-templates/>
        </div>
    </xsl:template>
    
    <xsl:template match="TEI:docTitle">
        <div class="docTitle">
            <xsl:apply-templates/>
        </div>
    </xsl:template>
    
    <xsl:template match="TEI:byline">
        <div class="byline">
            <xsl:apply-templates/>
        </div>
    </xsl:template>
    
    <xsl:template match="TEI:docImprint">        
        <div class="docImprint">
            <xsl:apply-templates/>
        </div>        
    </xsl:template>
    
    <xsl:template match="TEI:fw[@type='longLine']">
        <hr align="center" class="fwLongLine"/>        
    </xsl:template>
    
    <xsl:template match="TEI:fw[@type='shortLine']">
        <hr align="center" class="fwShortLine"/>
    </xsl:template>
    
    <xsl:template match="TEI:titlePart[@type='part']">
        <div class="titlePart">
            <xsl:apply-templates/>
        </div>
    </xsl:template>
    
    <!-- titelblad end -->
    
    <xsl:template match="TEI:div[@type='motto']">
        <div class="motto">
            <xsl:apply-templates/>
        </div>        
    </xsl:template>
    
    <xsl:template match="TEI:div[@type='preFace']">        
        <div class="preFace">
            <xsl:apply-templates/>
        </div>        
    </xsl:template>
    
    <xsl:template match="TEI:head">        
        <div class="head{@rend}">
            <xsl:apply-templates/>
        </div>
    </xsl:template>
    <!--
    <xsl:template match="TEI:lg">
        <div class="lg">
            <xsl:apply-templates/>
        </div>
    </xsl:template>-->
    
    <xsl:template match="TEI:l">
        <div class="l">
            <xsl:apply-templates/>
        </div>
    </xsl:template>
    
    <xsl:template match="TEI:app[@type='ms']">
        <span class="ms">
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    
    <xsl:template match="TEI:rdg">
        <div>
            <xsl:apply-templates/>
        </div>
    </xsl:template>
    
    <xsl:template match="TEI:lem[@type='add']">
        <span class="add">
            <xsl:text>[</xsl:text>
            <xsl:apply-templates/>
            <xsl:text>]</xsl:text>
        </span>
    </xsl:template>
    
    <xsl:template match="TEI:del[@type='firstDel']">
        <span class="firstDel">
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    
    <xsl:template match="TEI:del[@type='shading']">
        <span class="shading">
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    
    <xsl:template match="TEI:del[@type='immediate']">
        <span class="immediate">
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    
    <xsl:template match="TEI:del[@type='secondDel']">
        <span class="secondDel">
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    
    <xsl:template match="TEI:del[@type='doubt']">
        <span class="doubt">
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    
    <xsl:template match="TEI:note[@type='add']">        
        <span class="editor">
            <i>
                <xsl:value-of select="TEI:note[@type='add']"/>
            </i>                        
        </span>
    </xsl:template>
    
    <xsl:template match="TEI:note[@type='footnote']">
        <xsl:variable name="id">
            <xsl:number level="any" from="TEI:text"/>
        </xsl:variable>
            <a id="retur{$id}" href="#note{$id}">
                <span class="footMarker">
                    <xsl:value-of select="$id"/>
                </span>
            </a>                            
    </xsl:template>
    
    <xsl:template match="TEI:note[@type='footnote']" mode="foot">
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
    
    <xsl:template match="TEI:p[@rend and not(@rend='hangingIndent')]">        
        <div class="{@rend}">
            <xsl:apply-templates/>
        </div>
    </xsl:template>
    
    <xsl:template match="TEI:p[@rend='hangingIndent']">        
        <div class="hangingIndent">
            <xsl:apply-templates/>
        </div>
    </xsl:template>

    <xsl:template match="TEI:pb[@type='text' and not(@rend='supp')]">        |
        <!-- <xsl:value-of select="concat('xxx/', substring-before(@facs, '_'), '_', substring-before(substring-after(@facs, '_'), '_'), '/', @facs)"/> -->
        <a href="{@facs}">            
            <span class="pbA">
                <xsl:value-of select="@ed"/>:<xsl:value-of select="@n"/>
            </span>
            
        </a>        
    </xsl:template>
    
    <xsl:template match="TEI:pb[@type='text' and @rend='supp']">
        |
        <a href="{@facs}">
            <span class="pbA">
                [<xsl:value-of select="@ed"/>:<xsl:value-of select="@n"/>]
            </span>            
        </a>        
    </xsl:template>
    
    <xsl:template match="TEI:pb[@type='ms' and @rend='supp']">
        |
        <a href="{@facs}">
            <span class="pbMs">
                [<xsl:value-of select="@type"/>:<xsl:value-of select="@n"/>]
            </span> 
        </a>       
    </xsl:template>
    
    <xsl:template match="TEI:pb[@type='ms' and not(@rend='supp')]">
        |
        <a href="{@facs}">
            <span class="pbMs">
                <xsl:value-of select="@type"/>:<xsl:value-of select="@n"/>
            </span> 
        </a>        
    </xsl:template>
    
    <xsl:template name="delimiterComma">
        <xsl:text>, </xsl:text>
    </xsl:template>
    
    <xsl:template name="delimiterFullStop">
        <xsl:text>.</xsl:text>
    </xsl:template>
    
</xsl:stylesheet>