<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet 
    xmlns:TEI="http://www.tei-c.org/ns/1.0" 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    version="1.0"
    >

<!-- KSR: 2011.09.26 -->

    <xsl:include href="popups.xsl"/>

    <xsl:template match="TEI:TEI">

        <div class="rootText">
                <div class="kolofonBlad">
                    
                <div class="kolofonTitle">
                        <xsl:choose>
                            <xsl:when test="TEI:teiHeader/TEI:fileDesc/TEI:titleStmt/TEI:title[@rend='main' and not(@type='supp')]">
                                N.F.S. Grundtvig
                                <i><xsl:apply-templates select="TEI:teiHeader/TEI:fileDesc/TEI:titleStmt/TEI:title[@rend='main']"/></i>
                            </xsl:when>
                            <xsl:when test="TEI:teiHeader/TEI:fileDesc/TEI:titleStmt/TEI:title[@rend='main' and @type='supp']">
                                N.F.S. Grundtvig
                                [<i><xsl:apply-templates select="TEI:teiHeader/TEI:fileDesc/TEI:titleStmt/TEI:title[@rend='main']"/></i>]
                            </xsl:when>
                            <xsl:when test="TEI:teiHeader/TEI:fileDesc/TEI:titleStmt/TEI:title[@rend='part' and not(@type='supp')]">
                                N.F.S. Grundtvig
                                &#x201C;<xsl:apply-templates select="TEI:teiHeader/TEI:fileDesc/TEI:titleStmt/TEI:title[@rend='part']"/>&#x201D;
                            </xsl:when>
                            <xsl:when test="TEI:teiHeader/TEI:fileDesc/TEI:titleStmt/TEI:title[@rend='part' and @type='supp']">
                                N.F.S. Grundtvig
                                [&#x201C;<xsl:apply-templates select="TEI:teiHeader/TEI:fileDesc/TEI:titleStmt/TEI:title[@rend='part']"/>&#x201D;]
                            </xsl:when>
                        </xsl:choose>
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
                                    <table class="listWit">
                                        <tr>
                                            <td class="sigel">
                                                <xsl:value-of select="@xml:id"/>
                                            </td>
                                            <td class="source">
                                                <xsl:choose>
                                                    <xsl:when test="@xml:id='A' or @xml:id='B'">
                                                        <xsl:apply-templates select="."/>
                                                        <xsl:text> (SJ: </xsl:text>
                                                        <xsl:apply-templates select="@n"/>
                                                        <xsl:text>)</xsl:text>
                                                    </xsl:when>
                                                    <xsl:otherwise>
                                                        <xsl:apply-templates select="."/>
                                                    </xsl:otherwise>
                                                </xsl:choose>
                                            </td>
                                        </tr>
                                        <!--
                                        <tr>
                                            <td class="SJ">Steen Johansen</td>
                                            <td class="SJnumber">
                                                <xsl:text></xsl:text><xsl:apply-templates select="//TEI:publicationStmt/TEI:idno"/><xsl:text></xsl:text>
                                            </td>
                                        </tr>
                                        -->
                                    </table>
                                </div>
                            </xsl:for-each>
                        </tr>
                        
                        <tr>
                            <xsl:if test="//TEI:listWit[@xml:id='pageNumber']/TEI:witness">
                                <xsl:text>Andre udgaver</xsl:text>
                                <xsl:for-each select="//TEI:listWit[@xml:id='pageNumber']/TEI:witness">
                                    <div class="table">
                                        <table>
                                            <td class="sigel">
                                                <xsl:value-of select="@xml:id"/>
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
                        <xsl:text>XML ved Kim Steen Ravn</xsl:text>
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
    
    <xsl:template match="TEI:front[@rend]">
        <div class="frontChapter">
            <xsl:if test="@rend">   
                <xsl:attribute name="name">
                    <xsl:value-of select="@rend"/>
               </xsl:attribute> 
            </xsl:if>
            <xsl:apply-templates/>
        </div>               
    </xsl:template>    
    
    <xsl:template match="TEI:titlePage[@type]">
        <div class="titlePage">
            <xsl:choose>
                <xsl:when test="@type='dustTitlePage'">
                    <div class="dustTitlePaget">
                        <br/><br/><br/><br/><br/>
                        <xsl:apply-templates/>
                    </div>
                </xsl:when>
                <xsl:when test="@type='first'">
                    <div class="titlePageMain">
                        <xsl:apply-templates/>
                    </div>
                </xsl:when>
                <xsl:when test="@type='second'">
                    <div class="titlePagePart">
                        <xsl:apply-templates/>
                    </div>
                </xsl:when>
            </xsl:choose>
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
        <xsl:choose>
            <xsl:when test="parent::TEI:pubPlace">
                <span>
                    <xsl:apply-templates/>
                </span>
            </xsl:when>
            <xsl:otherwise>
                <div class="docDate">
                    <xsl:apply-templates/>
                </div>
            </xsl:otherwise>
        </xsl:choose>
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
        <table class="lg">            
            <tr valign="top">
                <td class="lgNumber">
                    <xsl:value-of select="@n"/>
                </td>
                <td class="lg">
                    <xsl:apply-templates/>
                </td>
            </tr>
        </table>
    </xsl:template>
    
    <xsl:template match="TEI:l">
        <xsl:choose>
            <xsl:when test="@rend='blank'">
                <br/>
            </xsl:when>
            <xsl:otherwise>
                <div class="l_{@rend}">
                    <xsl:apply-templates/>
                </div>
            </xsl:otherwise>
        </xsl:choose>
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
            <hr class="footLine"/>            
            <xsl:apply-templates select=".//TEI:note[@type='footnote']" mode="foot"/>
        </xsl:if>
    </xsl:template>
    
    <xsl:template match="TEI:note[@type='footnote']">
        <xsl:variable name="id">
            <xsl:number level="any" from="TEI:body"/>
        </xsl:variable>
        <a id="retur{$id}" href="#note{$id}" class="footnote">
            <xsl:value-of select="$id"/>
        </a>
    </xsl:template>
    
    <xsl:template match="TEI:note[@type='footnote']" mode="foot">
        <xsl:variable name="id">
            <xsl:number level="any" from="TEI:body"/>
        </xsl:variable>
        <a id="note{$id}" href="#retur{$id}" class="footnote">
            <xsl:value-of select="$id"/>
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
    
    <!-- footnote template fra linj 698 -->
    
    <xsl:template match="TEI:note[@type='footnote']">
        <xsl:variable name="id">
            <xsl:number level="any" from="TEI:text"/>
        </xsl:variable>
        <a id="retur{$id}" href="#note{$id}" class="footMarker">
            <span>
                <xsl:value-of select="$id"/>
            </span>
        </a>
    </xsl:template>
    
    <xsl:template match="TEI:note[@type='footnote']" mode="foot">
        <xsl:variable name="id">
            <xsl:number level="any" from="TEI:text"/>
        </xsl:variable>
        <a id="note{$id}" href="#retur{$id}" class="footMarker">
            <span>
                <xsl:value-of select="$id"/>
            </span>
        </a>
        <span class="footnote">
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    
    
    <!-- <xsl:call-template name="footnote"/> -->
    
    <xsl:template match="TEI:div[@type='bibleVerse' or @type='motto' or @type='preFace']">
        <div class="{@type}">
            <xsl:apply-templates/>
        </div>
        <xsl:call-template name="footnote"/>
    </xsl:template>
    
    <!-- footnote END -->
    
    <xsl:template match="TEI:hi">        
        <span class="{@rend}">
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    
    <xsl:template match="TEI:seg[@type and @n and @type!='comStart' and @type!='comEnd']">
        <xsl:choose>
            <xsl:when test="//TEI:notesStmt/TEI:note[@type='com']">
                <span class="seg">
                    <xsl:attribute name="id">
                        <xsl:value-of select="replace(base-uri(), '.*?([0-9].*)_txt.xml$', '$1')" />
                        <xsl:text>_</xsl:text>
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
            <xsl:when test="//TEI:notesStmt/TEI:note[@type='com']">
                <span class="segStart">
                    <xsl:attribute name="id">
                        <xsl:value-of select="replace(base-uri(), '.*?([0-9].*)_txt.xml$', '$1')" />
                        <xsl:text>_</xsl:text>
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
            <xsl:when test="//TEI:notesStmt/TEI:note[@type='com']">
                <span class="segEnd">
                    <xsl:attribute name="id">
                        <xsl:value-of select="replace(base-uri(), '.*?([0-9].*)_txt.xml$', '$1')" />
                        <xsl:text>_</xsl:text>
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

    <xsl:template match="TEI:pb[@type='text' and not(@rend='supp') and not(parent::TEI:seg)]"> 
        <a hrel="{@facs}" class="app faksimile_viewer" style="cursor:pointer">
            <span class="size">
            <xsl:text>|</xsl:text>
                <xsl:value-of select="@ed"/>:<xsl:value-of select="@n"/>
            </span>
        </a>        
    </xsl:template>
    
    <xsl:template match="TEI:pb[@type='text' and @rend='supp']">
        <a hrel="{@facs}" class="app faksimile_viewer" style="cursor:pointer">
            <span class="size">
            <xsl:text>|</xsl:text>
                [<xsl:value-of select="@ed"/>:<xsl:value-of select="@n"/>]
            </span>
        </a>  
    </xsl:template>
    
    <xsl:template match="TEI:pb[@type='edition']">
            <span class="size">
                <xsl:text>|</xsl:text>
                <xsl:value-of select="@ed"/>:<xsl:value-of select="@n"/>
            </span>
    </xsl:template>
    
        
    <xsl:template match="TEI:seg/TEI:pb">
            <span class="size">
                <xsl:text>|</xsl:text>
                <xsl:value-of select="@ed"/>:<xsl:value-of select="@n"/>
            </span>
    </xsl:template>
    
    
    <xsl:template name="delimiterComma">
        <xsl:text>, </xsl:text>
    </xsl:template>
    
    <xsl:template name="delimiterFullStop">
        <xsl:text>.</xsl:text>
    </xsl:template>
    
    
    <xsl:template match="TEI:persName">
        <a class="persName" href="ajax/getReference/{@key}" rel="ajax/getReference/{@key}">
            <xsl:apply-templates/>
        </a>
    </xsl:template>
    
    <xsl:template match="TEI:placeName">
        <!--<a class="placeName" href="ajax/getReference/{@key}" rel="ajax/getReference/{@key}">-->
            <xsl:apply-templates/>
        <!--</a>-->
    </xsl:template>
    
    <xsl:template match="TEI:rs[@type='bible']">
        <xsl:choose>
            <xsl:when test="@rend='allusion'">
                <a class="rs_bible" href="ajax/getReference/{@key}" rel="ajax/getReference/{@key}">
                    <xsl:apply-templates/>
                </a>
            </xsl:when>
            <xsl:when test="@rend='reference'">
                <a class="rs_bible" href="ajax/getReference/{@key}" rel="ajax/getReference/{@key}">
                    <xsl:apply-templates/>
                </a>
            </xsl:when>
            <xsl:when test="@rend='eg'">
                <a class="rs_bible" href="ajax/getReference/{@key}" rel="ajax/getReference/{@key}">
                    <xsl:apply-templates/>
                </a>
            </xsl:when>
            <xsl:when test="@rend='quote'">
                <a class="rs_bible" href="ajax/getReference/{@key}" rel="ajax/getReference/{@key}">
                    <xsl:apply-templates/>
                </a>
            </xsl:when>
            <xsl:when test="@rend='allusion1787'">
                <a class="rs_bible" href="ajax/getReference/{@key}" rel="ajax/getReference/{@key}">
                    <xsl:apply-templates/>
                </a>
            </xsl:when>
            <xsl:when test="@rend='reference1787'">
                <a class="rs_bible" href="ajax/getReference/{@key}" rel="ajax/getReference/{@key}">
                    <xsl:apply-templates/>
                </a>
            </xsl:when>
            <xsl:when test="@rend='eg1787'">
                <a class="rs_bible" href="ajax/getReference/{@key}" rel="ajax/getReference/{@key}">
                    <xsl:apply-templates/>
                </a>
            </xsl:when>
            <xsl:when test="@rend='quote1787'">
                <a class="rs_bible" href="ajax/getReference/{@key}" rel="ajax/getReference/{@key}">
                    <xsl:apply-templates/>
                </a>
            </xsl:when>
        </xsl:choose>
    </xsl:template>
    
    <!-- <xsl:when test="@rend='allusion'">
                    <span title="allusion til {@key}">
                        <xsl:apply-templates/>
                    </span>
                </xsl:when> -->
    
    <xsl:template match="TEI:rs[@type='myth']">
        <xsl:choose>
            <xsl:when test="//TEI:notesStmt/TEI:note[@type='noMyth']">
                <span>
                    <xsl:apply-templates/>
                </span>
            </xsl:when>
            <xsl:otherwise>
                <a class="myth rs_myth" href="ajax/getReference/{@key}" rel="ajax/getReference/{@key}">
                    <xsl:apply-templates/>
                </a>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    <!--
    <xsl:template match="TEI:rs[@type='myth']">
        <a class="myth rs_myth" href="ajax/getReference/{@key}" rel="ajax/getReference/{@key}">
            <xsl:apply-templates/>
        </a>
    </xsl:template>
    -->
    <!--
    <xsl:template match="TEI:rs[@type='title']">
        <a class="rs_title" href="ajax/getReference/{@key}" rel="ajax/getReference/{@key}">
            <xsl:apply-templates/>
        </a>
    </xsl:template>
    -->
    
    <!-- table START -->
    
    <xsl:template match="TEI:table[@type='index']">        
        <table class="index">
            <xsl:apply-templates/>
        </table>
    </xsl:template>
    
    <xsl:template match="TEI:row">
        <tr class="row">
            <xsl:apply-templates/>
        </tr>
    </xsl:template>
    
    <xsl:template match="TEI:row[@type='head']/TEI:cell">        
        <td class="cell">
            <xsl:apply-templates/>
        </td>
    </xsl:template>
    
    <xsl:template match="TEI:cell"> 
        <xsl:choose>
            <xsl:when test="@corresp">                
                <td class="cell">
                    <xsl:apply-templates/>
                </td>
            </xsl:when>
            <xsl:when test="'@corresp' and '@cols'">                
                <td class="cell" colspan="{@cols}">
                    <xsl:apply-templates/>
                </td>
            </xsl:when>
            <xsl:otherwise>
                <td class="cell">
                    <xsl:apply-templates/>
                </td>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    <!-- table END -->
    
    <!-- skilletegn START -->
    
    <xsl:template match="TEI:figure">
        <div class="{@type}">
            <hr align="center" width="50%"/>
            <xsl:apply-templates/>
        </div>
    </xsl:template>
    
    <xsl:template match="TEI:fw">
        <xsl:choose>
            <xsl:when test="@type='blank'">
                <br/>
            </xsl:when>
            <xsl:when test="@type='asterisk'">
                <div class="asterisk">
                    <xsl:text>&#x002A;</xsl:text>
                </div>
            </xsl:when>
            <xsl:when test="@type='asterisk2'">
                <div class="asterisk3">
                    <xsl:text>&#x002A;&#x2003;&#x002A;</xsl:text>
                </div>
            </xsl:when>
            <xsl:when test="@type='asterisk3'">
                <div class="asterisk3">
                    <xsl:text>&#x002A;</xsl:text>
                    <br/>
                    <xsl:text>&#x002A;&#x2003;&#x002A;</xsl:text>
                </div>
            </xsl:when>
            <xsl:when test="@type='longLine'">
                <div class="longLine">
                    <hr align="center" width="16%"/>
                </div>
            </xsl:when>
            <xsl:when test="@type='shortLine'">
                <div class="shortLine">
                    <hr align="center" width="8%"/>
                </div>
            </xsl:when>
        </xsl:choose>
    </xsl:template>
    
    <!-- skilletegn END -->

</xsl:stylesheet>
