<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet
  xmlns="http://www.w3.org/1999/xhtml"
  version="2.0"
  xmlns:a="http://relaxng.org/ns/compatibility/annotations/1.0"
  xmlns:fo="http://www.w3.org/1999/XSL/Format"  
  xmlns:local="http://www.pantor.com/ns/local"
  xmlns:rng="http://relaxng.org/ns/structure/1.0"
  xmlns:tei="http://www.tei-c.org/ns/1.0"
  xmlns:teix="http://www.tei-c.org/ns/Examples"
  xmlns:xd="http://www.pnp-software.com/XSLTdoc"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  exclude-result-prefixes="#all"
  >

<!-- KSR: 2011.12.09 -->
    <xsl:include href="popups.xsl"/>
    
    <xsl:template match="tei:teiHeader">
        <div class="title">
             <xsl:if test="tei:teiHeader/tei:fileDesc/tei:titleStmt/tei:title[@type='main']">
                        <i><xsl:apply-templates select="tei:teiHeader/tei:fileDesc/tei:titleStmt/tei:title[@type='main']"/></i>
                    </xsl:if>
                    <xsl:if test="tei:teiHeader/tei:fileDesc/tei:titleStmt/tei:title[@type='part']">
                        &#x201C;<xsl:apply-templates select="tei:teiHeader/tei:fileDesc/tei:titleStmt/tei:title[@type='part']"/>&#x201D;
                    </xsl:if>
        </div>
        <div class="source">
            <xsl:text>Tekstkilde:</xsl:text>
            <br/>
            <xsl:for-each select="//tei:bibl/tei:author">
                <xsl:apply-templates select="."/>
            </xsl:for-each>
            <xsl:text> </xsl:text>
            <xsl:for-each select="//tei:title[@type='katalogsignatur']">
                <xsl:apply-templates select="."/>
            </xsl:for-each>
        </div>
    </xsl:template>
 
    
    <xsl:template match="tei:tei">
            
            <div class="manusMain">
                
                <div class="head">
                    <xsl:apply-templates select="tei:teiHeader/tei:fileDesc/tei:titleStmt/tei:title"/>
                </div>                
                
                <xsl:apply-templates select="tei:text"/>
                
                <xsl:if test="//tei:note[@type='footnote']">
                    
                    <br/>
                    
                    <hr class="footLine"/>
                    
                    <xsl:apply-templates select="//tei:note[@type='footnote']" mode="foot"/>
                
                </xsl:if>
            </div>
        
    </xsl:template>
    
    <xsl:template match="tei:lb">        
        <br>
            <xsl:apply-templates/>
        </br>        
    </xsl:template>
    
    <!-- titelblad START -->
    
    <xsl:template match="tei:titlePage">
        <div class="titlePage">
            <xsl:apply-templates/>
        </div>
    </xsl:template>
    
    <xsl:template match="tei:titlePart">
        <div class="{@type}">
            <xsl:apply-templates/>
        </div>
    </xsl:template>
    
    <xsl:template match="tei:docTitle">
        <div class="docTitle">
            <xsl:apply-templates/>
        </div>
    </xsl:template>
    
    <xsl:template match="tei:byline">
        <div class="byline">
            <xsl:apply-templates/>
        </div>
    </xsl:template>
    
    <xsl:template match="tei:docImprint">        
        <div class="docImprint">
            <xsl:apply-templates/>
        </div>        
    </xsl:template>
    
    <xsl:template match="tei:fw[@type='longLine']">
        <hr align="center" class="fwLongLine"/>        
    </xsl:template>
    
    <xsl:template match="tei:fw[@type='shortLine']">
        <hr align="center" class="fwShortLine"/>
    </xsl:template>
    
    <xsl:template match="tei:titlePart[@type='part']">
        <div class="titlePart">
            <xsl:apply-templates/>
        </div>
    </xsl:template>
    
    <!-- titelblad END -->
    
    <xsl:template match="tei:div[@type='motto']">
        <div class="motto">
            <xsl:apply-templates/>
        </div>        
    </xsl:template>
    
    <xsl:template match="tei:div[@type='preFace']">        
        <div class="preFace">
            <xsl:apply-templates/>
        </div>        
    </xsl:template>
    
    <xsl:template match="tei:head">        
        <div class="head{@rend}">
            <xsl:apply-templates/>
        </div>
    </xsl:template>
    
    <xsl:template match="tei:lg">        
        <div class="lg">
            <xsl:apply-templates/>
        </div>        
    </xsl:template>
    
    <xsl:template match="tei:l">        
        <div class="l">
            <xsl:apply-templates/>
        </div>        
    </xsl:template>
    
    <xsl:template match="tei:app[@type='ms']">
        <span class="ms">
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    
    <xsl:template match="tei:lem[@type='add' and not(tei:l)]">
        <span class="add">
            <xsl:text>[</xsl:text>
            <xsl:apply-templates/>
            <xsl:text>]</xsl:text>
        </span>
    </xsl:template>
    
    <xsl:template match="//tei:lem[@type='add']/tei:l[position()=1]">
        <div class="l">
            <xsl:text>[</xsl:text>
            <xsl:apply-templates/>
        </div>
    </xsl:template>
    
    <xsl:template match="//tei:lem[@type='add']/tei:l[position()=last()]">
        <div class="l">
            <xsl:apply-templates/>
            <xsl:text>]</xsl:text>
        </div>
    </xsl:template>
    
    <xsl:template match="tei:del[@type='firstDel']">
        <span class="firstDel">
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    
    <xsl:template match="tei:del[@type='shading']">
        <span class="shading">
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    
    <xsl:template match="tei:del[@type='immediate']">
        <span class="immediate">
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    
    <xsl:template match="tei:del[@type='secondDel']">
        <span class="secondDel">
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    
    <xsl:template match="tei:del[@type='doubt']">
        <span class="doubt">
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    
    <!-- app til mouse-over
    
    <xsl:template match="tei:app">
        <a class="app" href="#">
            <span class="lem">
                <xsl:apply-templates select="tei:lem"/>
            </span>
            <span class="appInvisible">
                <xsl:text>] </xsl:text>
                <xsl:apply-templates select="tei:rdg"/>
            </span>
        </a>
    </xsl:template>
    
    <xsl:template match="tei:rdg">
        <xsl:apply-templates/>
        <span class="wit">                
            <xsl:text> </xsl:text>
            <i>
                <xsl:choose>
                    <xsl:when test="following-sibling::tei:rdg[current()/@type or not(@type)]">
                        <xsl:text>, </xsl:text>
                    </xsl:when>
                    <xsl:when test="following-sibling::tei:rdg[not(current()/@type) and @type]">
                        <xsl:text>; </xsl:text>
                    </xsl:when>
                </xsl:choose>
            </i>
        </span>
    </xsl:template>
    
    -->
    
    <xsl:template match="tei:note[@type='add']">        
        <span class="editor">
            <i>
                <xsl:value-of select="tei:note[@type='add']"/>
            </i>                        
        </span>
    </xsl:template>
    
    <xsl:template match="tei:note[@type='footnote']">
        <xsl:variable name="id">
            <xsl:number level="any" from="tei:text"/>
        </xsl:variable>
            <a id="retur{$id}" href="#note{$id}">
                <span class="footMarker">
                    <xsl:value-of select="$id"/>
                </span>
            </a>                            
    </xsl:template>
    
    <xsl:template match="tei:note[@type='footnote']" mode="foot">
        <xsl:variable name="id">
            <xsl:number level="any" from="tei:text"/>
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
    
    <xsl:template match="tei:hi">        
        <span class="{@rend}">
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    
    <!-- til brugs for txtEditCSS-css start -->
    
    <xsl:template match="tei:persName">
        <span class="persName">
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    
    <xsl:template match="tei:placeName">
        <span class="placeName">
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    
    <xsl:template match="tei:rs[@type='bible']">
        <span class="rs_bible">
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    
    <xsl:template match="tei:rs[@type='myth']">
        <span class="rs_myth">
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    
    <xsl:template match="tei:rs[@type='title']">
        <span class="rs_title">
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    
    <!-- til brugs for txtEditCSS-css end -->
    
    <xsl:template match="tei:p[@rend and not(@rend='hangingIndent')]">        
        <div class="{@rend}">
            <xsl:apply-templates/>
        </div>
    </xsl:template>
    
    <xsl:template match="tei:p[@rend='hangingIndent']">        
        <div class="hangingIndent">
            <xsl:apply-templates/>
        </div>
    </xsl:template>

    <xsl:template match="tei:pb[@type='text' and not(@rend='supp')]">        |
        <!-- <xsl:value-of select="concat('xxx/', substring-before(@facs, '_'), '_', substring-before(substring-after(@facs, '_'), '_'), '/', @facs)"/> -->
        <a href="{@facs}">            
            <span class="pbA">
                <xsl:value-of select="@ed"/>:<xsl:value-of select="@n"/>
            </span>
            
        </a>        
    </xsl:template>
    
    <xsl:template match="tei:pb[@type='text' and @rend='supp']">
        |
        <a href="{@facs}">
            <span class="pbA">
                [<xsl:value-of select="@ed"/>:<xsl:value-of select="@n"/>]
            </span>            
        </a>        
    </xsl:template>
    
    <xsl:template match="tei:pb[@type='ms' and @rend='supp']">
        |
        <a href="{@facs}">
            <span class="pbMs">
                [<xsl:value-of select="@type"/>:<xsl:value-of select="@n"/>]
            </span> 
        </a>       
    </xsl:template>
    
    <xsl:template match="tei:pb[@type='ms' and not(@rend='supp')]">
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
