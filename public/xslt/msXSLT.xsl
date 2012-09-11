<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet
  xmlns="http://www.w3.org/1999/xhtml"
  version="2.0"
  xmlns:a="http://relaxng.org/ns/compatibility/annotations/1.0"
  xmlns:fo="http://www.w3.org/1999/XSL/Format"
  xmlns:html="http://www.w3.org/1999/xhtml"
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
        <xsl:apply-templates select="//tei:title"/>
    </xsl:template>
    
    <xsl:template match="tei:title">
        <p><h3>
            <xsl:apply-templates/>
           </h3>
        </p>
    </xsl:template>
 
    <xsl:template match="tei:title[@type='katalogsignatur']">
    </xsl:template>
 
    
    <xsl:template match="tei:tei">
            
            <div class="manusMain">
                
                <div class="head">
                    <xsl:apply-templates select="tei:teiHeader/tei:fileDesc/tei:titleStmt/tei:title"/>
                </div>
                
                <div class="source">
                    <div class="source">
                        <xsl:text>Tekstkilde:</xsl:text>
                    </div>
                    <xsl:for-each select="//TEI:bibl/TEI:author">
                        <xsl:apply-templates select="."/>
                        <xsl:text> </xsl:text>
                        <xsl:text>(</xsl:text>
                        <xsl:for-each select="//TEI:bibl/TEI:date">
                            <xsl:apply-templates select="."/>
                        </xsl:for-each>
                        <xsl:text>) </xsl:text>
                    </xsl:for-each>
                    <xsl:for-each select="//TEI:title[@type='katalogsignatur']">
                        <xsl:apply-templates select="."/>
                    </xsl:for-each>
                </div>
                
                <xsl:apply-templates select="tei:text"/>
                
                <xsl:if test="//tei:note[@type='footnote']">
                    
                    <br/>
                    
                    <hr class="footLine"/>
                    
                    <xsl:apply-templates select="//tei:note[@type='footnote']" mode="foot"/>
                
                </xsl:if>
            </div>
        
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
    
    <xsl:template match="TEI:lg">
        <div class="lg">
            <xsl:apply-templates/>
        </div>
    </xsl:template>
    
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
        <span>
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    
    <xsl:template match="TEI:lem[@type='add' and not(TEI:l)]">
        <span class="l">
            <xsl:text>[</xsl:text>
            <xsl:apply-templates/>
            <xsl:text>]</xsl:text>
        </span>
    </xsl:template>
    
    <xsl:template match="//TEI:lem[@type='add']/TEI:l[position()=1]">
        <div class="l">
            <xsl:text>[</xsl:text>
            <xsl:apply-templates/>
        </div>
    </xsl:template>
    
    <xsl:template match="//TEI:lem[@type='add']/TEI:l[position()=last()]">
        <div class="l">
            <xsl:apply-templates/>
            <xsl:text>]</xsl:text>
        </div>
    </xsl:template>
    
    <xsl:template match="TEI:del">
        <xsl:choose>
            <xsl:when test="@type='add'">
                <xsl:text>[</xsl:text>
                <xsl:apply-templates/>
                <xsl:text>]</xsl:text>
            </xsl:when>
            <xsl:when test="@type='firstDel'">                
                <span class="firstDel">
                    <xsl:apply-templates/>
                </span>
            </xsl:when>
            <xsl:when test="@type='shading'">
                <span class="shading">
                    <xsl:apply-templates/>
                </span>
            </xsl:when>
            <xsl:when test="@hand='doubt'">
                <xsl:text>&lt;</xsl:text>
                <xsl:apply-templates/>
                <xsl:text>&gt;</xsl:text>
            </xsl:when>
            <xsl:when test="@type='immediate'">
                <span class="immediate">
                    <xsl:apply-templates/>
                </span>
            </xsl:when>
            <xsl:when test="@type='secondDel'">
                <span class="secondDel">
                    <xsl:apply-templates/>
                </span>
            </xsl:when>
            <xsl:when test="@type='thirdDel'">
                <span class="thirdDel">
                    <span class="redLine">
                        <xsl:apply-templates/>
                    </span>                    
                </span>
            </xsl:when>
        </xsl:choose>
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
    
    <!--
    
    <xsl:template match="TEI:note[@type='footnote']">
        *
        <hr class="footLine"/>
        <div class="footnote">
            <xsl:apply-templates/>
        </div>
    </xsl:template>
    
    -->
    
    <xsl:template match="TEI:hi">        
        <span class="{@rend}">
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    
    <!-- til brugs for txtEditCSS-css start -->
    
    <xsl:template match="TEI:persName">
        <span class="persName">
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    
    <xsl:template match="TEI:placeName">
        <span class="placeName">
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    
    <xsl:template match="TEI:rs[@type='bible']">
        <span class="rs_bible">
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    
    <xsl:template match="TEI:rs[@type='myth']">
        <span class="rs_myth">
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    
    <xsl:template match="TEI:rs[@type='title']">
        <span class="rs_title">
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    
    <!-- til brugs for txtEditCSS-css end -->
    
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
