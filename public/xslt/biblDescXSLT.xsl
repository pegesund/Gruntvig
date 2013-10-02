<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE stylesheet [
<!ENTITY month "          januar    februar   marts     april     maj       juni      juli      august    september oktober   november  december">
]>

<xsl:stylesheet 
    xmlns:TEI="http://www.tei-c.org/ns/1.0" 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    version="1.0">
    
    <!-- 
        Kim Steen Ravn for GV
    -->
    
    <xsl:template match="TEI:TEI">
        
                <div class="head">
                    <xsl:if test="TEI:teiHeader/TEI:fileDesc/TEI:titleStmt/TEI:title[@rend='main']">
                        <div><xsl:text>Tekstredegørelse til</xsl:text></div>
                        <i><xsl:apply-templates select="TEI:teiHeader/TEI:fileDesc/TEI:titleStmt/TEI:title[@rend='main']"/></i>
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
                    <xsl:if test="TEI:teiHeader/TEI:fileDesc/TEI:titleStmt/TEI:title[@rend='part']">
                        <div><xsl:text>Tekstredegørelse til</xsl:text></div>
                        &#x201C;<xsl:apply-templates select="TEI:teiHeader/TEI:fileDesc/TEI:titleStmt/TEI:title[@rend='part']"/>&#x201D;
                        <div class="author"><xsl:text>ved </xsl:text>
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
                    <xsl:when test="//TEI:note[@type='biblDesc']">
                        <div class="content">
                            <xsl:text>Indhold</xsl:text>
                        </div>
                        <xsl:apply-templates mode="toc" select="TEI:text/TEI:body/TEI:div"/>
                        <xsl:apply-templates select="TEI:text"/>
                    </xsl:when>
                </xsl:choose>

    </xsl:template>
    
    <xsl:template name="delimiterComma">
        <xsl:text>, </xsl:text>
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
    
    <xsl:template match="TEI:head">
        <a>
            <xsl:attribute name="id">
                <xsl:text>A</xsl:text>
                <xsl:number level="multiple" count="TEI:div"/>
            </xsl:attribute>
        </a>
        <div class="head{@rend}">
            <a href="{@name}" class="toc" id="{@xml:id}">
                <xsl:number level="multiple" count="TEI:div"/>
                <xsl:text> </xsl:text>
                <xsl:apply-templates/>
            </a>
        </div>
    </xsl:template>
    <!--
    <xsl:template match="TEI:teiHeader/TEI:fileDesc/TEI:titleStmt/TEI:editor[@role='editor']">        
        <span class="editor">
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    -->
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
    
    <xsl:template match="TEI:ref[@type='web']">
        <span class="web">
            <a href="{@target}">
                <xsl:apply-templates/>
            </a>
        </span>
    </xsl:template>
    
    <xsl:template match="TEI:ref[@type='image']">
        <span class="web">
            <a href="{@target}" target="_blank">
                <xsl:apply-templates/>
            </a>
        </span>
    </xsl:template>
    
    <xsl:template match="TEI:ref[@type='docIn']">
        <span>
            <a href="{@target}">
                <xsl:apply-templates/>
            </a>
        </span>
    </xsl:template>

    <xsl:template match="TEI:lg|TEI:l">
        <div class="{name()}">
            <!--xsl:attribute name="class"><xsl:value-of select="name()"/></xsl:attribute-->
            <xsl:apply-templates/>
        </div>
    </xsl:template>
    
    <xsl:template match="TEI:list">
        <xsl:if test="@type='decimal'">
            <ul>
                <xsl:for-each select="TEI:item">
                    <li class="decimal">
                        <xsl:apply-templates/>
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
        <xsl:if test="@type='simple' or @type='subSimple'">
            <ul>
                <xsl:for-each select="TEI:item">
                    <li class="simple">
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
                <a href="{@target}">
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
    
    <xsl:template match="TEI:table[@rend]">
        <xsl:choose>
            <xsl:when test="not(rend)">
                <table>
                    <xsl:apply-templates/>
                </table>
            </xsl:when>
            <xsl:when test="@rend">
                <table class="{@rnd}">
                    <xsl:apply-templates/>
                </table>
            </xsl:when>
        </xsl:choose>
    </xsl:template>
    
    <xsl:template match="TEI:row">        
        <tr class="tr">
            <xsl:apply-templates/>
        </tr>
    </xsl:template>
    
    <xsl:template match="TEI:cell">        
        <td class="td">
            <xsl:apply-templates/>
        </td>
    </xsl:template>
    
    <!-- til brugs for txtEditCSS-css START -->
    
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
    
    <!-- til brugs for txtEditCSS-css END -->
    
    
</xsl:stylesheet>