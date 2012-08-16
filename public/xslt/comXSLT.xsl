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
                <!--
                <div class="title">
                    <xsl:apply-templates select="TEI:teiHeader/TEI:title[@key]"/>
                    <br/>
                    <xsl:apply-templates select="TEI:teiHeader/TEI:title[@ref]"/>
                </div>
                -->
                
            <div class="head about">
                <xsl:if test="TEI:teiHeader/TEI:fileDesc/TEI:titleStmt/TEI:title[@rend='main']">
                    Punktkommentarer til 
                    <i>
                        <xsl:apply-templates select="TEI:teiHeader/TEI:fileDesc/TEI:titleStmt/TEI:title[@rend='main']"/>
                    </i>
                </xsl:if>                    
                <xsl:if test="TEI:teiHeader/TEI:fileDesc/TEI:titleStmt/TEI:title[@rend='part']">
                    Punktkommentarer til &#x201C;<xsl:apply-templates select="TEI:teiHeader/TEI:fileDesc/TEI:titleStmt/TEI:title[@rend='main']"/>&#x201D;
                </xsl:if>
            </div>
                
            <div class="about">
                Forfatter:
                <br/>
                <xsl:apply-templates select="TEI:teiHeader/TEI:fileDesc/TEI:titleStmt/TEI:author"/>
                <br/>
                Redaktion:
                <br/>
                <xsl:apply-templates select="TEI:teiHeader/TEI:fileDesc/TEI:titleStmt/TEI:editor"/>
            </div>
                <!--
                <div class="filename">
                    filnavn: <xsl:value-of select="TEI:teiHeader/TEI:title[@key]/@key"/>
                </div>
                -->
            <xsl:apply-templates select="TEI:text"/>
        </div>
        
    </xsl:template>
    
    <xsl:template match="TEI:ref[@type='web']">
        <span class="web">
            <xsl:text>&lt;</xsl:text><a href="http://{.}" target="_blank"><xsl:apply-templates/></a><xsl:text>&gt;</xsl:text>
        </span>
    </xsl:template>
    
    <xsl:template match="TEI:ref[@select or @target]">
        <span class="web"><a href="{@target}" target="_blank"><xsl:apply-templates/></a>
        </span>
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
    
    <xsl:template match="TEI:note[@type='readMore']">        
        <div class="readMore">
            <i>readMore:</i>
            <xsl:apply-templates/>
        </div>
    </xsl:template>
    
    <xsl:template match="TEI:note[@type='readMore']/p">        
        <div class="readMoreP">
            <i>readMore:</i>
            <xsl:apply-templates/>
        </div>
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
    
    
    <xsl:template match="TEI:note[@xml:id]">
        <xsl:apply-templates select="TEI:p"/>
    </xsl:template>

    
    <xsl:template match="TEI:note[@xml:id]/TEI:p">
        <div class="note commentNote" id="{../@xml:id}">
            <div class="p">
                <xsl:apply-templates/>
                <xsl:choose>
                    <xsl:when test="following-sibling::*[local-name()='note' and @type='readMore' and position()=1]">
                        <span class="app">
                            <span id="plus{../@xml:id}" class="plusComment"> Læs mere -</span>
                            <div id="more{../@xml:id}" class="appInvisible">
                                <xsl:apply-templates select="following-sibling::TEI:note[@type='readMore']"/>
                            </div>
                        </span>
                    </xsl:when>
                </xsl:choose>
            </div>
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
        <!--otherwise stop-->
    </xsl:template>
    
    <xsl:template match="TEI:p">        
        <div class="p">
            <xsl:apply-templates/>
        </div>
    </xsl:template>
    
    
    
    <xsl:template match="TEI:head">
        <div class="head">
            <xsl:apply-templates/>
        </div>
    </xsl:template>
    
    <xsl:template match="TEI:div[@type='litList' or @type='webList']">
        <div class="litList">
            <xsl:apply-templates/>
            <xsl:text>.</xsl:text>
        </div>
    </xsl:template>
    
    <xsl:template match="TEI:list[@type='ordered']">
        <ul class="ul">
            <xsl:apply-templates/>
        </ul>        
    </xsl:template>
    
    <xsl:template match="TEI:item[not(@n)]">
        <li class="liOrdered">
            <xsl:apply-templates/>
            <xsl:text>.</xsl:text>
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