<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE stylesheet [
<!ENTITY month "          januar    februar   marts     april     maj       juni      juli      august    september oktober   november  december">
]>
<xsl:stylesheet 
    xmlns:TEI="http://www.tei-c.org/ns/1.0" 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    version="1.0"
    exclude-result-prefixes="#all"
>

<!-- Kim Steen Ravn:
    2011.10.04: list-style: alpha, roman and simple
    2011.06.27: sic and supp, note element
    2011.03.21
    2011.03.18  
    KK 2013-11-21: ref biblDesc
-->

    <xsl:template match="TEI:TEI">
        
        <div class="mainTxr">
            <div class="head">
                <xsl:if test="//TEI:title[@rend='main' and not(@rendition) and not(@next) and not(@prev)]">
                    <div>
                        <xsl:text>Tekstredegørelse til</xsl:text>
                    </div>
                    <xsl:call-template name="title"/>
                    <div class="author">
                        <xsl:text>ved </xsl:text>
                        <xsl:for-each select="//TEI:titleStmt/TEI:author">
                            <xsl:value-of select="."/>
                            <xsl:if test="following-sibling::TEI:author">
                                <xsl:choose>
                                    <xsl:when test="following-sibling::TEI:teiHeader/TEI:fileDesc/TEI:titleStmt/TEI:author[position()!=last()]">
                                        <xsl:text>, </xsl:text>
                                    </xsl:when>
                                    <xsl:otherwise>
                                        <xsl:text> og </xsl:text>
                                    </xsl:otherwise>
                                </xsl:choose>
                            </xsl:if>
                        </xsl:for-each>
                    </div>
                </xsl:if>
                <xsl:if test="//TEI:title[@rend='main' and @rendition='supp' and not(@next) and not(@prev)]">
                    <div>
                        <xsl:text>Tekstredegørelse til</xsl:text>
                    </div>
                    <xsl:call-template name="title"/>
                    <div class="author">
                        <xsl:text>ved </xsl:text>
                        <xsl:for-each select="//TEI:titleStmt/TEI:author">
                            <xsl:value-of select="."/>
                            <xsl:if test="following-sibling::TEI:author">
                                <xsl:choose>
                                    <xsl:when test="following-sibling::TEI:teiHeader/TEI:fileDesc/TEI:titleStmt/TEI:author[position()!=last()]">
                                        <xsl:text>, </xsl:text>
                                    </xsl:when>
                                    <xsl:otherwise>
                                        <xsl:text> og </xsl:text>
                                    </xsl:otherwise>
                                </xsl:choose>
                            </xsl:if>
                        </xsl:for-each>
                    </div>
                </xsl:if>
                <xsl:if test="//TEI:title[@rend='main' and not(@rendition) and @next and not(@prev)]">
                    <div>
                        <xsl:text>Tekstredegørelse til</xsl:text>
                    </div>
                    <xsl:call-template name="title"/>
                    <div class="author">
                        <xsl:text>ved </xsl:text>
                        <xsl:for-each select="//TEI:titleStmt/TEI:author">
                            <xsl:value-of select="."/>
                            <xsl:if test="following-sibling::TEI:author">
                                <xsl:choose>
                                    <xsl:when test="following-sibling::TEI:teiHeader/TEI:fileDesc/TEI:titleStmt/TEI:author[position()!=last()]">
                                        <xsl:text>, </xsl:text>
                                    </xsl:when>
                                    <xsl:otherwise>
                                        <xsl:text> og </xsl:text>
                                    </xsl:otherwise>
                                </xsl:choose>
                            </xsl:if>
                        </xsl:for-each>
                    </div>
                </xsl:if>
                <xsl:if test="//TEI:title[@rend='main' and not(@rendition) and not(@next) and @prev='Anmeldelse af']">
                    <div>
                        <xsl:text>Tekstredegørelse til</xsl:text>
                    </div>
                    <xsl:call-template name="title"/>
                    <div class="author">
                        <xsl:text>ved </xsl:text>
                        <xsl:for-each select="//TEI:titleStmt/TEI:author">
                            <xsl:value-of select="."/>
                            <xsl:if test="following-sibling::TEI:author">
                                <xsl:choose>
                                    <xsl:when test="following-sibling::TEI:teiHeader/TEI:fileDesc/TEI:titleStmt/TEI:author[position()!=last()]">
                                        <xsl:text>, </xsl:text>
                                    </xsl:when>
                                    <xsl:otherwise>
                                        <xsl:text> og </xsl:text>
                                    </xsl:otherwise>
                                </xsl:choose>
                            </xsl:if>
                        </xsl:for-each>
                    </div>
                </xsl:if>                    
                <xsl:if test="//TEI:title[@rend='part' and not(@rendition) and not(@next) and not(@prev)]">
                    <div>
                        <xsl:text>Tekstredegørelse til</xsl:text>
                    </div>
                    <xsl:call-template name="title"/>
                    <div class="author">
                        <xsl:text>ved </xsl:text>
                        <xsl:for-each select="//TEI:titleStmt/TEI:author">
                            <xsl:value-of select="."/>
                            <xsl:if test="following-sibling::TEI:author">
                                <xsl:choose>
                                    <xsl:when test="following-sibling::TEI:teiHeader/TEI:fileDesc/TEI:titleStmt/TEI:author[position()!=last()]">
                                        <xsl:text>, </xsl:text>
                                    </xsl:when>
                                    <xsl:otherwise>
                                        <xsl:text> og </xsl:text>
                                    </xsl:otherwise>
                                </xsl:choose>
                            </xsl:if>
                        </xsl:for-each>
                    </div>
                </xsl:if>
                <xsl:if test="//TEI:title[@rend='part' and @rendition='supp' and not(@next) and not(@prev)]">
                    <div>
                        <xsl:text>Tekstredegørelse til</xsl:text>
                    </div>
                    <xsl:call-template name="title"/>
                    <div class="author">
                        <xsl:text>ved </xsl:text>
                        <xsl:for-each select="//TEI:titleStmt/TEI:author">
                            <xsl:value-of select="."/>
                            <xsl:if test="following-sibling::TEI:author">
                                <xsl:choose>
                                    <xsl:when test="following-sibling::TEI:teiHeader/TEI:fileDesc/TEI:titleStmt/TEI:author[position()!=last()]">
                                        <xsl:text>, </xsl:text>
                                    </xsl:when>
                                    <xsl:otherwise>
                                        <xsl:text> og </xsl:text>
                                    </xsl:otherwise>
                                </xsl:choose>
                            </xsl:if>
                        </xsl:for-each>
                    </div>
                </xsl:if>
                <xsl:if test="//TEI:title[@rend='part' and not(@rendition) and @next and not(@prev)]">
                    <div>
                        <xsl:text>Tekstredegørelse til</xsl:text>
                    </div>
                    <xsl:call-template name="title"/>
                    <div class="author">
                        <xsl:text>ved </xsl:text>
                        <xsl:for-each select="//TEI:titleStmt/TEI:author">
                            <xsl:value-of select="."/>
                            <xsl:if test="following-sibling::TEI:author">
                                <xsl:choose>
                                    <xsl:when test="following-sibling::TEI:teiHeader/TEI:fileDesc/TEI:titleStmt/TEI:author[position()!=last()]">
                                        <xsl:text>, </xsl:text>
                                    </xsl:when>
                                    <xsl:otherwise>
                                        <xsl:text> og </xsl:text>
                                    </xsl:otherwise>
                                </xsl:choose>
                            </xsl:if>
                        </xsl:for-each>
                    </div>
                </xsl:if>
                <xsl:if test="//TEI:title[@rend='part' and not(@rendition) and not(@next) and @prev='Anmeldelse af']">
                    <div>
                        <xsl:text>Tekstredegørelse til</xsl:text>
                    </div>
                    <xsl:call-template name="title"/>
                    <div class="author">
                        <xsl:text>ved </xsl:text>
                        <xsl:for-each select="//TEI:titleStmt/TEI:author">
                            <xsl:value-of select="."/>
                            <xsl:if test="following-sibling::TEI:author">
                                <xsl:choose>
                                    <xsl:when test="following-sibling::TEI:teiHeader/TEI:fileDesc/TEI:titleStmt/TEI:author[position()!=last()]">
                                        <xsl:text>, </xsl:text>
                                    </xsl:when>
                                    <xsl:otherwise>
                                        <xsl:text> og </xsl:text>
                                    </xsl:otherwise>
                                </xsl:choose>
                            </xsl:if>
                        </xsl:for-each>
                    </div>
                </xsl:if>
            </div>
            <xsl:choose>
                <xsl:when test="//TEI:note[@type='txr']">
                    <div class="content"><xsl:text>Indhold</xsl:text></div>
                    <xsl:apply-templates mode="toc" select="TEI:text/TEI:body/TEI:div"/>
                    <xsl:apply-templates select="TEI:text"/>
                </xsl:when>
                <xsl:otherwise>
                    <div class="head">
                        <xsl:text>er under udarbejdelse</xsl:text>
                    </div>
                </xsl:otherwise>
            </xsl:choose>
        </div>        
    </xsl:template>
    
    <xsl:template match="TEI:div" mode="toc">
        <div class="toc" id="retur">
            <a class="toc txrmenu">
                <xsl:attribute name="hrel">
                    <xsl:value-of select="replace(base-uri(), '.*?([0-9].*)_txr.xml$', '$1')" />
                    <xsl:text>_txr_</xsl:text>
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
    
    <xsl:template match="TEI:head">
        <a class="toc txrmenu" title="til toppen">
            <xsl:attribute name="id">
                <xsl:value-of select="replace(base-uri(), '.*?([0-9].*)_txr.xml$', '$1')" />
                <xsl:text>_txr_</xsl:text>
                <xsl:number level="multiple" count="TEI:div"/>
            </xsl:attribute>
        </a>
        <div class="head{@rend}">
            <xsl:attribute name="id">
                <xsl:value-of select="replace(base-uri(), '.*?([0-9].*)_txr.xml$', '$1_')" />
                <xsl:text>txr_</xsl:text>
                <xsl:value-of select="@xml:id"/>
            </xsl:attribute>
            <a hrel="#retur" class="toc txrmenu" title="til toppen">
                <xsl:number level="multiple" count="TEI:div"/>
                <xsl:text> </xsl:text>
                <xsl:apply-templates/>
            </a>
        </div>
    </xsl:template>
    
    <xsl:template name="title">
        <xsl:choose>
            <xsl:when test="//TEI:titleStmt/TEI:author">
                <xsl:choose>
                    <xsl:when test="//TEI:title[@rend='main' and not(@rendition) and not(@next) and not(@prev)]">
                        <i><xsl:apply-templates select="//TEI:title[@rend='main']"/></i>
                    </xsl:when>
                    <xsl:when test="//TEI:title[@rend='main' and @rendition='supp']">
                        <i>[<xsl:apply-templates select="//TEI:title[@rend='main']"/>]</i>
                    </xsl:when>
                    <xsl:when test="//TEI:title[@rend='main' and not(@rendition) and not(@next) and @prev='Anmeldelse af']">
                        <xsl:text>[Anmeldelse af] </xsl:text><i><xsl:apply-templates select="//TEI:title[@rend='main']"/></i>
                    </xsl:when>
                    <xsl:when test="//TEI:title[@rend='main' and not(@rendition) and @next and not(@prev)]">
                        <i><xsl:apply-templates select="//TEI:title[@rend='main']"/></i><xsl:text> [</xsl:text><xsl:value-of select="//TEI:title[@rend='main']/@next"/><xsl:text>]</xsl:text>
                    </xsl:when>
                    
                    <xsl:when test="//TEI:title[@rend='part' and not(@rendition='supp') and not(@next) and not(@prev)]">
                        &#x201C;<xsl:apply-templates select="//TEI:title[@rend='part']"/>&#x201D;
                    </xsl:when>
                    <xsl:when test="//TEI:title[@rend='part' and @rendition='supp']">
                        &#x201C;[<xsl:apply-templates select="//TEI:title[@rend='part']"/>]&#x201D;
                    </xsl:when>
                    <xsl:when test="//TEI:title[@rend='part' and not(@rendition='supp') and not(@next) and @prev='Anmeldelse af']">
                        <xsl:text>&#x201C;[Anmeldelse af] </xsl:text><xsl:apply-templates select="//TEI:title[@rend='part']"/>&#x201D;
                    </xsl:when>
                    <xsl:when test="//TEI:title[@rend='part' and not(@rendition='supp') and @next and not(@prev)]">
                        &#x201C;<xsl:apply-templates select="//TEI:title[@rend='part']"/><xsl:text> [</xsl:text><xsl:value-of select="//TEI:title[@rend='part']/@next"/><xsl:text>]</xsl:text>&#x201D;
                    </xsl:when>
                </xsl:choose>
            </xsl:when>
        </xsl:choose>
    </xsl:template>
    
    <xsl:template match="TEI:teiHeader/TEI:fileDesc/TEI:titleStmt/TEI:editor[@role='editor']">        
        <div class="editor">
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
    <xsl:template match="TEI:ref[@target and not(@select)]">
        <span class="ref">
            <a href="{@target}" target="_blank">
                <xsl:apply-templates/>
            </a>
        </span>
    </xsl:template>
    --> 
    
    <xsl:template name="stripNull">
        <xsl:param name="n"/>
        <xsl:choose>
            <xsl:when test="starts-with($n,'0')">
                <xsl:call-template name="stripNull">
                    <xsl:with-param name="n" select="substring-after($n,'0')"/>
                </xsl:call-template>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="$n"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    <xsl:template match="TEI:pb">
        <xsl:variable name="newTarget">
            <xsl:value-of select="substring-before(@target,'fax')"/>
            <xsl:call-template name="stripNull">
                <xsl:with-param name="n" select="substring-after(@target,'fax')"/>
            </xsl:call-template>
        </xsl:variable>
        <xsl:choose>
            <xsl:when test="@type='image'">
                <a href="img/{$newTarget}">
                    <xsl:apply-templates/>
                </a>
            </xsl:when>
        </xsl:choose>
    </xsl:template>
    
    <xsl:template match="TEI:ref[@type]">
        <xsl:variable name="newTarget">
            <xsl:value-of select="substring-before(@target,'fax')"/>
            <xsl:call-template name="stripNull">
                <xsl:with-param name="n" select="substring-after(@target,'fax')"/>
            </xsl:call-template>
        </xsl:variable>
            <xsl:choose>
                <xsl:when test="@type='biblDesc'">
                    <a href="biblio/{@target}" onclick="return blank('biblDesc',this.href)">
                        <xsl:apply-templates/>
                    </a>
                </xsl:when>
                <xsl:when test="@type='litListWeb'">
                    <a href="{@target}" target="_blank">
                        <xsl:apply-templates/>
                    </a>
                </xsl:when>
                <xsl:when test="@type='web' and @target">
                    <a href="{@target}" target="_blank">
                        <xsl:apply-templates/>
                    </a>
                </xsl:when>
                <xsl:when test="@type='image'">
                    <a href="img/{$newTarget}">
                        <xsl:apply-templates/>
                    </a>
                </xsl:when>
                <xsl:when test="@select">                    
                    <a href="#http://{.}">
                        <xsl:apply-templates/>
                    </a>
                </xsl:when>
                <xsl:when test="@type='docIn'">
                    <span class="docIn">
                        <xsl:attribute name="name">
                            <xsl:value-of select="replace(base-uri(), '.*?([0-9].*)_txr.xml$', '$1')" />
                            <xsl:text>_</xsl:text>
                            <xsl:text>txr.xml</xsl:text>
                            <xsl:value-of select="@target"/>
                        </xsl:attribute>
                    <xsl:apply-templates/>
                    </span>
                </xsl:when>                   
                <xsl:when test="@type='docOut'">
                    <a class="docOut">
                        <xsl:attribute name="name">
                            <xsl:value-of select="@target"/>
                        </xsl:attribute>           
                        <xsl:apply-templates/>         
                    </a>
                </xsl:when>
                 <xsl:when test="@type='epiText'">
                    <a class="pdf"
                       href="img/{@target}"
                       onclick="return blank('epi',this.href)">
                        <xsl:apply-templates/>
                    </a>       
                </xsl:when>
            </xsl:choose>   
    </xsl:template>

    <xsl:template match="TEI:lg|TEI:l">
        <div class="{name()}">
            <!--xsl:attribute name="class"><xsl:value-of select="name()"/></xsl:attribute-->
            <xsl:apply-templates/>
        </div>
    </xsl:template>
    
    <xsl:template match="TEI:rdg">
        <xsl:apply-templates/>
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
        </i>
    </xsl:template>
    
    <xsl:template match="TEI:list">
        <xsl:if test="@type='decimal'">
            <ul class="decimal">
                <xsl:for-each select="TEI:item">
                    <li>
                        <xsl:apply-templates/>
                    </li>                
                </xsl:for-each>
            </ul>
        </xsl:if>
        <xsl:if test="@type='lowerAlpha' or @type='subLowerAlpha'">
            <ul class="lowerAlpha">
                <xsl:for-each select="TEI:item">
                    <li>
                        <xsl:apply-templates/>
                    </li>                
                </xsl:for-each>
            </ul>
        </xsl:if>
        <xsl:if test="@type='lowerRoman' or @type='subLowerRoman'">
            <ul class="lowerRoman">
                <xsl:for-each select="TEI:item">
                    <li>
                        <xsl:apply-templates/>
                    </li>                
                </xsl:for-each>
            </ul>
        </xsl:if>
        <xsl:if test="@type='ordered' or @type='subOrdered'">
            <ul class="ordered">
                <xsl:for-each select="TEI:item">
                    <li>
                        <xsl:apply-templates/>
                    </li>
                </xsl:for-each>
            </ul>
        </xsl:if>
        <xsl:if test="@type='simple' or @type='subSimple'">
            <ul class="simple">
                <xsl:for-each select="TEI:item">
                    <li>
                        <xsl:apply-templates/>
                    </li>                
                </xsl:for-each>
            </ul>
        </xsl:if>
        <xsl:if test="@type='upperAlpha' or @type='subUpperAlpha'">
            <ul class="upperAlpha">
                <xsl:for-each select="TEI:item">
                    <li>
                        <xsl:apply-templates/>
                    </li>                
                </xsl:for-each>
            </ul>
        </xsl:if>
        <xsl:if test="@type='upperRoman' or @type='subUpperRoman'">
            <ul class="upperRoman">
                <xsl:for-each select="TEI:item">
                    <li>
                        <xsl:apply-templates/>
                    </li>                
                </xsl:for-each>
            </ul>
        </xsl:if>
        <xsl:if test="@type='addendon'">
            <div class="litList">
                <xsl:apply-templates/>
            </div>
        </xsl:if>
        <xsl:if test="@target or @type='webList'">
            <div class="litList">
                <a href="{@target}" target="_blank">
                    <xsl:apply-templates/>
                </a>
            </div>
        </xsl:if>
        <xsl:if test="@type='litList'">
            <div class="litList">
                <ul>
                    <xsl:for-each select="TEI:item">
                        <li class="ordered">
                            <xsl:apply-templates/>
                            <xsl:text>.</xsl:text>
                        </li>
                    </xsl:for-each>
                </ul>
            </div>
        </xsl:if>
    </xsl:template>
    
    <xsl:template match="TEI:item[not(@n)]">
        <li class="liOrdered">
            <xsl:apply-templates/>
        </li>
    </xsl:template>
    
    <xsl:template match="TEI:item[@n]">
        <ul>
            <li class="ordered">
                <a href="{@target}" target="_blank">
                    <xsl:apply-templates/>
                </a>
                <xsl:text> (</xsl:text>
                <xsl:number value="substring(@n, 9,2)" format="1"/>
                <xsl:text>. </xsl:text>
                <xsl:value-of select="substring('&month;',substring(@n,6,2)*10+1,9)"/>
                <xsl:text> </xsl:text>
                <xsl:value-of select="substring(@n, 1,4)"/>
                <xsl:text>)</xsl:text>
            </li>
        </ul>
    </xsl:template>
    
    <xsl:template match="TEI:list[@type='textualCriticismPluralis' or @type='textualCriticismSingularis' or @type='textualCriticismSupp' or @type='textualCriticismZero']">
        <xsl:choose>
            <xsl:when test="@type='textualCriticismPluralis'">                
                <div class="txtCrit"><xsl:text>Der er foretaget følgende tekstrettelser</xsl:text> (<a href="http://www.xn--grundtvigsvrker-7lb.dk/vejledning/tknoter_vej">se vejledning til de tekstkritiske noter</a>):</div>
                <table class="textualCriticism">
                    <xsl:choose>
                        <xsl:when test="document(//TEI:note[@type='txt']/@target)//TEI:pb[@type='text' and not(@subtype)]">
                            <tr>
                                <td>Side</td>
                                <td>Note</td>
                            </tr>
                        </xsl:when>
                        <xsl:when test="document(//TEI:note[@type='txt']/@target)//TEI:pb[@type='text' and @subtype='column']">
                            <tr>
                                <td>Spalte</td>
                                <td>Note</td>
                            </tr>
                        </xsl:when>
                    </xsl:choose>
                    <xsl:for-each select="document(//TEI:note[@type='txt']/@target)//TEI:app">
                        <tr>
                            <td>
                                <xsl:value-of select="preceding::TEI:pb[@type='text'][1]/@n"/>
                                &#x2003;
                            </td>
                            <td>
                                <xsl:apply-templates select="TEI:lem"/>
                                <xsl:text>] </xsl:text>
                                <xsl:if test="TEI:lem/@wit!='A'">
                                    <i>
                                        <xsl:value-of select="TEI:lem/@wit"/>
                                        <xsl:text>, </xsl:text>
                                    </i>                                    
                                </xsl:if>
                                <xsl:if test="TEI:rdg[not(@type) and not(child::TEI:g)]">
                                    <xsl:apply-templates select="TEI:rdg"/>
                                </xsl:if>
                                <xsl:if test="TEI:rdg[not(@type) and child::TEI:g]">
                                    <xsl:apply-templates select="TEI:rdg"/>
                                </xsl:if>
                                <xsl:if test="TEI:rdg[@type='add']">
                                    <xsl:apply-templates select="TEI:rdg[@type='add']"/>
                                </xsl:if>
                                <xsl:if test="TEI:note[@type='add']">
                                    <xsl:text> </xsl:text>
                                    <xsl:apply-templates select="TEI:note[@type='add']"/>
                                    <xsl:text> </xsl:text>
                                    <i>
                                        <xsl:apply-templates select="TEI:note[@type='add']/@subtype"/>
                                    </i>
                                </xsl:if>
                            </td>
                        </tr>
                    </xsl:for-each>
                </table>
            </xsl:when>
            <xsl:when test="@type='textualCriticismSingularis'">                
                <div class="txtCrit"><xsl:text>Der er foretaget følgende tekstrettelser</xsl:text> (<a href="http://www.xn--grundtvigsvrker-7lb.dk/vejledning/tknoter_vej">se vejledning til de tekstkritiske noter</a>):</div>
                <table class="textualCriticism">
                    <xsl:choose>
                        <xsl:when test="document(//TEI:note[@type='txt']/@target)//TEI:pb[@type='text' and not(@subtype)]">
                            <tr>
                                <td>Side</td>
                                <td>Note</td>
                            </tr>
                        </xsl:when>
                        <xsl:when test="document(//TEI:note[@type='txt']/@target)//TEI:pb[@type='text' and @subtype='column']">
                            <tr>
                                <td>Spalte</td>
                                <td>Note</td>
                            </tr>
                        </xsl:when>
                    </xsl:choose>
                    <xsl:for-each select="document(//TEI:note[@type='txt']/@target)//TEI:app">
                        <tr>
                            <td>
                                <xsl:value-of select="preceding::TEI:pb[@type='text'][1]/@n"/>
                                &#x2003;
                            </td>
                            <td>
                                <xsl:apply-templates select="TEI:lem"/>
                                <xsl:text>] </xsl:text>
                                <xsl:if test="TEI:lem/@wit!='A'">
                                    <i>
                                        <xsl:value-of select="TEI:lem/@wit"/>
                                        <xsl:text>, </xsl:text>
                                    </i>                                    
                                </xsl:if>
                                <xsl:if test="TEI:rdg[not(@type) and not(child::TEI:g)]">
                                    <xsl:apply-templates select="TEI:rdg"/>
                                </xsl:if>
                                <xsl:if test="TEI:rdg[not(@type) and child::TEI:g]">
                                    <xsl:apply-templates select="TEI:rdg"/>
                                </xsl:if>
                                <xsl:if test="TEI:rdg[@type='add']">
                                    <xsl:apply-templates select="TEI:rdg[@type='add']"/>
                                </xsl:if>
                                <xsl:if test="TEI:note[@type='add']">
                                    <xsl:text> </xsl:text>
                                    <i>
                                        <xsl:apply-templates select="TEI:note[@type='add']"/>
                                    </i>
                                </xsl:if>
                            </td>
                        </tr>
                    </xsl:for-each>
                </table>
            </xsl:when>
            <xsl:when test="@type='textualCriticismSupp'">                
                <div class="txtCrit"><xsl:text>Der er ikke foretaget tekstrettelser, men følgende kritiske forhold er identificeret i teksten </xsl:text> (<a href="http://www.xn--grundtvigsvrker-7lb.dk/vejledning/tknoter_vej">se vejledning til de tekstkritiske noter</a>):</div>
                <table class="textualCriticism">
                    <xsl:choose>
                        <xsl:when test="document(//TEI:note[@type='txt']/@target)//TEI:pb[@type='text' and not(@subtype)]">
                            <tr>
                                <td>Side</td>
                                <td>Note</td>
                            </tr>
                        </xsl:when>
                        <xsl:when test="document(//TEI:note[@type='txt']/@target)//TEI:pb[@type='text' and @subtype='column']">
                            <tr>
                                <td>Spalte</td>
                                <td>Note</td>
                            </tr>
                        </xsl:when>
                    </xsl:choose>
                    <xsl:for-each select="document(//TEI:note[@type='txt']/@target)//TEI:app">
                        <tr>
                            <td>
                                <xsl:value-of select="preceding::TEI:pb[@type='text'][1]/@n"/>
                                &#x2003;
                            </td>
                            <td>
                                <xsl:apply-templates select="TEI:lem"/>
                                <xsl:text>] </xsl:text>
                                <xsl:if test="TEI:lem/@wit!='A'">
                                    <i>
                                        <xsl:value-of select="TEI:lem/@wit"/>
                                        <xsl:text>, </xsl:text>
                                    </i>                                    
                                </xsl:if>
                                <xsl:if test="TEI:rdg[not(@type) and not(child::TEI:g)]">
                                    <xsl:apply-templates select="TEI:rdg"/>
                                </xsl:if>
                                <xsl:if test="TEI:rdg[not(@type) and child::TEI:g]">
                                    <xsl:apply-templates select="TEI:rdg"/>
                                </xsl:if>
                                <xsl:if test="TEI:rdg[@type='add']">
                                    <xsl:apply-templates select="TEI:rdg[@type='add']"/>
                                </xsl:if>
                                <xsl:if test="TEI:note[@type='add']">
                                    <xsl:text> </xsl:text>
                                    <i>
                                        <xsl:apply-templates select="TEI:note[@type='add']"/>
                                    </i>
                                </xsl:if>
                            </td>
                        </tr>
                    </xsl:for-each>
                </table>
            </xsl:when>
            <xsl:when test="@type='textualCriticismZero'">
                <div class="firstIndent">
                    <xsl:text>Der er ikke foretaget tekstrettelser.</xsl:text>
                </div>
            </xsl:when>
        </xsl:choose>
    </xsl:template>
    
    <xsl:template match="TEI:g">
        <span class="rotate">
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    
    <xsl:template match="TEI:note[@type='sic']">
            <xsl:apply-templates/>
            <xsl:text>[sic]</xsl:text>
    </xsl:template>
    
    <xsl:template match="TEI:note[@type='supp']">
        <span class="supp">
            <xsl:text>[</xsl:text>
            <xsl:apply-templates/>
            <xsl:text>]</xsl:text>
        </span>
    </xsl:template>
    
    <xsl:template match="TEI:note[@type='readMore']"/>    
    
    <xsl:template match="TEI:p[@rend]">
        <div class="{@rend}">
            <xsl:apply-templates/>
            <xsl:if test="following-sibling::*[local-name()='note' and @type='readMore' and position()=1]">
                <span class="app">
                    <xsl:text> </xsl:text>
                    <!--  onclick="showhide(this,'more{generate-id()}')" slette af span for at undgå dob.klik på readMore-->
                    <span class="plus">Læs mere</span>
                    <div id="more{generate-id()}" class="appInvisible">
                        <div class="readMore">
                            <xsl:apply-templates select="following-sibling::TEI:note[local-name()='note' and @type='readMore' and position()=1]/node()"/>
                        </div>
                    </div>
                </span>
            </xsl:if>
        </div>
    </xsl:template>
    
    <xsl:template match="TEI:table[@rend]">
        <xsl:choose>
            <xsl:when test="@rend">
                <table class="{@rend}">
                    <xsl:apply-templates/>
                </table>
            </xsl:when>
        </xsl:choose>
    </xsl:template>
    
    <xsl:template match="TEI:row">
        <xsl:choose>
            <xsl:when test="..//parent::TEI:table[@rend='contentDesc']">
                <tr class="contentDesc">
                    <xsl:apply-templates/>
                </tr>
            </xsl:when>
            <xsl:when test="..//parent::TEI:table[@rend='msDesc']">
                <tr class="msDesc">
                    <xsl:apply-templates/>
                </tr>
            </xsl:when>
            <xsl:when test="..//parent::TEI:table[@rend='printDesc']">
                <tr class="printDesc">
                    <xsl:apply-templates/>
                </tr>
            </xsl:when>
            <xsl:when test="..//parent::TEI:table[@rend='textualCriticism']">
                <tr class="textualCriticism">
                    <xsl:apply-templates/>
                </tr>
            </xsl:when>
            <xsl:otherwise>
                <tr class="tr">
                    <xsl:apply-templates/>
                </tr>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    <xsl:template match="TEI:cell">
        <xsl:choose>
            <xsl:when test="..//ancestor::TEI:table[@rend='printDesc']">
                <td class="printDesc">
                    <xsl:apply-templates/>
                </td>
            </xsl:when>
            <xsl:when test="..//ancestor::TEI:table[@rend='msDesc']">
                <td class="msDesc">
                    <xsl:apply-templates/>
                </td>
            </xsl:when>
            <xsl:when test="..//ancestor::TEI:table[@rend='contentDesc']">
                <td class="contentDesc">
                    <xsl:apply-templates/>
                </td>
            </xsl:when>
            <xsl:when test="..//ancestor::TEI:table[@rend='textualCriticism']">
                <td class="textualCriticism">
                    <xsl:apply-templates/>
                </td>
            </xsl:when>
            <xsl:otherwise>
                <td class="td">
                    <xsl:apply-templates/>
                </td>
            </xsl:otherwise>
        </xsl:choose>        
    </xsl:template>
    
    <xsl:template match="TEI:persName">
        <a class="persName" href="ajax/getReference/{@key}" rel="ajax/getReference/{@key}">
            <xsl:apply-templates/>
        </a>
    </xsl:template>
    
    <xsl:template match="TEI:placeName">
        <a class="placeName" href="ajax/getReference/{@key}" rel="ajax/getReference/{@key}">
            <xsl:apply-templates/>
        </a>
    </xsl:template>
    
    <xsl:template match="TEI:rs[@type='bible']">
        <a class="rs_bible" href="ajax/getReference/{@key}" rel="ajax/getReference/{@key}">
            <xsl:apply-templates/>
        </a>
    </xsl:template>
    
    <xsl:template match="TEI:rs[@type='myth']">
        <a class="myth rs_myth" href="ajax/getReference/{@key}" rel="ajax/getReference/{@key}">
            <xsl:apply-templates/>
        </a>
    </xsl:template>
    
    <!--
    <xsl:template match="TEI:rs[@type='title']">
        <a class="rs_title" href="ajax/getReference/{@key}" rel="ajax/getReference/{@key}">
            <xsl:apply-templates/>
        </a>
    </xsl:template>
    -->
    
</xsl:stylesheet>
