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

<!-- 
    Kim Steen Ravn:
    2011.10.12: rend att på title i teiHeader
    2011.06.27: sic and supp in note element 
    2012.06.20: templates til <l> og <lg>
-->
    <xsl:include href="popups.xsl"/>

    <xsl:template match="TEI:TEI">
        
        <div class="theComments">
                
            <div class="head about">
                <div>Punktkommentarer til</div>
                <xsl:choose>
                    <xsl:when test="TEI:teiHeader/TEI:fileDesc/TEI:titleStmt/TEI:title[@rend='main' and @type='supp']">
                        [<i>
                            <xsl:apply-templates select="TEI:teiHeader/TEI:fileDesc/TEI:titleStmt/TEI:title[@rend='main' and @type='supp']"/>
                        </i>]
                    </xsl:when>
                </xsl:choose>
                <xsl:choose>
                    <xsl:when test="TEI:teiHeader/TEI:fileDesc/TEI:titleStmt/TEI:title[@rend='main' and not(@type='supp')]">
                        <i>
                            <xsl:apply-templates select="TEI:teiHeader/TEI:fileDesc/TEI:titleStmt/TEI:title[@rend='main' and @type='supp']"/>
                        </i>
                    </xsl:when>
                </xsl:choose>
                <xsl:choose>
                    <xsl:when test="TEI:teiHeader/TEI:fileDesc/TEI:titleStmt/TEI:title[@rend='part' and @type='supp']">
                        [&#x201C;<xsl:apply-templates select="TEI:teiHeader/TEI:fileDesc/TEI:titleStmt/TEI:title[@rend='part' and @type='supp']"/>&#x201D;]
                    </xsl:when>
                </xsl:choose>
                <div class="author">
                    <xsl:text>ved </xsl:text>
                    <xsl:for-each select="//TEI:author">
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
            </div>
            <xsl:choose>
                 <xsl:when test="//TEI:note[@type='noCom']">
                     <div class="head about">
                        <xsl:text>er under udarbejdelse</xsl:text>
                    </div>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:apply-templates select="TEI:text"/>
                </xsl:otherwise>
            </xsl:choose>
        </div>
        
    </xsl:template>
    
    <!--
    <xsl:template match="TEI:ref[@select or @target]">
        <span class="web">
            <a href="{@target}" target="_blank">
                <xsl:apply-templates/>
            </a>
        </span>
    </xsl:template>
    -->
    
    <xsl:template match="TEI:ref[@type]">
            <xsl:choose>              
                <xsl:when test="@type='docIn'">
                    <!--<a hrel="{@id}" class="docIn txrmenu">-->
                       <xsl:apply-templates/>
                    <!--</a>-->
                </xsl:when>                
                <xsl:when test="@type='docOut'">
                    <!--<a hrel="{@target}" class="docOut txrmenu">-->
                       <xsl:apply-templates/>
                    <!--</a>-->
                </xsl:when>
                <xsl:when test="@type='image'">
                    <!--<a href="{@target}">-->
                        <xsl:apply-templates/>
                    <!--</a>-->
                </xsl:when>
                <xsl:when test="@type='web'">
                    <xsl:text>&lt;</xsl:text>
                    <a href="http://{.}" target="_blank">
                        <xsl:apply-templates/>
                    </a>
                    <xsl:text>&gt;</xsl:text>
                </xsl:when>
            </xsl:choose>   
    </xsl:template>
    
    <xsl:template match="TEI:editor">
        <div>
            <xsl:apply-templates/>
        </div>
    </xsl:template>
    
    <xsl:template match="TEI:l">
        <div>
            <xsl:apply-templates/>
        </div>
    </xsl:template>
    
    <xsl:template match="TEI:lg">
        <div>
            <xsl:apply-templates/>
        </div>
    </xsl:template>
    
    <xsl:template match="TEI:hi">        
        <span class="{@rend}">
            <xsl:apply-templates/>
        </span>
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
    
    <xsl:template match="TEI:p">        
        <div class="p">
            <xsl:apply-templates/>
        </div>
    </xsl:template>

   <xsl:template match="TEI:note[@xml:id]">
       <div class="note" id="{@xml:id}">
           <xsl:apply-templates select="TEI:p"/>
       </div>
   </xsl:template>
   
   <xsl:template match="TEI:note[@xml:id]/TEI:p">
       <div class="p">
           <xsl:apply-templates/>
           <xsl:choose>
               <xsl:when test="following-sibling::*[local-name()='note' and @type='readMore' and position()=1]">
                   <span class="app">
                       <span id="plus{../@xml:id}" class="plus" onclick="showhide(this,'more{../@xml:id}')"> Læs mere +</span>
                       <div id="more{../@xml:id}" class="appInvisible">
                           <xsl:apply-templates select="following-sibling::TEI:note[@type='readMore']"/>
                       </div>
                   </span>
               </xsl:when>
           </xsl:choose>
       </div>
   </xsl:template>
   
   <xsl:template name="next-lemma-part">
        <xsl:param name="n"/>
        <xsl:param name="node"/>
        <xsl:param name="i"/>
        <xsl:if test="name($node[$i]) != 'seg' or $node[$i]/@type != 'comEnd' or $node[$i]/@n != $n">
            <xsl:if test="not(name($node[$i]))"> <!--text or comment node-->
                <xsl:apply-templates select="$node[$i]" mode="in-lemma"/>
            </xsl:if>
            <xsl:call-template name="next-lemma-part">
                <xsl:with-param name="n" select="$n"/>
                <xsl:with-param name="node" select="$node"/>
                <xsl:with-param name="i" select="$i+1"/>
            </xsl:call-template>
        </xsl:if>
    </xsl:template>
    
    <xsl:template match="TEI:head">
        <div class="head">
            <xsl:apply-templates/>
        </div>
    </xsl:template>
    
    <!--
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
    
    
    <xsl:template match="TEI:rs[@type='title']">
        <a class="rs_title" href="ajax/getReference/{@key}" rel="ajax/getReference/{@key}">
            <xsl:apply-templates/>
        </a>
    </xsl:template>
    -->
    
    <xsl:template match="TEI:div[@type='litList' or @type='webList']">
        <div class="litList">
            <xsl:choose>
                <xsl:when test="@type='litList'">
                    <xsl:apply-templates/>
                </xsl:when>
                <xsl:when test="@type='webList'">
                    <xsl:apply-templates/>
                </xsl:when>
            </xsl:choose>
        </div>
    </xsl:template>
    
    <xsl:template match="TEI:list">
        <ul class="ul">
            <xsl:apply-templates/>
        </ul>        
    </xsl:template>
    
    <xsl:template match="TEI:item[not(@n)]">
        <li class="webList">
            <xsl:apply-templates/>
        </li>
    </xsl:template>
    
    <xsl:template match="TEI:item[@n]">
        <li class="liOrdered">
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
            <xsl:text>).</xsl:text>
        </li>
    </xsl:template>
    
</xsl:stylesheet>
