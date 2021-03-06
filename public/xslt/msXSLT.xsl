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
            <xsl:if test="//tei:title[@type='main']">
                <i><xsl:apply-templates select="//tei:title[@type='main']"/></i>
            </xsl:if>
            <xsl:if test="//tei:title[@type='part']">
                <xsl:text>&#x201C;</xsl:text><xsl:apply-templates select="//tei:title[@type='part']"/><xsl:text>&#x201D;</xsl:text>
            </xsl:if>            
        </div>
                
                <div class="source">
                    <div class="source">
                        <xsl:text>Tekstkilde:</xsl:text>
                    </div>
                    <xsl:for-each select="//tei:bibl/tei:author">
                        <xsl:apply-templates select="."/>
                        <xsl:text> </xsl:text>
                        <xsl:text>(</xsl:text>
                        <xsl:for-each select="//tei:bibl/tei:date">
                            <xsl:apply-templates select="."/>
                        </xsl:for-each>
                        <xsl:text>) </xsl:text>
                    </xsl:for-each>
                    <xsl:for-each select="//tei:title[@type='katalogsignatur']">
                        <xsl:apply-templates select="."/>
                    </xsl:for-each>
                </div>
                
                <xsl:apply-templates select="tei:text"/>
                
                <!--<xsl:if test="//tei:note[@type='footnote']">
                    
                    <br/>
                    
                    <hr class="footLine"/>
                    
                    <xsl:apply-templates select="//tei:note[@type='footnote']" mode="foot"/>
                
                </xsl:if>-->
        
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
    
    <xsl:template match="tei:rdg">
        <span>
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    
    <xsl:template match="tei:lem[@type='add' and not(tei:l)]">
        <span class="l">
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
    
    <xsl:template match="tei:del">
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
    
    <xsl:template match="tei:note[@type='add']">        
        <span class="editor">
            <i>
                <xsl:value-of select="tei:note[@type='add']"/>
            </i>                        
        </span>
    </xsl:template>
    
    <!-- footnote START -->
    
    <xsl:template name="footnote">
        <xsl:if test=".//tei:note[@type='footnote']">
            <hr class="footLine"/>
            <xsl:apply-templates select=".//tei:note[@type='footnote']" mode="foot"/>
        </xsl:if>
    </xsl:template>
    
    <xsl:template match="tei:note[@type='footnote']">
        <xsl:variable name="id">
            <xsl:number level="any" from="tei:text"/>
        </xsl:variable>
        <a id="retur{$id}" href="#note{$id}" class="footnote">
            <xsl:value-of select="$id"/>
        </a>
    </xsl:template>
    
    <xsl:template match="tei:note[@type='footnote']" mode="foot">
        <xsl:variable name="id">
            <xsl:number level="any" from="tei:text"/>
        </xsl:variable>
        <a id="note{$id}" href="#retur{$id}" class="footnote">
            <xsl:value-of select="$id"/>
        </a>               
        <span class="footnote">
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    
    <xsl:template match="tei:div">
        <div>
            <xsl:apply-templates/>
        </div>
        <xsl:call-template name="footnote"/>
    </xsl:template>
    
    <!-- footnote END -->
    
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
    
    <!--<pb type="ms" facs="1826_433A_fax001.jpg" n="1" rend="supp" />-->

    <xsl:template match="tei:pb[@type='ms' and not(@rend='supp')]"> 
        <span onclick="showhidePb('{generate-id()}')" style="cursor:pointer" title="ms.">|</span>
        <span id="{generate-id()}" class="appInvisible">
            <a href="{@facs}" class="app" title="fax" id="{@facs}">
                <xsl:value-of select="@ed"/>:<xsl:value-of select="@n"/>
            </a>
        </span>
    </xsl:template>
    
    <xsl:template match="tei:pb[@type='ms' and @rend='supp']">
            <span onclick="showhidePb('{generate-id()}')" style="cursor:pointer" title="ms.">|</span>
            <span id="{generate-id()}" class="appInvisible">
                <a href="{@facs}" class="app" title="fax" id="{@facs}">
                    <xsl:text>[</xsl:text>
                    <xsl:value-of select="@ed"/>:<xsl:value-of select="@n"/>
                    <xsl:text>]</xsl:text>
                </a>
            </span>
    </xsl:template>

    <xsl:template match="tei:pb[@type='text' and not(@rend='supp')]"> 
        <span onclick="showhidePb('{generate-id()}')" style="cursor:pointer" title="A">|</span>
        <span id="{generate-id()}" class="appInvisible">
            <a href="{@facs}" class="app" title="fax" id="{@facs}">
                <xsl:value-of select="@ed"/>:<xsl:value-of select="@n"/>
            </a>
        </span>
    </xsl:template>
    
    <xsl:template match="tei:pb[@type='text' and @rend='supp']">
            <span onclick="showhidePb('{generate-id()}')" style="cursor:pointer" title="A">|</span>
            <span id="{generate-id()}" class="appInvisible">
                <a href="{@facs}" class="app" title="fax" id="{@facs}">
                    <xsl:text>[</xsl:text>
                    <xsl:value-of select="@ed"/>:<xsl:value-of select="@n"/>
                    <xsl:text>]</xsl:text>
                </a>
            </span>
    </xsl:template>
    
    <xsl:template match="tei:pb[@type='edition']">
        <span onclick="showhidePb('{generate-id()}')" style="cursor:pointer" title="{@ed}">|</span>
        <span id="{generate-id()}" class="appInvisible">
            <xsl:value-of select="@ed"/>:<xsl:value-of select="@n"/>
        </span>
    </xsl:template>

    <xsl:template match="tei:pb[@type='text' and not(@rend='supp') and not(parent::tei:seg)]"> 
        <a hrel="{@facs}" class="app faksimile_viewer" style="cursor:pointer">
            <span class="pb{@ed}">
            <xsl:text>|</xsl:text>
                <xsl:value-of select="@ed"/>:<xsl:value-of select="@n"/>
            </span>
        </a>        
    </xsl:template>
    
    <xsl:template match="tei:pb[@type='ms' and @rend='supp']">
        <a hrel="{@facs}" class="app faksimile_viewer" style="cursor:pointer">
            <span class="pb{@ed}">
            <xsl:text>|</xsl:text>
                [<xsl:value-of select="@ed"/>:<xsl:value-of select="@n"/>]
            </span>
        </a>  
    </xsl:template>

    <xsl:template match="tei:pb[@type='ms' and not(@rend='supp') and not(parent::tei:seg)]"> 
        <a hrel="{@facs}" class="app faksimile_viewer" style="cursor:pointer">
            <span class="pb{@ed}">
            <xsl:text>|</xsl:text>
                <xsl:value-of select="@ed"/>:<xsl:value-of select="@n"/>
            </span>
        </a>        
    </xsl:template>
    
    <xsl:template match="tei:pb[@type='text' and @rend='supp']">
        <a hrel="{@facs}" class="app faksimile_viewer" style="cursor:pointer">
            <span class="pb{@ed}">
            <xsl:text>|</xsl:text>
                [<xsl:value-of select="@ed"/>:<xsl:value-of select="@n"/>]
            </span>
        </a>  
    </xsl:template>

    <!-- xsl:template match="tei:pb[@type='text' and not(@rend='supp')]">        |
        <<xsl:value-of select="concat('xxx/', substring-before(@facs, '_'), '_', substring-before(substring-after(@facs, '_'), '_'), '/', @facs)"/>
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
    </xsl:template-->
    
    <xsl:template name="delimiterComma">
        <xsl:text>, </xsl:text>
    </xsl:template>
    
    <xsl:template name="delimiterFullStop">
        <xsl:text>.</xsl:text>
    </xsl:template>

<!-- pb{@ed} til forsk stil til hver ed -->

<!--
    
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
-->
    
</xsl:stylesheet>