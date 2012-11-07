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
-->

    <xsl:template match="TEI:TEI">
        
        <div class="mainTxr">
            <div class="head">
                <xsl:if test="TEI:teiHeader/TEI:fileDesc/TEI:titleStmt/TEI:title[@rend='main']">
                    <div>
                        <xsl:text>Tekstredegørelse til</xsl:text>
                    </div>
                    <i>
                        <xsl:apply-templates select="TEI:teiHeader/TEI:fileDesc/TEI:titleStmt/TEI:title[@rend='main']"/>
                    </i>                    
                    <div class="author">
                            <xsl:text>ved </xsl:text>
                            <xsl:for-each select="TEI:teiHeader/TEI:fileDesc/TEI:titleStmt/TEI:author">
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
                <xsl:if test="TEI:teiHeader/TEI:fileDesc/TEI:titleStmt/TEI:title[@rend='part']">
                    <div>
                        <xsl:text>Tekstredegørelse til</xsl:text>
                    </div>
                        &#x201C;<xsl:apply-templates select="TEI:teiHeader/TEI:fileDesc/TEI:titleStmt/TEI:title[@rend='part']"/>&#x201D;                        
                    <div class="author">
                            <xsl:text>ved </xsl:text>
                            <xsl:for-each select="TEI:teiHeader/TEI:fileDesc/TEI:titleStmt/TEI:author">
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
                        <xsl:text>Indhold</xsl:text>
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
                    <xsl:text>A</xsl:text>
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
        <a class="toc txrmenu">
            <xsl:attribute name="id">
                <xsl:text>A</xsl:text>
                <xsl:number level="multiple" count="TEI:div"/>
            </xsl:attribute>
        </a>
        <div class="head{@rend}" id="{@xml:id}">
            <a hrel="#retur" class="toc txrmenu">
                <xsl:number level="multiple" count="TEI:div"/>
                <xsl:text> </xsl:text>
                <xsl:apply-templates/>
            </a>
        </div>
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
    <xsl:template match="TEI:ref[@type]">
            <xsl:choose>
                <xsl:when test="@type='web'">
                    <xsl:text>&lt;</xsl:text>
                    <a href="#http://{.}">
                        <xsl:apply-templates/>
                    </a>
                    <xsl:text>&gt;</xsl:text>
                </xsl:when>
                <xsl:when test="@type='image'">
                    <!--<a href="{@target}">-->
                        <xsl:apply-templates/>
                    <!--</a>-->
                </xsl:when>
                <xsl:when test="@select">                    
                    <a href="#http://{.}">
                        <xsl:apply-templates/>
                    </a>
                </xsl:when>                
                <xsl:when test="@type='docIn'">
                    <!--<a hrel="{@target}" class="docIn txrmenu">-->
                       <xsl:apply-templates/>
                    <!--</a>-->
                </xsl:when>                
                <xsl:when test="@type='docOut'">
                    <!--<a hrel="{@target}" class="docOut txrmenu">-->
                       <xsl:apply-templates/>
                    <!--</a>-->
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
            <ul>
                <xsl:for-each select="TEI:item">
                    <li class="decimal">
                        <xsl:apply-templates/>
                        <xsl:text>.</xsl:text>
                    </li>                
                </xsl:for-each>
            </ul>
        </xsl:if>
        <xsl:if test="@type='upperAlpha'">
            <ul>
                <xsl:for-each select="TEI:item">
                    <li class="upperAlpha">
                        <xsl:apply-templates/>
                    </li>                
                </xsl:for-each>
            </ul>
        </xsl:if>
        <xsl:if test="@type='lowerAlpha'">
            <ul>
                <xsl:for-each select="TEI:item">
                    <li class="lowerAlpha">
                        <xsl:apply-templates/>
                    </li>                
                </xsl:for-each>
            </ul>
        </xsl:if>
        <xsl:if test="@type='upperRoman'">
            <ul>
                <xsl:for-each select="TEI:item">
                    <li class="upperRoman">
                        <xsl:apply-templates/>
                    </li>                
                </xsl:for-each>
            </ul>
        </xsl:if>
        <xsl:if test="@type='lowerRoman'">
            <ul>
                <xsl:for-each select="TEI:item">
                    <li class="lowerRoman">
                        <xsl:apply-templates/>
                    </li>                
                </xsl:for-each>
            </ul>
        </xsl:if>
        <xsl:if test="@type='simple'">
            <ul>
                <xsl:for-each select="TEI:item">
                    <li class="simple">
                        <xsl:apply-templates/>
                        <xsl:text>.</xsl:text>
                    </li>                
                </xsl:for-each>
            </ul>
        </xsl:if>
        <xsl:if test="@type='subSimple'">
            <ul>
                <xsl:for-each select="TEI:item">
                    <li class="subSimple">
                        <xsl:apply-templates/>
                    </li>                
                </xsl:for-each>
            </ul>
        </xsl:if>
        <xsl:if test="@type='ordered'">
            <ul>
                <xsl:for-each select="TEI:item">
                    <li class="ordered">
                        <xsl:apply-templates/>
                    </li>
                </xsl:for-each>
            </ul>
        </xsl:if>
        <xsl:if test="@type='addendon' or @type='webList'">
            <div class="litList">
                <xsl:apply-templates/>
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
                <xsl:text>&lt;</xsl:text>
                <a href="{.}">
                    <xsl:apply-templates/>
                </a>
                <xsl:text>&gt;</xsl:text>
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
    
    <xsl:template match="TEI:list[@type='textualCriticismPluralis' or @type='textualCriticismSingularis']">
        <xsl:choose>
            <xsl:when test="@type='textualCriticismPluralis'">                
                <xsl:text>Der er foretaget følgende tekstrettelser (se vejledning til de tekstkritiske noter):</xsl:text>
                <table class="textualCriticism">
                    <tr bgcolor="lightgray">
                        <td>Side</td>
                        <td>Note</td>
                    </tr>
                    <xsl:for-each select="document(//TEI:note[@type='txt']/@target)//TEI:app">
                        <tr>
                            <td align="right">
                                <xsl:value-of select="preceding::TEI:pb[@type='text'][1]/@n"/>
                                &#x2003;
                            </td>
                            <td align="left">
                                <xsl:apply-templates select="TEI:lem"/>
                                <xsl:text>] </xsl:text>
                                <xsl:if test="TEI:lem/@wit!='A'">
                                    <i>
                                        <xsl:value-of select="TEI:lem/@wit"/>
                                        <xsl:text>, </xsl:text>
                                    </i>                                    
                                </xsl:if>
                                <xsl:apply-templates select="TEI:rdg[not(@type)]"/>
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
            <xsl:when test="@type='textualCriticismSingularis'">                
                <xsl:text>Der er foretaget følgende tekstrettelse (se vejledning til de tekstkritiske noter):</xsl:text>
                <table class="textualCriticism">
                    <tr bgcolor="lightgray">
                        <td>Side</td>
                        <td>Note</td>
                    </tr>
                    <xsl:for-each select="document(//TEI:note[@type='txt']/@target)//TEI:app">
                        <tr>
                            <td align="right">
                                <xsl:value-of select="preceding::TEI:pb[@type='text'][1]/@n"/>
                                &#x2003;
                            </td>
                            <td align="left">
                                <xsl:apply-templates select="TEI:lem"/>
                                <xsl:text>] </xsl:text>
                                <xsl:if test="TEI:lem/@wit!='A'">
                                    <i>
                                        <xsl:value-of select="TEI:lem/@wit"/>
                                        <xsl:text>, </xsl:text>
                                    </i>                                    
                                </xsl:if>
                                <xsl:apply-templates select="TEI:rdg[not(@type)]"/>
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
        </xsl:choose>
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
                    <span class="plus" onclick="showhide(this,'more{generate-id()}')">Læs mere +</span>
                    <div id="more{generate-id()}" class="appInvisible">
                        <div class="readMore">
                            <xsl:apply-templates select="following-sibling::TEI:note[local-name()='note' and @type='readMore' and position()=1]/node()"/>
                        </div>
                    </div>
                </span>
            </xsl:if>
        </div>
    </xsl:template>
    
    <xsl:template match="TEI:table">        
        <div class="table">
            <xsl:apply-templates/>
        </div>
    </xsl:template>
    
    <xsl:template match="TEI:row">        
        <div class="tr">
            <xsl:apply-templates/>
        </div>
    </xsl:template>
    
    <xsl:template match="TEI:cell">        
        <span class="td">
            <xsl:apply-templates/>
        </span>
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
