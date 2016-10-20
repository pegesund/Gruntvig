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
    
    <xsl:template match="TEI:cell[@type='coAuthor']">
        <span class="coAuthor">
            <xsl:text>[coAuthor: </xsl:text>
            <xsl:call-template name="listAuthor">
                <xsl:with-param name="type" select="'coAuthor'"/>
            </xsl:call-template>
            <xsl:text>]</xsl:text>
        </span>
    </xsl:template>
    
    <xsl:template match="TEI:cell[@type='editor'][position()=1]">
        <xsl:text>udg. </xsl:text>
        <span class="editor">            
            <xsl:call-template name="listAuthor">
                <xsl:with-param name="type" select="'editor'"/>
            </xsl:call-template>
        </span>
    </xsl:template>
    
    <xsl:template match="TEI:cell[@type='editor'][position()!=1]">
        <span class="editor">            
            <xsl:call-template name="listAuthor">
                <xsl:with-param name="type" select="'editor'"/>
            </xsl:call-template>
        </span>
    </xsl:template>
    
    <xsl:template match="TEI:cell[@type='editor'][position()=last()]">
        <span class="editor">            
            <xsl:call-template name="listAuthor">
                <xsl:with-param name="type" select="'editor'"/>
            </xsl:call-template>
            <xsl:text>.</xsl:text>
        </span>
    </xsl:template>
    
    <xsl:template match="TEI:cell[@type='editorOnly']">
        <span class="editor">
            <xsl:call-template name="listAuthor">
                <xsl:with-param name="type" select="'editorOnly'"/>
            </xsl:call-template>
            <!-- pro START -->
            <xsl:text> udg. </xsl:text>
            <!-- PRO END -->
        </span>
    </xsl:template>
    
    <xsl:template match="TEI:cell[@type='mainAuthor']">
        <span class="mainAuthor">
            <xsl:call-template name="listAuthor">
                <xsl:with-param name="type" select="'mainAuthor'"/>
            </xsl:call-template>
        </span>
    </xsl:template>
    
    <xsl:template match="TEI:cell[@type='translator'][position()=1]">
        <xsl:text>overs. </xsl:text>
        <span class="translator">
            <xsl:call-template name="listAuthor">
                <xsl:with-param name="type" select="'translator'"/>
            </xsl:call-template>
            <xsl:text>.</xsl:text>
        </span>
    </xsl:template>
    
    <xsl:template match="TEI:cell[@type='translator'][position()!=1]">
        <span class="translator">            
            <xsl:call-template name="listAuthor">
                <xsl:with-param name="type" select="'translator'"/>
            </xsl:call-template>
            <xsl:text>.</xsl:text>
        </span>
    </xsl:template>
    
    <xsl:template match="TEI:cell[@type='translatorOnly']">
        <span class="translatorOnly">
            <xsl:call-template name="listAuthor">
                <xsl:with-param name="type" select="'translatorOnly'"/>
            </xsl:call-template>
        </span>
    </xsl:template>
    
    <xsl:template match="TEI:cell[@type='mainTitle']">
        <span class="mainTitle">
            <xsl:apply-templates/>
            <xsl:call-template name="mainTitle"/>
            <xsl:if test="following-sibling::TEI:cell[@type='shortForm'][position()=last()]">
                <xsl:text>.</xsl:text>
            </xsl:if>
        <!-- pro START -->
        </span>
        <!-- pro START -->
        <xsl:if test="@ident">
            <xsl:text> (</xsl:text>
            <xsl:value-of select="@ident"/>
            <xsl:text>)</xsl:text>
        </xsl:if>
        <!-- pro END -->
            <xsl:call-template name="traditionalTitle"/>
        <!-- pro END -->
        <!-- pro START -->
        <xsl:choose>
            <xsl:when test="following-sibling::TEI:cell[@type='firstLine']">
                <xsl:text> [første linje: </xsl:text>
                <xsl:value-of select="//TEI:cell[@type='firstLine']"/>
                <xsl:text>]</xsl:text>
            </xsl:when>
        </xsl:choose>
        <!-- pro END -->
    </xsl:template>
    
    <xsl:template match="TEI:cell[@type='translatedTitle']">
        <span class="translatedTitle">
            <xsl:text>(da. </xsl:text>
            <xsl:apply-templates/>
            <xsl:text>).</xsl:text>
        </span>
    </xsl:template>
    
    <xsl:template match="TEI:cell[@type='manuscript']">
        <span class="manuscript">
            <xsl:apply-templates/>
            <xsl:text>.</xsl:text>
        </span>
    </xsl:template>
    
    <xsl:template name="mainTitle">
        <!-- pro START -->
        <xsl:choose>
            <xsl:when test="following-sibling::TEI:cell[@type='numberOfVolumes' or @type='volume']">
                <xsl:text>, </xsl:text>
            </xsl:when>
            <xsl:when test="following-sibling::TEI:cell[@type='traditionalTitle']">
                <xsl:text> </xsl:text>
            </xsl:when>
            <xsl:when test="following-sibling::TEI:cell[@type='pubPlace']">
                <xsl:text>. </xsl:text>
            </xsl:when>
        </xsl:choose>
        <!-- pro END -->
    </xsl:template>
    
    <xsl:template name="traditionalTitle">
        <xsl:if test="following-sibling::TEI:cell[@type='traditionalTitle']">
            <span style="font-style: normal">
                <xsl:text>(</xsl:text>
                <xsl:value-of select="following-sibling::TEI:cell[@type='traditionalTitle']/@rend"/>
            </span>
            <xsl:text> </xsl:text>
            <xsl:value-of select="following-sibling::TEI:cell[@type='traditionalTitle']"/>
            <span style="font-style: normal">
                <xsl:text>)</xsl:text>
            </span>
            <!-- pro START -->
            <xsl:text>.</xsl:text>
            <!-- pro END -->
        </xsl:if>        
    </xsl:template>
    
    <xsl:template match="TEI:cell[@type='volume']">
        <!-- pro START -->
        <xsl:choose>
            <xsl:when test=" following-sibling::TEI:cell[@type='volumeTitle']">
                <xsl:value-of select="TEI:cell[@type='volumeTitle']"/>
                <span>
                    <xsl:text>bind </xsl:text>
                    <xsl:apply-templates/>
                    <xsl:text>:</xsl:text>
                </span>
            </xsl:when>
            <xsl:when test=" following-sibling::TEI:cell[@type='pages']">
                <xsl:value-of select="TEI:cell[@type='pages']"/>
                <span>
                    <xsl:text>bind </xsl:text>
                    <xsl:apply-templates/>
                    <xsl:text>,</xsl:text>
                </span>
            </xsl:when>
            <xsl:otherwise>
                <span>
                    <xsl:text>bind </xsl:text>
                    <xsl:apply-templates/>
                    <xsl:text>.</xsl:text>
                </span>
            </xsl:otherwise>
        </xsl:choose>
        <!-- pro END -->
    </xsl:template>
    
    <xsl:template match="TEI:cell[@type='partTitle']">
        <span class="partTitle">
            <xsl:text>&#x201C;</xsl:text>
            <xsl:apply-templates/>
            <xsl:text>&#x201D;</xsl:text>
            <!-- pro START -->
            <xsl:if test="@ident">
                <xsl:text> (</xsl:text>
                <xsl:value-of select="@ident"/>
                <xsl:text>)</xsl:text>
            </xsl:if>
            <!-- pro END -->
            <xsl:choose>
                <xsl:when test="following-sibling::TEI:cell[@type='firstLine']">
                    <xsl:text> [første linje: </xsl:text>
                    <xsl:value-of select="//TEI:cell[@type='firstLine']"/>
                    <xsl:text>]</xsl:text>
                </xsl:when>
            </xsl:choose>
            <xsl:text> i </xsl:text>
            <span class="mainTitle">
                <xsl:value-of select="//TEI:row[@xml:id=current()/@key]//TEI:cell[@type='mainTitle']"/>
                <xsl:call-template name="delimiterPunktum"/>
            </span>
            <span class="partTitle">
                <xsl:value-of select="//TEI:row[@xml:id=current()/@key]//TEI:cell[@type='partTitle']"/>
                <!-- pro START  -->
                <!--xsl:call-template name="delimiterPunktum"/-->
                <!-- pro END -->
            </span>
            <!-- pro START-->
            <xsl:choose>
                <xsl:when test="//TEI:row[@xml:id=current()/@key]//TEI:cell[@type='traditionalTitle']">
                    <span class="traditionalTitle">
                        <xsl:text> (</xsl:text>
                        
                        <xsl:value-of select="//TEI:row[@xml:id=current()/@key]//TEI:cell[@type='traditionalTitle']"/>              
                        <xsl:text>).</xsl:text>
                    </span>
                </xsl:when>
            </xsl:choose>
            <!-- pro END -->
        </span>
    </xsl:template>
    
    <xsl:template match="TEI:cell[@type='numberOfVolumes']">
        <!-- pro START -->
        <xsl:choose>
            <xsl:when test=" following-sibling::TEI:cell[@type='volume']">
                <span>
                    <xsl:text>bind </xsl:text>
                    <xsl:apply-templates/>
                    <xsl:text>, </xsl:text>
                </span>
            </xsl:when>
            <xsl:otherwise>
                <span>
                    <xsl:text>bind </xsl:text>
                    <xsl:apply-templates/>
                    <xsl:text>. </xsl:text>
                </span>
            </xsl:otherwise>
        </xsl:choose>
        <!-- pro END -->
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
            <!-- pro START -->
            <xsl:text>.</xsl:text>
            <!-- pro END -->
        </span>
    </xsl:template>
    
    <xsl:template match="TEI:cell[@type='issue']">
        <span>
            <xsl:apply-templates/>
            <xsl:call-template name="delimiterKomma"/>
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
        <xsl:choose>
            <xsl:when test="following-sibling::TEI:cell[@type='volume']">
                <xsl:text>,</xsl:text>
            </xsl:when>
            <xsl:otherwise>
                <xsl:text>.</xsl:text>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    <xsl:template match="TEI:cell[@type='shelf' or @type='box' or @type='owner' or @type='fax' or @type='shortForm' or @type='provenance' or @type='condition' or @type='firstLine' or @type='traditionalTitle']"/>
    
</xsl:stylesheet>