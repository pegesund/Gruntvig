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
        <div class="refdiv titleRef" id="{@xml:id}">
          <div class="row">
            <!--xsl:choose>
                <xsl:when test="TEI:cell[@type='partTitle'] and not(TEI:cell[@type='shortForm'])">
                    <span class="partTitle">
                        &#x201C;<xsl:apply-templates/>
                        <xsl:text>&#x201D;</xsl:text>
                        <xsl:text> i </xsl:text>
                        <span style="font-style: italic">
                            <xsl:value-of select="//TEI:row[@xml:id=current()/@key]//TEI:cell[@type='mainTitle']"/>
                            <xsl:text>,</xsl:text>
                        </span>
                    </span>
                </xsl:when>
                <xsl:when test="TEI:cell[@type='partTitle'] and TEI:cell[@type='shortForm']">
                    <span class="partTitle">
                        <span style="font-style: italic">
                            <xsl:value-of select="//TEI:row[@xml:id=current()/@key]//TEI:cell[@type='mainTitle']"/>
                        </span>
                    </span>
                </xsl:when>
            </xsl:choose-->
            <xsl:apply-templates/>
          </div>
        </div>
    </xsl:template>
    
    <!--
        
    <xsl:template match="TEI:row"/>
    
    [@xml:id='title1' or @xml:id='title122' or @xml:id='title2876' or @xml:id='title144' or @xml:id='title121' or @xml:id='title2877' or @xml:id='title134' or @xml:id='title551' or @xml:id='title83' or @xml:id='title629' or @xml:id='title187' or @xml:id='title0' or @xml:id='title127' or @xml:id='title139' or @xml:id='title3369' or @xml:id='title2263' or @xml:id='title1849' or @xml:id='title538' or @xml:id='title143' or @xml:id='title2388' or @xml:id='title327' or @xml:id='title594' or @xml:id='title787' or @xml:id='title138' or @xml:id='title771' or @xml:id='title125' or @xml:id='title133' or @xml:id='title1402' or @xml:id='title3272' or @xml:id='title697' or @xml:id='title76' or @xml:id='title131' or @xml:id='title15' or @xml:id='title2386' or @xml:id='title2951' or @xml:id='title320' or @xml:id='title564' or @xml:id='title137' or @xml:id='title1851' or @xml:id='title1853' or @xml:id='title2837' or @xml:id='title136' or @xml:id='title153' or @xml:id='title2910' or @xml:id='title307' or @xml:id='title3114' or @xml:id='title339' or @xml:id='title140' or @xml:id='title1404' or @xml:id='title306' or @xml:id='title324' or @xml:id='title341' or @xml:id='title3903' or @xml:id='title3990' or @xml:id='title589' or @xml:id='title776' or @xml:id='title810' or @xml:id='title106' or @xml:id='title146' or @xml:id='title2588' or @xml:id='title2589' or @xml:id='title650' or @xml:id='title655' or @xml:id='title7' or @xml:id='title736' or @xml:id='title803' or @xml:id='title82' or @xml:id='title93' or @xml:id='title000' or @xml:id='title148' or @xml:id='title2' or @xml:id='title2163' or @xml:id='title2350' or @xml:id='title2518' or @xml:id='title3169' or @xml:id='title319' or @xml:id='title3447' or @xml:id='title3852' or @xml:id='title646' or @xml:id='title73' or @xml:id='title778' or @xml:id='title784' or @xml:id='title132' or @xml:id='title135' or @xml:id='title1570' or @xml:id='title1806' or @xml:id='title2162' or @xml:id='title235' or @xml:id='title2369' or @xml:id='title2911' or @xml:id='title3129' or @xml:id='title3204' or @xml:id='title3219' or @xml:id='title334' or @xml:id='title340' or @xml:id='title354' or @xml:id='title3594' or @xml:id='title4156' or @xml:id='title533' or @xml:id='title603' or @xml:id='title72' or @xml:id='title75' or @xml:id='title77' or @xml:id='title785' or @xml:id='title790' or @xml:id='title794' or @xml:id='title126' or @xml:id='title128' or @xml:id='title14' or @xml:id='title151' or @xml:id='title1676' or @xml:id='title1855' or @xml:id='title1864' or @xml:id='title202' or @xml:id='title2164' or @xml:id='title222' or @xml:id='title2222' or @xml:id='title2228' or @xml:id='title2349' or @xml:id='title2364' or @xml:id='title2368' or @xml:id='title2370' or @xml:id='title242' or @xml:id='title2507' or @xml:id='title2517' or @xml:id='title255' or @xml:id='title2569' or @xml:id='title2572' or @xml:id='title2594' or @xml:id='title28' or @xml:id='title2868' or @xml:id='title2950' or @xml:id='title297' or @xml:id='title3' or @xml:id='title315' or @xml:id='title3154' or @xml:id='title3202' or @xml:id='title3282' or @xml:id='title3299' or @xml:id='title33' or @xml:id='title3362' or @xml:id='title3381' or @xml:id='title3383' or @xml:id='title3386' or @xml:id='title348' or @xml:id='title3621' or @xml:id='title3624' or @xml:id='title3662' or @xml:id='title3663' or @xml:id='title3989' or @xml:id='title3992' or @xml:id='title3996' or @xml:id='title4014' or @xml:id='title576' or @xml:id='title696' or @xml:id='title709' or @xml:id='title774' or @xml:id='title783' or @xml:id='title796' or @xml:id='title800']
    
    -->
    
    <xsl:template match="TEI:cell[@type='mainAuthor']">
        <span class="mainAuthor">
            <xsl:if test="TEI:note[@type='lastName']"> 
                <xsl:apply-templates select="TEI:note[@type='lastName']"/>
                <xsl:text>, </xsl:text>                
            </xsl:if>            
            <xsl:apply-templates select="TEI:note[@type='firstName']"/>            
            <xsl:if test="following-sibling::TEI:cell[@type='mainAuthor']">
                <xsl:choose>
                    <xsl:when test="following-sibling::TEI:cell[@type='mainAuthor'][position()!=last()]">
                        <xsl:text>, </xsl:text>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:text> &amp; </xsl:text>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:if>
            <xsl:if test="following-sibling::TEI:cell[@type='coAuthor']">
                <xsl:choose>
                    <xsl:when test="following-sibling::TEI:cell[@type='coAuthor'][position()!=last()]">
                        <xsl:text>, </xsl:text>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:text> &amp; </xsl:text>                        
                        <xsl:value-of select="//TEI:cell[@type='coAuthor']"/>                        
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:if>
        </span>
    </xsl:template>
    
    <xsl:template match="TEI:cell[@type='editor']">
        <span class="editor"> 
            <xsl:apply-templates select="TEI:note[@type='lastName']"/>
            <xsl:text>, </xsl:text>
            <xsl:apply-templates select="TEI:note[@type='firstName']"/>            
            <xsl:if test="following-sibling::TEI:cell[@type='editor']">
                <xsl:choose>
                    <xsl:when test="following-sibling::TEI:cell[@type='editor'][position()!=last()]">
                        <xsl:text>, </xsl:text>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:text> &amp; </xsl:text>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:if>            
        </span>
    </xsl:template>
    
    <xsl:template match="TEI:cell[@type='editorOnly']">
        <span class="editor">
            <xsl:choose>
                <xsl:when test="child::TEI:note[@type='firstName']">
                    <xsl:apply-templates select="TEI:note[@type='firstName']"/>
                </xsl:when>
                <xsl:when test="child::TEI:note[@type='firstName' and @type='lastName']">
                    <xsl:apply-templates select="TEI:note[@type='lastName']"/>
                    <xsl:text>, </xsl:text>
                    <xsl:apply-templates select="TEI:note[@type='firstName']"/>
                </xsl:when>
            </xsl:choose>            
            <xsl:if test="following-sibling::TEI:cell[@type='editor']">
                <xsl:choose>
                    <xsl:when test="following-sibling::TEI:cell[@type='editor'][position()!=last()]">
                        <xsl:text>, </xsl:text>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:text> &amp; </xsl:text>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:if>            
        </span>
    </xsl:template>
    
    <xsl:template match="TEI:cell[@type='translatorOnly']">
        <span class="editor">
            <xsl:apply-templates select="TEI:note[@type='lastName']"/>
            <xsl:text>, </xsl:text>
            <xsl:apply-templates select="TEI:note[@type='firstName']"/>
            <xsl:if test="following-sibling::TEI:cell[@type='editor']">
                <xsl:choose>
                    <xsl:when test="following-sibling::TEI:cell[@type='editor'][position()!=last()]">
                        <xsl:text>, </xsl:text>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:text> &amp; </xsl:text>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:if>            
        </span>
    </xsl:template>
    
    <xsl:template match="TEI:cell[@type='coAuthor']"/>
    
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
        </span>
        <xsl:choose>
            <xsl:when test="following-sibling::TEI:cell[@type='translatedTitle']">
                <xsl:text> (da. </xsl:text>
                <xsl:value-of select="//TEI:cell[@type='translatedTitle']"/>
                <xsl:text>)</xsl:text>
            </xsl:when>
        </xsl:choose>
        <xsl:text> i </xsl:text>
        <span style="font-style: italic">
            <xsl:value-of select="//TEI:row[@xml:id=current()/@key]//TEI:cell[@type='mainTitle']"/>
            <xsl:text>.</xsl:text>
        </span>
    </xsl:template>
    
    <xsl:template match="TEI:cell[@type='shelf' or @type='box' or @type='owner' or @type='fax' or @type='shortForm' or @type='provenance' or @type='translatedTitle' or @type='condition']"/>
    
    <xsl:template match="TEI:cell[@type='volume']">
        <span>
            <xsl:text>bind </xsl:text>
            <xsl:apply-templates/>
            <xsl:text>:</xsl:text>
        </span>
    </xsl:template>
    
    <xsl:template match="TEI:cell[@type='volumeTitle']">
        <span>
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    
    <xsl:template match="TEI:cell[@type='firstLine']">
        <span>
            <xsl:text> [første linje: </xsl:text>
            <xsl:apply-templates/>
            <xsl:text>]</xsl:text>
        </span>
    </xsl:template>
    
    <xsl:template match="TEI:cell[@type='issue']">
        <span>
            <xsl:apply-templates/>
            <xsl:call-template name="delimiterKomma"/>
        </span>
    </xsl:template>
    
    <xsl:template match="TEI:cell[@type='pages' and not(@subtype)]">
        <span>
            <xsl:text>s. </xsl:text>
            <xsl:apply-templates/>
            <xsl:call-template name="delimiterPunktum"/>
        </span>
    </xsl:template>
    
    <xsl:template match="TEI:cell[@type='pages' and @subtype='column']">
        <span>
            <xsl:text>sp. </xsl:text>
            <xsl:apply-templates/>
            <xsl:call-template name="delimiterKomma"/>
        </span>
    </xsl:template>
    
    <xsl:template match="TEI:cell[@type='numberOfVolumes']">
        <span>
            <xsl:text>bd. </xsl:text>
            <xsl:apply-templates/>
            <xsl:call-template name="delimiterPunktum"/>
        </span>
    </xsl:template>
    
    <xsl:template match="TEI:cell[@type='number']">
        <span>
            <xsl:text>nr. </xsl:text>
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    
    <xsl:template match="TEI:cell[@type='pubPlace']">
        <span class="pubPlace">
            <xsl:apply-templates/>
            <xsl:text>.</xsl:text>
        </span>
    </xsl:template>
    
    <xsl:template match="TEI:cell[@type='pubYear']">
        <span class="pubYear">
            <xsl:text>(</xsl:text>
            <xsl:apply-templates/>
            <xsl:text>)</xsl:text>
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
    
</xsl:stylesheet>