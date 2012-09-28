<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet 
    xmlns:TEI="http://www.tei-c.org/ns/1.0" 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    version="1.0"
    >

<!-- KSR: 2011.09.26 -->



    <xsl:template match="TEI:TEI">

        <div class="rootText">
                <div class="kolofonBlad">
                    
                <div class="kolofonTitle">
                    <xsl:if test="TEI:teiHeader/TEI:fileDesc/TEI:titleStmt/TEI:title[@rend='main']">
                            N.F.S. Grundtvig:
                            <i><xsl:apply-templates select="TEI:teiHeader/TEI:fileDesc/TEI:titleStmt/TEI:title[@rend='main']"/></i>
                        </xsl:if>
                        <xsl:if test="TEI:teiHeader/TEI:fileDesc/TEI:titleStmt/TEI:title[@rend='part']">
                            N.F.S. Grundtvig:
                            &#x201C;<xsl:apply-templates select="TEI:teiHeader/TEI:fileDesc/TEI:titleStmt/TEI:title[@rend='part']"/>&#x201D;
                        </xsl:if>                         
                </div>
                
                
                <div class="kolofon">
                    <xsl:text>(</xsl:text><i><xsl:text>Grundtvigs Værker, </xsl:text></i>
                    <xsl:text>version </xsl:text>
                    <xsl:apply-templates select="//TEI:edition"/>
                    <xsl:text>)</xsl:text>
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
                        <xsl:if test="//TEI:note[@type='com']">
                            <xsl:text>Punktkommentarer ved </xsl:text>
                            <xsl:for-each select="document(//TEI:note[@type='com']/@target)//TEI:TEI/TEI:teiHeader/TEI:fileDesc/TEI:titleStmt/TEI:author">
                                <xsl:apply-templates/>
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
                        </xsl:if>
                        <xsl:if test="//TEI:note[@type='noCom']">
                            <xsl:text>Punktkommentarerne er under udarbejdelse</xsl:text>
                        </xsl:if>
                    </div>
                    
                    <div class="kolofon">
                        <xsl:if test="//TEI:note[@type='intro']">
                            <xsl:text>Indledning ved </xsl:text>
                            <xsl:for-each select="document(//TEI:note[@type='intro']/@target)//TEI:TEI/TEI:teiHeader/TEI:fileDesc/TEI:titleStmt/TEI:author">
                                <xsl:apply-templates/>
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
                                <xsl:apply-templates/>
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
                        </xsl:if>
                        <xsl:if test="//TEI:note[@type='noIntro']">
                            <xsl:text>Indledningen er under udarbejdelse</xsl:text>
                        </xsl:if>
                    </div>
                    
                    <div class="kolofon">
                        <xsl:if test="//TEI:note[@type='txr']">
                            <xsl:text>Tekstredegørelse ved </xsl:text> 
                            <xsl:for-each select="document(//TEI:note[@type='txr']/@target)//TEI:TEI/TEI:teiHeader/TEI:fileDesc/TEI:titleStmt/TEI:author">
                                <xsl:apply-templates/>
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
                        </xsl:if>
                        <xsl:if test="//TEI:note[@type='noTxr']">
                            <xsl:text>Tekstredegørelsen er under udarbejdelse</xsl:text>
                        </xsl:if>
                    </div>
                    
                    <div class="kolofon">
                        <xsl:if test="//TEI:note[@type='var']">
                            <xsl:text>Varianter er etableret af </xsl:text> 
                            <xsl:for-each select="document(//TEI:note[@type='txr']/@target)//TEI:TEI/TEI:teiHeader/TEI:fileDesc/TEI:titleStmt/TEI:author">
                                <xsl:apply-templates/>
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
                        </xsl:if>
                        <xsl:choose>
                            <xsl:when test="//TEI:note[@type='noVar']">
                                <xsl:text>Varianter er endnu ikke etableret.</xsl:text>
                            </xsl:when>
                            <xsl:when test="//TEI:note[@type='minusVar']">
                                <xsl:text>GV udgiver ikke varianter til dette værk.</xsl:text>
                            </xsl:when>
                            <xsl:when test="//TEI:note[@type='unknownVar']">
                                <xsl:text>Der kendes ikke varianter til dette værk.</xsl:text>
                            </xsl:when>
                        </xsl:choose>
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
                
                <xsl:apply-templates select="TEI:text"/>
                
            </div>
    </xsl:template>
    
    <xsl:template match="TEI:lb">        
        <br>
            <xsl:apply-templates/>
        </br>        
    </xsl:template>
    
    <!-- titelblad START -->
    
    <xsl:template match="TEI:titlePage">
        <div class="titlePageHAT">
            <xsl:apply-templates/>
        </div>
    </xsl:template>
    
    <xsl:template match="TEI:titlePart">
        <xsl:choose>
            <xsl:when test="@type='dustTitlePage'">
                <div class="dustTitlePage">
                    <xsl:apply-templates/>
                </div>
            </xsl:when>
            <xsl:when test="@type='main'">
                <div class="titlePartMain">
                    <xsl:apply-templates/>
                </div>
            </xsl:when>
            <xsl:when test="@type='part'">
                <div class="titlePartPart">
                    <xsl:apply-templates/>
                </div>
            </xsl:when>
        </xsl:choose>
    </xsl:template>
    
    <xsl:template match="TEI:byline">
        <div class="byline">
            <xsl:apply-templates/>
        </div>
    </xsl:template>
    
    <xsl:template match="TEI:docAuthor">
        <div class="docAuthor">
            <xsl:apply-templates/>
        </div>
    </xsl:template>
    
    <xsl:template match="TEI:note[@type='prof']">
        <div class="noteProf">
            <xsl:apply-templates/>
        </div>
    </xsl:template>
    
    <xsl:template match="TEI:docImprint">        
        <div class="docImprint">
            <xsl:apply-templates/>
        </div>        
    </xsl:template>
    
    <xsl:template match="TEI:docTitle">
        <div class="docTitle">
            <xsl:apply-templates/>
        </div>
    </xsl:template>
    
    <xsl:template match="TEI:pubPlace">        
        <div class="pubPlace">
            <xsl:apply-templates/>
        </div>
    </xsl:template>
    
    <xsl:template match="TEI:docDate">
        <div class="docDate">
            <xsl:apply-templates/>
        </div>
    </xsl:template>
    
    <xsl:template match="TEI:publisher">        
        <div class="publisher">
            <xsl:apply-templates/>
        </div>
    </xsl:template>
    
    <xsl:template match="TEI:epigraph">
        <div class="epigraph">
            <xsl:apply-templates/>
        </div>
    </xsl:template>
    
    <!-- titelblad END -->
    
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
        <span class="app" href="#">
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
       </span>
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
    
    <!-- footnote STRAT -->
    
    <xsl:template name="footnote">
        <xsl:if test=".//TEI:note[@type='footnote']">
            <br/>
            <hr class="footLine"/>            
            <xsl:apply-templates select=".//TEI:note[@type='footnote']" mode="foot"/>
        </xsl:if>
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

    <xsl:template match="TEI:body/TEI:div">        
        <div class="chapter">
            <xsl:if test="@type">   
                <xsl:attribute name="name">
                    <xsl:value-of select="@type"/>
               </xsl:attribute> 
            </xsl:if>
            <xsl:apply-templates/>
            <xsl:call-template name="footnote"/>
        </div>
    </xsl:template>
    
    <xsl:template match="TEI:hi">        
        <span class="{@rend}">
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    
        
    
    
    <xsl:template match="TEI:seg[@type and @n and @type!='comStart' and @type!='comEnd']">
        <xsl:choose>
            <xsl:when test="//TEI:noteStmt/TEI:note[@type='com']">
                <span class="seg">
                    <xsl:attribute name="id">
                        <xsl:value-of select="@n"/>
                    </xsl:attribute>
                    <xsl:apply-templates/>
                </span>                
            </xsl:when>
            <xsl:otherwise>
                <span class="noSeg">
                    <xsl:apply-templates/>
                </span>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    <xsl:template match="TEI:seg[@type='comStart' and @n]">
        <xsl:choose>
            <xsl:when test="//TEI:noteStmt/TEI:note[@type='com']">
                <span class="segStart">
                    <xsl:attribute name="id">
                        <xsl:value-of select="@n"/>
                    </xsl:attribute>
                    &#x25BA;
                    <xsl:apply-templates/>
                </span>
            </xsl:when>
            <xsl:otherwise>
                <span class="noSeg">
                    <xsl:apply-templates/>
                </span>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    <xsl:template match="TEI:seg[@type='comEnd' and @n]">
        <xsl:choose>
            <xsl:when test="//TEI:noteStmt/TEI:note[@type='com']">
                <span class="segEnd">
                    <xsl:attribute name="id">
                        <xsl:value-of select="@n"/>
                    </xsl:attribute>                                        
                    &#x25C4;
                    <xsl:apply-templates/>
                </span>
            </xsl:when>
            <xsl:otherwise>
                <span class="noSeg">
                    <xsl:apply-templates/>
                </span>
            </xsl:otherwise>
        </xsl:choose>
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

    <xsl:template match="TEI:pb[@type='text' and not(@rend='supp')]">        
        <!-- <xsl:value-of select="concat('xxx/', substring-before(@facs, '_'), '_', substring-before(substring-after(@facs, '_'), '_'), '/', @facs)"/> -->
        <a hrel="{@facs}" class="app faksimile_viewer">
            <xsl:text>|</xsl:text>
                <xsl:value-of select="@ed"/>:<xsl:value-of select="@n"/>
        </a>        
    </xsl:template>
    
    <xsl:template match="TEI:pb[@type='text' and @rend='supp']">
        <a hrel="{@facs}" class="app faksimile_viewer">
            <xsl:text>|</xsl:text>
                [<xsl:value-of select="@ed"/>:<xsl:value-of select="@n"/>]
        </a>  
    </xsl:template>
    
    <xsl:template match="TEI:pb[@type='edition']">
        <a hrel="{@facs}" class="app faksimile_viewer">
            <xsl:text>|</xsl:text>
                <xsl:value-of select="@ed"/>:<xsl:value-of select="@n"/>
        </a>
    </xsl:template>
    
    <xsl:template name="delimiterComma">
        <xsl:text>, </xsl:text>
    </xsl:template>
    
    <xsl:template name="delimiterFullStop">
        <xsl:text>.</xsl:text>
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
    
    
    <!-- <xsl:call-template name="footnote"/> -->
    
    <xsl:template match="TEI:div[@type='bibleVerse' or @type='motto' or @type='preFace']">
        <div class="{@type}">
            <xsl:apply-templates/>
        </div>
        <xsl:call-template name="footnote"/>
    </xsl:template>

</xsl:stylesheet>