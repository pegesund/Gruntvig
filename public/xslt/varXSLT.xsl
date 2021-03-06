<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet 
    xmlns:TEI="http://www.tei-c.org/ns/1.0" 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    version="1.0"
    exclude-result-prefixes="#all">

<!-- KSR: 2011.09.26 -->
    <xsl:include href="popups.xsl"/>
    <xsl:template match="TEI:TEI">
        
        <div class="variantMain">            
            <div>
                <div class="title">
                    <xsl:choose>
                        <xsl:when test="TEI:teiHeader/TEI:fileDesc/TEI:titleStmt/TEI:title[@rend='main' and not(@rendition='supp')]">
                            <i><xsl:apply-templates select="//TEI:title[@rend='main' and not(@rendition='supp')]"/></i> 
                        </xsl:when>
                        <xsl:when test="TEI:teiHeader/TEI:fileDesc/TEI:titleStmt/TEI:title[@rend='part' and not(@rendition='supp')]">
                            &#x201C;<xsl:apply-templates select="//TEI:title[@rend='part' and not(@rendition='supp')]"/>&#x201D;
                        </xsl:when>
                    </xsl:choose>
                    <xsl:choose>
                        <xsl:when test="TEI:teiHeader/TEI:fileDesc/TEI:titleStmt/TEI:title[@rend='main' and @rendition='supp']">
                            [<i><xsl:apply-templates select="//TEI:title[@rend='main' and @rendition='supp']"/></i>] 
                        </xsl:when>
                        <xsl:when test="TEI:teiHeader/TEI:fileDesc/TEI:titleStmt/TEI:title[@rend='part' and @rendition='supp']">
                            [&#x201C;<xsl:apply-templates select="//TEI:title[@rend='part' and @rendition='supp']"/>&#x201D;]
                        </xsl:when>                
                    </xsl:choose>
                </div>
                
                <div class="source">
                    <xsl:choose>
                         <xsl:when test="//TEI:note[@xml:id='thisFile' and @type='var']">
                             <div>
                                 <xsl:text>Tekstkilde: </xsl:text>
                                 <xsl:for-each select="//TEI:witness[@xml:id]">
                                     <xsl:apply-templates/>
                                 </xsl:for-each>
                             </div>
                        </xsl:when>
                        <xsl:otherwise/>
                    </xsl:choose>
                </div>
                
                <xsl:choose>
                    <xsl:when test="//TEI:note[@xml:id='thisFile' and @type='var']">
                        <xsl:apply-templates select="TEI:text"/>
                    </xsl:when>
                    <xsl:when test="//TEI:note[@xml:id='thisFile' and @type='minusVar']">
                        <div class="head">
                            <xsl:text>GV udgiver ikke varianter til dette værk.</xsl:text>
                        </div>
                    </xsl:when>
                    <xsl:when test="//TEI:note[@xml:id='thisFile' and @type='someVar']">
                        <div class="head">
                            <xsl:text>GV udgiver nogle varianter til dette værk.</xsl:text>
                        </div>
                    </xsl:when>
                    <xsl:when test="//TEI:note[@xml:id='thisFile' and @type='noVar']">
                        <div class="head">
                            <xsl:text>Varianter er endnu ikke etableret.</xsl:text>
                        </div>
                    </xsl:when>
                    <xsl:when test="//TEI:note[@xml:id='thisFile' and @type='unknownVar']">
                        <div class="head">
                            <xsl:text>Der kendes ikke varianter til dette værk.</xsl:text>
                        </div>
                    </xsl:when>
                </xsl:choose>
            </div>
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
    
    <!-- editor-note START -->
    
    <xsl:template match="TEI:note[@type='editorInLine' or @type='editorFootnote']">
        <div class="editorInLine">
            <xsl:apply-templates/>
        </div>
    </xsl:template>
    
    <!-- editor-note END -->
    
    <xsl:template match="//TEI:div">
        <div>
            <xsl:apply-templates/>
        </div>
        <xsl:call-template name="footnote"/>
    </xsl:template>
    
    <xsl:template name="footnote">
        <xsl:if test=".//TEI:note[@type='footnote']">        
            <br/>
            <hr class="footLine"/>            
            <xsl:apply-templates select=".//TEI:note[@type='footnote']" mode="foot"/>            
        </xsl:if>
    </xsl:template>
    
    <xsl:template match="TEI:note[@type='footnote']">
        <xsl:variable name="id">
            <xsl:number count="TEI:note[@type='footnote']" level="any" from="TEI:text"/>
        </xsl:variable>
        <a id="retur{$id}" href="#note{$id}" class="footMarker">
            <span>
                <xsl:value-of select="$id"/>
            </span>
        </a>
    </xsl:template>
    
    <xsl:template match="TEI:note[@type='footnote']" mode="foot">
        <xsl:variable name="id">
            <xsl:number count="TEI:note[@type='footnote']" level="any" from="TEI:text"/>
        </xsl:variable>
        <a id="note{$id}" href="#retur{$id}" class="footMarker">
            <span>
                <xsl:value-of select="$id"/>
            </span>
        </a>
        <span class="footnote">
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    
    <xsl:template match="TEI:hi">
        <span class="{@rend}">
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    
    <xsl:template match="TEI:title[@rend='part' or @rend='main']/TEI:hi[@rend and @rendition]">
        <span class="{@rendition}Title">
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    
    
    <!-- added by pe 16/1, ændret 2012.09.20 KSR -->
    
    
    
    <xsl:template match="TEI:app[@type='corrNote']">
        <span class="app" href="#">
            <span class="lem">
                <xsl:apply-templates select="TEI:lem"/>
            </span>
            <span class="appInvisible">
                <xsl:text>] </xsl:text>
                <xsl:if test="TEI:lem/@wit!='A'">
                    <span class="wit">
                        <i>
                            <xsl:value-of select="TEI:lem/@wit"/>
                            <xsl:text>, </xsl:text>
                        </i>
                    </span>
                </xsl:if>
                <xsl:apply-templates select="TEI:rdg[not(@type)]"/>
                <xsl:text> </xsl:text>
                <xsl:if test="*[@type='add']">
                    <xsl:apply-templates select="*[@type='add']"/>
                </xsl:if>
            </span>
        </span>
    </xsl:template>
    
    <xsl:template match="TEI:rdg[@wit]">
        <xsl:apply-templates/>
        <span class="wit">                
            <xsl:text> </xsl:text>
            <i>
                <xsl:value-of select="@wit"/>
                <xsl:choose>
                    <xsl:when test="following-sibling::TEI:rdg[current()/@type or not(@type)]">
                        <xsl:text>, </xsl:text>
                    </xsl:when>
                    <xsl:when test="following-sibling::TEI:rdg[not(current()/@type) and @type]">
                        <xsl:text>; </xsl:text>
                    </xsl:when>
                </xsl:choose>
                <!-- kan koges ned til: 
                    <xsl:when test="following-sibling::TEI:rdg">
                    <xsl:text>; </xsl:text>
                    </xsl:when> -->                
            </i>
        </span>
    </xsl:template>
    
    <xsl:template match="TEI:app[@id]">
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

    <xsl:template match="TEI:rdg[not(@wit)]">
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
    
    <xsl:template match="TEI:pb[@type='supp' and @ed='A']">
        <xsl:text>|</xsl:text>
        <span class="pb">
            [<xsl:value-of select="@ed"/>:<xsl:value-of select="@n"/>]
        </span> 
    </xsl:template>
    
    <xsl:template match="TEI:pb[not(@type='supp') and @ed='A' or @ed='V']">
        <xsl:text>|</xsl:text>
        <span class="pb">
            <xsl:value-of select="@ed"/>:<xsl:value-of select="@n"/>
        </span> 
    </xsl:template>

    
</xsl:stylesheet>
