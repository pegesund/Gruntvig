<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet 
    xmlns:TEI="http://www.tei-c.org/ns/1.0" 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    version="1.0">

<!-- 
    Kim Steen Ravn:
    2011.10.12: rend att på title i teiHeader
    2011.06.27: sic and supp in note element 
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
                
                <div class="head">
                    <xsl:if test="TEI:teiHeader/TEI:fileDesc/TEI:titleStmt/TEI:title[@rend='main']">
                        Punktkommentarer til <i><xsl:apply-templates select="TEI:teiHeader/TEI:fileDesc/TEI:titleStmt/TEI:title[@rend='main']"/></i>
                    </xsl:if>                    
                    <xsl:if test="TEI:teiHeader/TEI:fileDesc/TEI:titleStmt/TEI:title[@rend='part']">
                        Punktkommentarer til &#x201C;<xsl:apply-templates select="TEI:teiHeader/TEI:fileDesc/TEI:titleStmt/TEI:title[@rend='part']"/>&#x201D;
                    </xsl:if>
                </div>
                
                <div>
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
    
    <xsl:template match="TEI:editor">
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
        <div class="note">
            <xsl:attribute name="id">
                <xsl:value-of select="@xml:id"/>
            </xsl:attribute>
            <b>
                <xsl:value-of select="@xml:id"/>:
            </b>
            <br/>
            <xsl:variable name="id" select="@xml:id"/>
            <b>
                <xsl:text>lemma: </xsl:text>
            </b>
            <br/>
            <!-- value-of giver første lemma -->
            <xsl:for-each select="document(/TEI:TEI/TEI:teiHeader/TEI:fileDesc/TEI:titleStmt/TEI:title/@key)//TEI:seg[@type='com' and @n=$id]">
                <xsl:apply-templates select="."/>
                <xsl:text> &#x25AA; </xsl:text>
            </xsl:for-each>
            <xsl:if test="document(/TEI:TEI/TEI:teiHeader/TEI:fileDesc/TEI:titleStmt/TEI:title/@key)//TEI:seg[@type='comStart' and @n=$id] and document(/TEI:TEI/TEI:teiHeader/TEI:fileDesc/TEI:titleStmt/TEI:title/@key)//TEI:seg[@type='comEnd' and @n=$id]">
            <xsl:call-template name="next-lemma-part">
                <xsl:with-param name="n" select="$id"/>
                <xsl:with-param name="node" select="document(/TEI:TEI/TEI:teiHeader/TEI:fileDesc/TEI:titleStmt/TEI:title/@key)//TEI:seg[@type='comStart' and @n=$id]/following::node()"/>
                <xsl:with-param name="i" select="1"/>
            </xsl:call-template>
            </xsl:if>
            <br/>
            <b>
                <xsl:text>kommentar: </xsl:text>
            </b>
            <xsl:apply-templates/>
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
    
    <xsl:template match="TEI:div[@type='litList']">
        <div class="litList">
            <xsl:apply-templates/>
        </div>
    </xsl:template>
    
    <xsl:template match="TEI:div[@type='webSite']">
        <div class="litList">
            <xsl:apply-templates/>
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
        </li>
    </xsl:template>
    
    <xsl:template match="TEI:item[@n]">
        <li class="liOrdered">
            <a href="{.}">                
                <xsl:apply-templates/>                
            </a>
            <xsl:text> [</xsl:text>
            <xsl:value-of select="substring(@n, 9,2)"/>
            <xsl:text>.</xsl:text>
            <xsl:value-of select="substring(@n, 6,2)"/>
            <xsl:text>.</xsl:text>
            <xsl:value-of select="substring(@n, 1,4)"/>
                <xsl:text>]</xsl:text>
        </li>
    </xsl:template>
    
    
</xsl:stylesheet>