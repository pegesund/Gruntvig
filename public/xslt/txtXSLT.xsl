<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet 
    xmlns:TEI="http://www.tei-c.org/ns/1.0" 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    version="1.0">

<!-- KSR: 2011.09.26 -->


    <xsl:include href="popups.xsl"/>
    <xsl:template match="TEI:TEI">

        <div class="rootText">
                <div class="kolofonBlad">
                    
                    <div class="kolofonTitle">
                        <xsl:if test="TEI:teiHeader/TEI:fileDesc/TEI:titleStmt/TEI:title[@rend='main']">
                            <i><xsl:apply-templates select="TEI:teiHeader/TEI:fileDesc/TEI:titleStmt/TEI:title[@rend='main']"/></i>
                        </xsl:if>                    
                        <xsl:if test="TEI:teiHeader/TEI:fileDesc/TEI:titleStmt/TEI:title[@rend='part']">
                            &#x201C;<xsl:apply-templates select="TEI:teiHeader/TEI:fileDesc/TEI:titleStmt/TEI:title[@rend='part']"/>&#x201D;
                        </xsl:if>                         
                    </div>
                    
                    <div class="kolofon">                        
                        <xsl:text>Tekstkilder</xsl:text>
                        
                        <tr>
                            <xsl:for-each select="//TEI:listWit[@xml:id='emendation']/TEI:witness">
                                <div class="table">
                                    <table>
                                        <td class="sigel">
                                        <xsl:value-of select="@rend"/>
                                    </td>
                                    <td class="source">
                                        <xsl:apply-templates select="."/>
                                    </td>
                                    </table>
                                </div>
                            </xsl:for-each>
                        </tr>
                        <tr>
                            <xsl:if test="//TEI:listWit[@xml:id='pageNumber']/TEI:witness">
                                <xsl:for-each select="//TEI:listWit[@xml:id='pageNumber']/TEI:witness">
                                    <div class="table">
                                        <table>
                                            <td class="sigel">
                                            <xsl:value-of select="@rend"/>
                                        </td>
                                        <td class="source">
                                            <xsl:apply-templates select="."/>
                                        </td>
                                        </table>
                                    </div>
                                </xsl:for-each>
                            </xsl:if>
                        </tr>
                        
                    </div>
                    
                    <div class="kolofon">
                        <xsl:text>Teksten er etableret af </xsl:text>
                            <xsl:for-each select="//TEI:editor[@role='editionPhilologist']">
                                <xsl:value-of select="."/>
                                <xsl:if test="following-sibling::TEI:editor[@role='editionPhilologist']">
                                    <xsl:choose>
                                        <xsl:when test="following-sibling::TEI:editor[@role='editionPhilologist'][position()!=last()]">
                                            <xsl:call-template name="delimiterComma"/>
                                        </xsl:when>
                                        <xsl:otherwise>
                                            <xsl:text> og </xsl:text>
                                        </xsl:otherwise>
                                    </xsl:choose>
                                </xsl:if>
                            </xsl:for-each>
                        <xsl:call-template name="delimiterFullStop"/>                        
                    </div>
                    
                    <div class="kolofon">
                        <xsl:text>Punktkommentarer ved </xsl:text>
                        <xsl:for-each select="document(//TEI:note[@type='com']/@target)//TEI:TEI/TEI:teiHeader/TEI:fileDesc/TEI:titleStmt/TEI:author">
                            <xsl:apply-templates select="."/>
                            <xsl:if test="following-sibling::TEI:author">
                                <xsl:choose>
                                    <xsl:when test="following-sibling::TEI:author[position()!=last()]">
                                        <xsl:call-template name="delimiterComma"/>
                                    </xsl:when>
                                    <xsl:otherwise>
                                        <xsl:text> og </xsl:text>
                                    </xsl:otherwise>
                                </xsl:choose>
                            </xsl:if>
                        </xsl:for-each>
                        <xsl:text>, redigeret af </xsl:text>
                        <xsl:for-each select="document(//TEI:note[@type='com']/@target)//TEI:TEI/TEI:teiHeader/TEI:fileDesc/TEI:titleStmt/TEI:editor[@role='editor']">
                            <xsl:apply-templates select="."/>
                            <xsl:if test="following-sibling::TEI:editor[@role='editor']">
                                <xsl:choose>
                                    <xsl:when test="following-sibling::TEI:editor[@role='editor'][position()!=last()]">
                                        <xsl:call-template name="delimiterComma"/>
                                    </xsl:when>
                                    <xsl:otherwise>
                                        <xsl:text> og </xsl:text>
                                    </xsl:otherwise>
                                </xsl:choose>
                            </xsl:if>
                        </xsl:for-each>
                        <xsl:call-template name="delimiterFullStop"/>
                    </div>
                    
                    <div class="kolofon">
                        <xsl:if test="document(//TEI:note[@type='intro']/@target)//TEI:TEI/TEI:teiHeader/TEI:fileDesc/TEI:titleStmt/TEI:editor[@role='contributor']">
                            <xsl:text>Indledning ved </xsl:text> 
                            <xsl:for-each select="document(//TEI:note[@type='intro']/@target)//TEI:TEI/TEI:teiHeader/TEI:fileDesc/TEI:titleStmt/TEI:author">
                                <xsl:apply-templates select="."/>
                                <xsl:if test="following-sibling::TEI:author">
                                    <xsl:choose>
                                        <xsl:when test="following-sibling::TEI:author[position()!=last()]">
                                            <xsl:call-template name="delimiterComma"/>
                                        </xsl:when>
                                        <xsl:otherwise>
                                            <xsl:text> og </xsl:text>
                                        </xsl:otherwise>
                                    </xsl:choose>
                                </xsl:if>
                            </xsl:for-each>
                            <xsl:text>, redigeret af </xsl:text>
                            <xsl:for-each select="document(//TEI:note[@type='intro']/@target)//TEI:TEI/TEI:teiHeader/TEI:fileDesc/TEI:titleStmt/TEI:editor[@role='editor']">
                                <xsl:apply-templates select="."/>
                                <xsl:if test="following-sibling::TEI:editor[@role='editor']">
                                    <xsl:choose>
                                        <xsl:when test="following-sibling::TEI:editor[@role='editor'][position()!=last()]">
                                            <xsl:call-template name="delimiterComma"/>
                                        </xsl:when>
                                        <xsl:otherwise>
                                            <xsl:text> og </xsl:text>
                                        </xsl:otherwise>
                                    </xsl:choose>
                                </xsl:if>
                            </xsl:for-each>
                            <xsl:call-template name="delimiterFullStop"/>
                        </xsl:if>                         
                    </div>
                    
                    <div class="kolofon">
                        <xsl:text>Tekstredegørelse ved </xsl:text> 
                        <xsl:for-each select="document(//TEI:note[@type='txr']/@target)//TEI:TEI/TEI:teiHeader/TEI:fileDesc/TEI:titleStmt/TEI:author">
                            <xsl:apply-templates select="."/>
                            <xsl:if test="following-sibling::TEI:author">
                                <xsl:choose>
                                    <xsl:when test="following-sibling::TEI:author[position()!=last()]">
                                        <xsl:call-template name="delimiterComma"/>
                                    </xsl:when>
                                    <xsl:otherwise>
                                        <xsl:text> og </xsl:text>
                                    </xsl:otherwise>
                                </xsl:choose>
                            </xsl:if>
                        </xsl:for-each>
                        <xsl:text>, redigeret af </xsl:text>
                        <xsl:for-each select="document(//TEI:note[@type='txr']/@target)//TEI:TEI/TEI:teiHeader/TEI:fileDesc/TEI:titleStmt/TEI:editor[@role='editor']">
                            <xsl:apply-templates select="."/>
                            <xsl:if test="following-sibling::TEI:editor[@role='editor']">
                                <xsl:choose>
                                    <xsl:when test="following-sibling::TEI:editor[@role='editor'][position()!=last()]">
                                        <xsl:call-template name="delimiterComma"/>
                                    </xsl:when>
                                    <xsl:otherwise>
                                        <xsl:text> og </xsl:text>
                                    </xsl:otherwise>
                                </xsl:choose>
                            </xsl:if>                            
                        </xsl:for-each>
                        <xsl:call-template name="delimiterFullStop"/>                        
                    </div>
                    
                    <div class="kolofon">
                        <xsl:if test="document(//TEI:note[@type='com']/@target)//TEI:TEI/TEI:teiHeader/TEI:fileDesc/TEI:titleStmt/TEI:editor[@role='contributor']">
                            <xsl:text>For hjælp til punktkommentarer takkes </xsl:text>
                            <xsl:for-each select="document(//TEI:note[@type='com']/@target)//TEI:TEI/TEI:teiHeader/TEI:fileDesc/TEI:titleStmt/TEI:editor[@role='contributor']">
                                <xsl:apply-templates select="."/>
                                <xsl:if test="following-sibling::TEI:editor[@role='contributor']">
                                    <xsl:choose>
                                        <xsl:when test="following-sibling::TEI:editor[@role='contributor'][position()!=last()]">
                                            <xsl:call-template name="delimiterComma"/>
                                        </xsl:when>
                                        <xsl:otherwise>
                                            <xsl:text> og </xsl:text>
                                        </xsl:otherwise>
                                    </xsl:choose>
                                </xsl:if>
                            </xsl:for-each>
                            <xsl:call-template name="delimiterFullStop"/>
                        </xsl:if>                        
                    </div>
                    
                    <div class="kolofon">
                        <xsl:if test="document(//TEI:note[@type='intro']/@target)//TEI:TEI/TEI:teiHeader/TEI:fileDesc/TEI:titleStmt/TEI:editor[@role='contributor']">
                            <xsl:text>For hjælp til indledning takkes </xsl:text> 
                            <xsl:for-each select="document(//TEI:note[@type='intro']/@target)//TEI:TEI/TEI:teiHeader/TEI:fileDesc/TEI:titleStmt/TEI:editor[@role='contributor']">
                                <xsl:apply-templates select="."/>
                                <xsl:if test="following-sibling::TEI:editor[@role='contributor']">
                                    <xsl:choose>
                                        <xsl:when test="following-sibling::TEI:editor[@role='contributor'][position()!=last()]">
                                            <xsl:call-template name="delimiterComma"/>
                                        </xsl:when>
                                        <xsl:otherwise>
                                            <xsl:text> og </xsl:text>
                                        </xsl:otherwise>
                                    </xsl:choose>
                                </xsl:if>
                            </xsl:for-each>
                            <xsl:call-template name="delimiterFullStop"/>
                        </xsl:if>                        
                    </div>
                    
                    <div class="copyright">
                        <xsl:text>Copyright: </xsl:text><i><xsl:text>Grundtvigs Værker</xsl:text></i>
                    </div>
                    
                </div>
                
                <hr/>
                
                <xsl:apply-templates select="TEI:text"/>
                
                <br/>
                
                <hr class="footLine"/>
                
                <xsl:apply-templates select="//TEI:note[@type='footnote']" mode="foot"/>
                
            </div>
    </xsl:template>
    
    
    <!--
    
    <xsl:template match="TEI:teiHeader/TEI:fileDesc/TEI:titleStmt/TEI:editor[@role='editionPhilologist']">        
        <div class="editionPhilologist">
            <xsl:apply-templates/>
        </div>
    </xsl:template>
    
    -->
    
    <xsl:template match="TEI:lb">        
        <br>
            <xsl:apply-templates/>
        </br>        
    </xsl:template>
    
    <!-- titelblad start -->
    
    <xsl:template match="TEI:titlePage">
        <div class="titlePage">
            <xsl:apply-templates/>
        </div>
    </xsl:template>
    
    <xsl:template match="TEI:titlePart">
        <div class="{@type}">
            <xsl:apply-templates/>
        </div>
    </xsl:template>
    
    <xsl:template match="TEI:docTitle">
        <div class="docTitle">
            <xsl:apply-templates/>
        </div>
    </xsl:template>
    
    <xsl:template match="TEI:byline">
        <div class="byline">
            <xsl:apply-templates/>
        </div>
    </xsl:template>
    
    <xsl:template match="TEI:docImprint">        
        <div class="docImprint">
            <xsl:apply-templates/>
        </div>        
    </xsl:template>
    
    <xsl:template match="TEI:fw[@type='longLine']">
        <hr align="center" class="fwLongLine"/>        
    </xsl:template>
    
    <xsl:template match="TEI:fw[@type='shortLine']">
        <hr align="center" class="fwShortLine"/>
    </xsl:template>
    
    <xsl:template match="TEI:titlePart[@type='part']">
        <div class="titlePart">
            <xsl:apply-templates/>
        </div>
    </xsl:template>
    
    <!-- titelblad end -->
    
    <xsl:template match="TEI:div[@type='motto']">
        <div class="motto">
            <xsl:apply-templates/>
        </div>        
    </xsl:template>
    
    <xsl:template match="TEI:div[@type='preFace']">        
        <div class="preFace">
            <xsl:apply-templates/>
        </div>        
    </xsl:template>

<!--
    henter nummer på stofe; konflikt med næste template?
    <xsl:template match="TEI:lg[@n]">        
        <div class="lgNumber">
                <xsl:value-of select="@n"/>
            <xsl:apply-templates/>
            <br/>
        </div>        
    </xsl:template>
-->
    
    <xsl:template match="TEI:lg">
        <div class="lg">
            <xsl:apply-templates/>
        </div>
    </xsl:template>
    
    <xsl:template match="TEI:l">
        <div class="l_{@rend}">
            <xsl:apply-templates/>
        </div>
    </xsl:template>
    
    <xsl:template match="TEI:head">        
        <div class="head{@rend}">
            <xsl:apply-templates/>
        </div>
    </xsl:template>
    
    <xsl:template match="TEI:app">
        <a class="app" href="#">
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
                <xsl:if test="*[@type='add']">
                    <xsl:apply-templates select="*[@type='add']"/>                                     
                </xsl:if>
            </span>
        </a>
    </xsl:template>
    
    <xsl:template match="TEI:rdg">
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
                <!-- kan korges ned til: 
                    <xsl:when test="following-sibling::TEI:rdg">
                    <xsl:text>; </xsl:text>
                    </xsl:when>
                -->
            </i>
        </span>
    </xsl:template>
    
    <xsl:template match="TEI:note[@type='add']">        
        <span class="editor">
            <i>
                <xsl:value-of select="TEI:note[@type='add']"/>
            </i>                        
        </span>
    </xsl:template>
    
    <xsl:template match="TEI:note[@type='footnote']">
        <xsl:variable name="id">
            <xsl:number level="any" from="TEI:text"/>
        </xsl:variable>
            <a id="retur{$id}" href="#note{$id}">
                <span class="footMarker">
                    <xsl:value-of select="$id"/>
                </span>
            </a>                            
    </xsl:template>
    
    <xsl:template match="TEI:note[@type='footnote']" mode="foot">
        <xsl:variable name="id">
            <xsl:number level="any" from="TEI:text"/>
        </xsl:variable>
        <a id="note{$id}" href="#retur{$id}">
            <span class="footMarker">
                <xsl:value-of select="$id"/>
            </span>
        </a>               
        <div class="footnote">
            <xsl:apply-templates/>
        </div>
    </xsl:template>
    
    <!--
    
    <xsl:template match="TEI:note[@type='footnote']">
        *
        <hr class="footLine"/>
        <div class="footnote">
            <xsl:apply-templates/>
        </div>
    </xsl:template>
    
    -->
    
    <xsl:template match="TEI:hi">        
        <span class="{@rend}">
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    
        
    <xsl:template match="TEI:seg[@type and @n and @type!='comStart' and @type!='comEnd']">        
        <span class="seg">
            <xsl:attribute name="id">
                <xsl:value-of select="@n"/>
            </xsl:attribute>

            <xsl:apply-templates/>
        </span>
    </xsl:template>
    
    <xsl:template match="TEI:seg[@type='comStart' and @n]">        
        <span class="segStart">
            &#x25BA;
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    
    <xsl:template match="TEI:seg[@type='comEnd' and @n]">        
        <span class="segEnd">
            &#x25C4;
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    
    
    <xsl:template match="TEI:p[@rend and not(@rend='hangingIndent')]">        
        <div class="{@rend}">
            <xsl:apply-templates/>
        </div>
    </xsl:template>
    
    <xsl:template match="TEI:p[@rend='hangingIndent']">        
        <div class="hangingIndent">
            <xsl:apply-templates/>
        </div>
    </xsl:template>

    <xsl:template match="TEI:pb[@type='text' and not(@rend='supp')]">        |
        <!-- <xsl:value-of select="concat('xxx/', substring-before(@facs, '_'), '_', substring-before(substring-after(@facs, '_'), '_'), '/', @facs)"/> -->
        <a href="{@facs}">            
            <span class="pbA">
                <xsl:value-of select="@ed"/>:<xsl:value-of select="@n"/>
            </span>
            
        </a>        
    </xsl:template>
    
    <xsl:template match="TEI:pb[@type='text' and @rend='supp']">
        |
        <a href="#">
            <span class="pbA">
                [<xsl:value-of select="@ed"/>:<xsl:value-of select="@n"/>]
            </span>            
        </a>        
    </xsl:template>
    
    <xsl:template match="TEI:pb[@type='paraText']">
        |
        <a href="#">
            <span class="pb">
                [<xsl:value-of select="@facs"/>]
            </span> 
        </a>       
    </xsl:template>
    
    <xsl:template match="TEI:pb[@type='edition']">
        |
        <span class="pb">
            <xsl:value-of select="@ed"/>:<xsl:value-of select="@n"/>
        </span>        
    </xsl:template>
    
    <xsl:template name="delimiterComma">
        <xsl:text>, </xsl:text>
    </xsl:template>
    
    <xsl:template name="delimiterFullStop">
        <xsl:text>.</xsl:text>
    </xsl:template>

<!-- pb{@ed} til forsk stil til hver ed -->

<!--
    
    <xsl:template match="TEI:lg">        
        <div class="lg">
            <xsl:apply-templates/>
        </div>        
    </xsl:template>
    
    <xsl:template match="TEI:l">        
        <div class="l">
            <xsl:apply-templates/>
        </div>        
    </xsl:template>
-->
    
</xsl:stylesheet>