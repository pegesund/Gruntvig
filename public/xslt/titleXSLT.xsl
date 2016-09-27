<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet 
    xmlns:TEI="http://www.tei-c.org/ns/1.0" 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    version="1.0">
    
    <!-- 
        KSR: 2016.03.17: til redaktion af basen
        KK, KSR: 2016.03.30: til netversionen
    -->
    
    <xsl:template match="TEI:TEI">
        <div>
            <xsl:apply-templates select="//TEI:row"/>
        </div>
    </xsl:template>
    
    <xsl:template match="TEI:row">
        <div class="refdiv title_rs" id="{@xml:id}">
            <div class="row">
                <xsl:apply-templates/>
            </div>
        </div>
    </xsl:template>
    
    <xsl:template name="listAuthor">
        <xsl:param name="type"/>
        <xsl:choose>
            <xsl:when test="not(preceding-sibling::TEI:cell[@type=$type]) and count(child::TEI:note)=2">
                <xsl:value-of select="TEI:note[@type='lastName']"/>
                <xsl:text>, </xsl:text>
                <xsl:apply-templates select="TEI:note[@type='firstName']"/>
            </xsl:when>            
            <xsl:when test="not(preceding-sibling::TEI:cell[@type=$type]) and count(child::TEI:note)=1">
                <xsl:apply-templates select="TEI:note[@type='firstName']"/>
            </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="TEI:note[@type='firstName']"/>
                    <xsl:text> </xsl:text>
                    <xsl:apply-templates select="TEI:note[@type='lastName']"/>
                </xsl:otherwise>
            </xsl:choose>
            <xsl:choose>
                <xsl:when test="count(following-sibling::TEI:cell[@type=$type])=1">
                    <xsl:text> &amp; </xsl:text>
                </xsl:when>
                <xsl:when test="not(following-sibling::TEI:cell[@type=$type])"/>
                <xsl:otherwise>
                    <xsl:text>, </xsl:text>
                </xsl:otherwise>
            </xsl:choose>
    </xsl:template>
    
    <xsl:template match="TEI:cell[@type='editor']">
        <xsl:text>udg. </xsl:text>
        <span class="editor">            
            <xsl:call-template name="listAuthor">
                <xsl:with-param name="type" select="'editor'"/>
            </xsl:call-template>
        </span>
    </xsl:template>
    
    <xsl:template match="TEI:cell[@type='editorOnly']">
        <span class="editor">
            <xsl:call-template name="listAuthor">
                <xsl:with-param name="type" select="'editorOnly'"/>
            </xsl:call-template>
        </span>
    </xsl:template>
    
    <xsl:template match="TEI:cell[@type='mainAuthor' and not(@rend='anon')]">
        <span class="mainAuthor">
            <xsl:call-template name="listAuthor">
                <xsl:with-param name="type" select="'mainAuthor'"/>
            </xsl:call-template>
        </span>
    </xsl:template>
    
    <xsl:template match="TEI:cell[@type='mainAuthor' and @rend='anon']">
        <span class="mainAuthor">
            <xsl:text>[</xsl:text>
            <xsl:call-template name="listAuthor">
                <xsl:with-param name="type" select="'mainAuthor'"/>
            </xsl:call-template>
            <xsl:text>]</xsl:text>
        </span>
    </xsl:template>
    
    <xsl:template match="TEI:cell[@type='translator']">
        <xsl:text>overs. </xsl:text>
        <span class="translator">            
            <xsl:call-template name="listAuthor">
                <xsl:with-param name="type" select="'translator'"/>
            </xsl:call-template>
        </span>
    </xsl:template>
    
    <xsl:template match="TEI:cell[@type='translatorOnly']">
        <span class="translatorOnly">
            <xsl:call-template name="listAuthor">
                <xsl:with-param name="type" select="'translatorOnly'"/>
            </xsl:call-template>
        </span>
    </xsl:template>
    
    <xsl:template match="TEI:cell[@type='coAuthor']">
        <span class="coAuthor">
            <xsl:text>[coAuthor: </xsl:text>
            <xsl:call-template name="listAuthor">
                <xsl:with-param name="type" select="'coAuthor'"/>
            </xsl:call-template>
            <xsl:text>]</xsl:text>
        </span>
    </xsl:template>
    
    <xsl:template match="TEI:cell[@type='mainTitle']">
        <span class="mainTitle">
            <i><xsl:apply-templates/></i>
            <xsl:call-template name="delimiterPunktum"/>
        </span>
    </xsl:template>
    
    <xsl:template match="TEI:cell[@type='partTitle']">
        <span class="partTitle">
            <xsl:text>&#x201C;</xsl:text>
            <xsl:apply-templates/>
            <xsl:text>&#x201D;</xsl:text>
            <xsl:choose>
                <xsl:when test="following-sibling::TEI:cell[@type='firstLine']">
                    <xsl:text> [første linje: </xsl:text>
                    <xsl:value-of select="//TEI:cell[@type='firstLine']"/>
                    <xsl:text>]</xsl:text>
                </xsl:when>
            </xsl:choose>
            <xsl:text> i </xsl:text>
            <span class="mainTitle">
                <xsl:value-of select="//TEI:row[@xml:id=current()/@key]//TEI:cell[@type='mainTitle' or @type='partTitle']"/>
                <xsl:call-template name="delimiterPunktum"/>
            </span>
        </span>
    </xsl:template>
    
    <xsl:template match="TEI:cell[@type='volume']">
        <span>
            <xsl:text>bind </xsl:text>
            <xsl:apply-templates/>
            <xsl:text>:</xsl:text>
        </span>
    </xsl:template>
    
    <xsl:template match="TEI:cell[@type='pubYear']">
        <span class="pubYear">
            <xsl:text>(</xsl:text>
            <xsl:apply-templates/>
            <xsl:text>)</xsl:text>
        </span>
    </xsl:template>
    
    <xsl:template match="TEI:cell[@type='volumeTitle']">
        <span class="volumeTitle">
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    
    <xsl:template match="TEI:cell[@type='issue']">
        <span>
            <xsl:apply-templates/>
            <xsl:call-template name="delimiterKomma"/>
        </span>
    </xsl:template>
    
    <xsl:template match="TEI:cell[@type='numberOfVolumes']">
        <span>
            <xsl:text>bind </xsl:text>
            <xsl:apply-templates/>
            <xsl:call-template name="delimiterPunktum"/>
        </span>
    </xsl:template>
    
    <xsl:template match="TEI:cell[@type='date']">
        <span>
            <xsl:apply-templates/>
            <xsl:text>, </xsl:text>
        </span>
    </xsl:template>
    
    <xsl:template match="TEI:cell[@type='number']">
        <span>
            <xsl:text>nr. </xsl:text>
            <xsl:apply-templates/>
            <xsl:text>, </xsl:text>
        </span>
    </xsl:template>
    
    <xsl:template match="TEI:cell[@type='pages' and @subtype='column'][position()=1 and position()=last()]">
        <span>
            <xsl:text>sp. </xsl:text>
            <xsl:apply-templates/>
            <xsl:text>.</xsl:text>
        </span>
    </xsl:template>
    
    <xsl:template match="TEI:cell[@type='pages' and @subtype='column'][position()!=last()]">
        <span>
            <xsl:text>sp. </xsl:text>
            <xsl:apply-templates/>
            <xsl:text>; </xsl:text>
        </span>
    </xsl:template>
    
    <xsl:template match="TEI:cell[@type='pages' and @subtype='column'][position()!=1 and position()=last()]">
        <span>
            <xsl:text>sp. </xsl:text>
            <xsl:apply-templates/>
            <xsl:text>.</xsl:text>
        </span>
    </xsl:template>
    
    <xsl:template match="TEI:cell[@type='pages' and not(@subtype)][position()=1 and position()=last()]">
        <span>
            <xsl:text>s. </xsl:text>
            <xsl:apply-templates/>
            <xsl:text>.</xsl:text>
        </span>
    </xsl:template>
    
    <xsl:template match="TEI:cell[@type='pages' and not(@subtype)][position()!=last()]">
        <span>
            <xsl:text>s. </xsl:text>
            <xsl:apply-templates/>
            <xsl:text>; </xsl:text>
        </span>
    </xsl:template>
    
    <xsl:template match="TEI:cell[@type='pages' and not(@subtype)][position()!=1 and position()=last()]">
        <span>
            <xsl:text>s. </xsl:text>
            <xsl:apply-templates/>
            <xsl:text>.</xsl:text>
        </span>
    </xsl:template>
    
    <xsl:template match="TEI:cell[@type='pubPlace']">
        <span class="pubPlace">
            <xsl:apply-templates/>
            <xsl:text>.</xsl:text>
        </span>
    </xsl:template>
    
    <xsl:template match="TEI:cell[@type='firstEdition']">
        <span class="firstEdition">
            <xsl:text>[</xsl:text>
            <xsl:apply-templates/>
            <xsl:text>].</xsl:text>
        </span>
    </xsl:template>
    
    <xsl:template name="delimiterKomma">
        <xsl:if test="following-sibling::TEI:cell">
            <xsl:text>,</xsl:text>
        </xsl:if>
    </xsl:template>
    
    <xsl:template name="delimiterPunktum">
        <xsl:if test="following-sibling::TEI:cell">
            <xsl:text>.</xsl:text>
        </xsl:if>
    </xsl:template>
    
    <xsl:template match="TEI:cell[@type='shelf' or @type='box' or @type='owner' or @type='fax' or @type='shortForm' or @type='provenance' or @type='translatedTitle' or @type='condition' or @type='firstLine']"/>
    
</xsl:stylesheet>