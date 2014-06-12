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
                    <xsl:apply-templates select="//TEI:idno[@type='content']"/>
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
                                                    <xsl:when test="@xml:id='A'">
                                                        <span class="desc">
                                                            <xsl:apply-templates select="TEI:desc"/>
                                                            <xsl:text>, </xsl:text>
                                                        </span>
                                                        <span class="num">
                                                            <xsl:apply-templates select="TEI:num"/>
                                                        </span>
                                                        <xsl:text> (SJ: </xsl:text>
                                                        <xsl:apply-templates select="@n"/>
                                                        <xsl:text>)</xsl:text> 
                                                    </xsl:when>
                                                    <xsl:when test="@xml:id='B'">
                                                        <span class="desc">
                                                            <xsl:apply-templates select="TEI:desc"/>
                                                            <xsl:text>, </xsl:text>
                                                        </span>
                                                        <span class="num">
                                                            <xsl:apply-templates select="TEI:num"/>
                                                        </span>
                                                        <xsl:text> (SJ: </xsl:text>
                                                        <xsl:apply-templates select="@n"/>
                                                        <xsl:text>)</xsl:text> 
                                                    </xsl:when>
                                                    <xsl:otherwise>
                                                        <span style="color:red">
                                                            <xsl:text>TEKSTKILDE MANGLER!!!</xsl:text>
                                                        </span>
                                                    </xsl:otherwise>
                                                </xsl:choose>
                                            </td>
                                        </tr>
                                    </table>
                                </div>
                            </xsl:for-each>
                        </tr>
                        
                        <tr>
                            <xsl:if test="//TEI:listWit[@xml:id='pageNumber']/TEI:witness">
                                <xsl:text>Andre udgaver</xsl:text>
                                <xsl:for-each select="//TEI:listWit[@xml:id='pageNumber']/TEI:witness">
                                    <div class="table">
                                        <table class="witList">
                                            <tr>
                                                <td class="sigel">
                                                    <xsl:value-of select="@xml:id"/>
                                                </td>
                                                <td class="source">
                                                    <span class="desc">
                                                        <xsl:apply-templates select="TEI:desc"/>
                                                        <xsl:text> </xsl:text>
                                                    </span>
                                                    <span class="vol">
                                                        <xsl:apply-templates select="TEI:num"/>
                                                    </span>
                                                </td>
                                            </tr>
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
                        <xsl:if test="//TEI:note[@type='minusCom']"/>
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
                    
                    <div class="kolofon">
                        <xsl:if test="document(//TEI:note[@type='txr']/@target)//TEI:TEI/TEI:teiHeader/TEI:fileDesc/TEI:titleStmt/TEI:editor[@role='contributor']">
                            <xsl:text>For hjælp til tekstredegørelse takkes </xsl:text> 
                            <xsl:for-each select="document(//TEI:note[@type='txr']/@target)//TEI:TEI/TEI:teiHeader/TEI:fileDesc/TEI:titleStmt/TEI:editor[@role='contributor']">
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
    
    <xsl:template match="TEI:div1[@type]">
        <div1 class="{@type}">
            <xsl:apply-templates/>
        </div1>
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
        <xsl:choose>
            <xsl:when test="@rend and not(@xml:id)">
                <div class="head{@rend}">
                    <xsl:apply-templates/>
                </div>
            </xsl:when>
            <xsl:when test="@rend and @xml:id">
                <div class="head{@rend}" id="{@xml:id}">
                    <xsl:apply-templates/>
                </div>
            </xsl:when>
            <xsl:otherwise>
                <div>
                    <xsl:apply-templates/>
                </div>
            </xsl:otherwise>
        </xsl:choose>
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
    
    <xsl:template match="TEI:note[@type='footnote']">
        <xsl:variable name="id">
            <xsl:number count="TEI:note[@type='footnote']" level="any" from="TEI:body"/>
        </xsl:variable>
        <a id="retur{$id}" href="#note{$id}" class="footnote">
            <xsl:value-of select="$id"/>
        </a>
    </xsl:template>
    
    <xsl:template match="TEI:note[@type='footnote']" mode="foot">
        <xsl:variable name="id">
            <xsl:number count="TEI:note[@type='footnote']" level="any" from="TEI:body"/>
        </xsl:variable>
        <a id="note{$id}" href="#retur{$id}" class="footnote">
            <xsl:value-of select="$id"/>
        </a>               
        <div class="footnote">
            <xsl:apply-templates/>
        </div>
    </xsl:template>
    
    <xsl:template name="footnote">
        <xsl:if test="*[local-name()!='div']//TEI:note[@type='footnote']">
            <hr class="footLine"/>
            <xsl:apply-templates select="*[local-name()!='div']//TEI:note[@type='footnote']" mode="foot"/>
        </xsl:if>
    </xsl:template>

    <xsl:template match="TEI:body//TEI:div"> <!-- Allow div in div, KK 2014-03-19 -->
        <div class="chapter">
            <xsl:if test="@type">   
                <xsl:attribute name="name">
                    <xsl:for-each select="ancestor::TEI:div">
                        <xsl:text>&#x2003;</xsl:text>
                    </xsl:for-each>
                    <xsl:value-of select="@type"/>
               </xsl:attribute> 
            </xsl:if>
            <xsl:apply-templates select="node()[local-name()!='div']"/>
            <xsl:call-template name="footnote"/>
        </div>
        <xsl:apply-templates select="TEI:div"/>
    </xsl:template>
    
    <!-- footnote template fra linj 698 -->
    
    <xsl:template match="TEI:note[@type='footnote']">
        <xsl:variable name="id">
            <xsl:number count="TEI:note[@type='footnote']" level="any" from="TEI:text"/>
        </xsl:variable>
        <a id="retur{$id}" href="#note{$id}" class="footMarker">
            <span>
                <xsl:value-of select="$id"/>
            </span>
        </a>
    </xsl:template>
    
    <xsl:template match="TEI:note[@type='footnote']" mode="foot">
        <xsl:variable name="id">
            <xsl:number count="TEI:note[@type='footnote']" level="any" from="TEI:text"/>
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
    
    <xsl:template match="TEI:pb[@type='epiText']">
        <a class="pdf"
            href="img/{@facs}"
            onclick="return blank('epi',this.href)">
            <span class="size">
                <xsl:text>|</xsl:text>
                <xsl:value-of select="@ed"/>:<xsl:value-of select="@n"/>
            </span>
        </a>       
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
        <xsl:choose>
            <xsl:when test="//TEI:notesStmt/TEI:note[@type='noPersName']">
                <span>
                    <xsl:apply-templates/>
                </span>
            </xsl:when>
            <xsl:otherwise>
                <a class="persName" href="ajax/getReference/{@key}" rel="ajax/getReference/{@key}">
                    <xsl:apply-templates/>
                </a>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    <xsl:template match="TEI:placeName">
        <xsl:choose>
            <xsl:when test="//TEI:notesStmt/TEI:note[@type='noPlaceName']">
                <span>
                    <xsl:apply-templates/>
                </span>
            </xsl:when>
            <xsl:otherwise>
                <a class="placeName" href="ajax/getReference/{@key}" rel="ajax/getReference/{@key}">
                    <xsl:apply-templates/>
                </a>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    <xsl:template match="TEI:rs[@type='bible' and not(@subtype)]">
        <xsl:choose>
            <xsl:when test="//TEI:notesStmt/TEI:note[@type='noBible']">
                <span>
                    <xsl:apply-templates/>
                </span>
            </xsl:when>
            <xsl:when test="@rend='normForm'">
                <a class="rs_bible" href="ajax/getReference/{@key}" rel="ajax/getReference/{@key}?content={@key}">
                    <xsl:apply-templates/>
                </a>
            </xsl:when>
            <xsl:when test="@rend='allusion'">
                <a class="rs_bible" href="ajax/getReference/{@key}" rel="ajax/getReference/{@key}?content=allusion til {@key}">
                    <xsl:apply-templates/>
                </a>
            </xsl:when>
            <xsl:when test="@rend='reference'">
                <a class="rs_bible" href="ajax/getReference/{@key}" rel="ajax/getReference/{@key}?content=jf. {@key}">
                    <xsl:apply-templates/>
                </a>
            </xsl:when>
            <xsl:when test="@rend='eg'">
                <a class="rs_bible" href="ajax/getReference/{@key}" rel="ajax/getReference/{@key}?content=jf. fx {@key}">
                    <xsl:apply-templates/>
                </a>
            </xsl:when>
            <xsl:when test="@rend='quote'">
                <a class="rs_bible" href="ajax/getReference/{@key}" rel="ajax/getReference/{@key}?content={@key}">
                    <xsl:apply-templates/>
                </a>
            </xsl:when>
            <xsl:when test="@rend='allusion1787'">
                <a class="rs_bible" href="ajax/getReference/{@key}" rel="ajax/getReference/{@key}?content=allusion til {@key} (1787)">
                    <xsl:apply-templates/>
                </a>
            </xsl:when>
            <xsl:when test="@rend='reference1787'">
                <a class="rs_bible" href="ajax/getReference/{@key}" rel="ajax/getReference/{@key}?content=jf. {@key} (1787)">
                    <xsl:apply-templates/>
                </a>
            </xsl:when>
            <xsl:when test="@rend='eg1787'">
                <a class="rs_bible" href="ajax/getReference/{@key}" rel="ajax/getReference/{@key}?content=jf. fx {@key} (1787)">
                    <xsl:apply-templates/>
                </a>
            </xsl:when>
            <xsl:when test="@rend='quote1787'">
                <a class="rs_bible" href="ajax/getReference/{@key}" rel="ajax/getReference/{@key}?content={@key} (1787)">
                    <xsl:apply-templates/>
                </a>
            </xsl:when>
        </xsl:choose>
    </xsl:template>
    
    <!-- bibleStart and bibleEnd START -->
    
    <xsl:template match="TEI:rs[@type='bible' and @subtype='bibleStart']">
        <xsl:choose>
            <xsl:when test="@rend='normForm'">                
                <a class="rs_bible" href="ajax/getReference/{@key}" rel="ajax/getReference/{@key}?content={@key}">
                    &#x25BA;
                    <xsl:apply-templates/>
                </a>
            </xsl:when>
            <xsl:when test="@rend='allusion'">
                <a class="rs_bible" href="ajax/getReference/{@key}" rel="ajax/getReference/{@key}?content=allusion til {@key}">
                    &#x25BA;
                    <xsl:apply-templates/>
                </a>
            </xsl:when>
            <xsl:when test="@rend='reference'">
                <a class="rs_bible" href="ajax/getReference/{@key}" rel="ajax/getReference/{@key}?content=jf. {@key}">
                    &#x25BA;
                    <xsl:apply-templates/>
                </a>
            </xsl:when>
            <xsl:when test="@rend='eg'">
                <a class="rs_bible" href="ajax/getReference/{@key}" rel="ajax/getReference/{@key}?content=jf. fx {@key}">
                    &#x25BA;
                    <xsl:apply-templates/>
                </a>
            </xsl:when>
            <xsl:when test="@rend='quote'">
                <a class="rs_bible" href="ajax/getReference/{@key}" rel="ajax/getReference/{@key}?content={@key}">
                    &#x25BA;
                    <xsl:apply-templates/>
                </a>
            </xsl:when>
            <xsl:when test="@rend='allusion1787'">
                <a class="rs_bible" href="ajax/getReference/{@key}" rel="ajax/getReference/{@key}?content=allusion til {@key} (1787)">
                    &#x25BA;
                    <xsl:apply-templates/>
                </a>
            </xsl:when>
            <xsl:when test="@rend='reference1787'">
                <a class="rs_bible" href="ajax/getReference/{@key}" rel="ajax/getReference/{@key}?content=jf. {@key} (1787)">
                    &#x25BA;
                    <xsl:apply-templates/>
                </a>
            </xsl:when>
            <xsl:when test="@rend='eg1787'">
                <a class="rs_bible" href="ajax/getReference/{@key}" rel="ajax/getReference/{@key}?content=jf. fx {@key} (1787)">
                    &#x25BA;
                    <xsl:apply-templates/>
                </a>
            </xsl:when>
            <xsl:when test="@rend='quote1787'">
                <a class="rs_bible" href="ajax/getReference/{@key}" rel="ajax/getReference/{@key}?content={@key} (1787)">
                    &#x25BA;
                    <xsl:apply-templates/>
                </a>
            </xsl:when>
        </xsl:choose>
    </xsl:template>
    
    <xsl:template match="TEI:rs[@type='bible' and @subtype='bibleEnd']">
        <xsl:choose>
            <xsl:when test="@rend='normForm'">                
                <a class="rs_bible" href="ajax/getReference/{@key}" rel="ajax/getReference/{@key}?content={@key}">
                    <xsl:apply-templates/>
                    &#x25C4;
                </a>
            </xsl:when>
            <xsl:when test="@rend='allusion'">
                <a class="rs_bible" href="ajax/getReference/{@key}" rel="ajax/getReference/{@key}?content=allusion til {@key}">
                    <xsl:apply-templates/>
                    &#x25C4;
                </a>
            </xsl:when>
            <xsl:when test="@rend='reference'">
                <a class="rs_bible" href="ajax/getReference/{@key}" rel="ajax/getReference/{@key}?content=jf. {@key}">
                    <xsl:apply-templates/>
                    &#x25C4;
                </a>
            </xsl:when>
            <xsl:when test="@rend='eg'">
                <a class="rs_bible" href="ajax/getReference/{@key}" rel="ajax/getReference/{@key}?content=jf. fx {@key}">
                    <xsl:apply-templates/>
                    &#x25C4;
                </a>
            </xsl:when>
            <xsl:when test="@rend='quote'">
                <a class="rs_bible" href="ajax/getReference/{@key}" rel="ajax/getReference/{@key}?content={@key}">
                    <xsl:apply-templates/>
                    &#x25C4;
                </a>
            </xsl:when>
            <xsl:when test="@rend='allusion1787'">
                <a class="rs_bible" href="ajax/getReference/{@key}" rel="ajax/getReference/{@key}?content=allusion til {@key} (1787)">
                    <xsl:apply-templates/>
                    &#x25C4;
                </a>
            </xsl:when>
            <xsl:when test="@rend='reference1787'">
                <a class="rs_bible" href="ajax/getReference/{@key}" rel="ajax/getReference/{@key}?content=jf. {@key} (1787)">
                    <xsl:apply-templates/>
                    &#x25C4;
                </a>
            </xsl:when>
            <xsl:when test="@rend='eg1787'">
                <a class="rs_bible" href="ajax/getReference/{@key}" rel="ajax/getReference/{@key}?content=jf. fx {@key} (1787)">
                    <xsl:apply-templates/>
                    &#x25C4;
                </a>
            </xsl:when>
            <xsl:when test="@rend='quote1787'">
                <a class="rs_bible" href="ajax/getReference/{@key}" rel="ajax/getReference/{@key}?content={@key} (1787)">
                    <xsl:apply-templates/>
                    &#x25C4;
                </a>
            </xsl:when>
        </xsl:choose>
    </xsl:template>
    
    <!-- bibleStart and bibleEnd END -->
    
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
    
    <xsl:template match="TEI:table">        
        <table class="{@type}">
            <xsl:apply-templates/>
        </table>
    </xsl:template>
    
    <xsl:template match="TEI:table[@type='index']/TEI:row">
        <tr class="index">
            <xsl:apply-templates/>
        </tr>
    </xsl:template>
    
    <xsl:template match="TEI:table[@type='index']/TEI:row/TEI:cell">
        <xsl:variable name="chp-id">
            <xsl:for-each select="//TEI:div[TEI:head[@xml:id=current()/../@corresp]]"> <!-- should be 1 at most -->
                <xsl:number level="any"/>
            </xsl:for-each>
        </xsl:variable>
        <td class="index">
            <a class="index" onclick="currentChapter={$chp-id+count(//TEI:front[@rend])};gotoChapter(currentTextId,currentChapter)"> <!-- title="Kap.nr.{$chp-id}+{count(//TEI:front[@rend])}"-->
                <xsl:apply-templates/>
            </a>
        </td>
        
    </xsl:template>
    
    <xsl:template match="TEI:table[@type='plain']/TEI:row">
        <tr class="plain">
            <xsl:apply-templates/>
        </tr>
    </xsl:template>
    
    <xsl:template match="TEI:table[@type='synopsis']/TEI:row">
        <tr class="synopsis">
            <xsl:apply-templates/>
        </tr>
    </xsl:template>
    
    <xsl:template match="TEI:table[@type='subscription']/TEI:row">
        <tr class="subscription">
            <xsl:apply-templates/>
        </tr>
    </xsl:template>
    
    <!--
    <xsl:template match="TEI:row[@type='head']/TEI:cell">        
        <td class="cell">
            <xsl:apply-templates/>
        </td>
    </xsl:template>
   
    
    <xsl:template match="TEI:cell">
        <xsl:choose>
            <xsl:when test="@corresp">
                <td class="{@rend}">
                    <a class="index">
                        <xsl:apply-templates/>
                    </a>
                </td>
            </xsl:when>
            <xsl:when test="@cols">
                <td class="{@rend}" colspan="{@cols}">
                    <a class="index" href="#{@target}">
                        <xsl:apply-templates/>
                    </a>
                </td>
            </xsl:when>
            <xsl:when test="@n">
                <td>
                    <span class="number">
                        <xsl:value-of select="@n"/>
                        &#x2003;
                    </span>
                    <xsl:apply-templates/>
                </td>
            </xsl:when>
            <xsl:otherwise>
                <td class="{@rend}">
                    <xsl:apply-templates/>
                </td>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
     -->
    
    <!-- table END -->
    
    <!-- skilletegn START -->
      
    
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
    
    <!-- illustationer START -->
    
    <xsl:template match="TEI:figure">
        <xsl:choose>
            <xsl:when test="@type='imageMyth'">
                <div class="imageMyth">
                    <div class="imageMythHead">
                        <xsl:apply-templates select="TEI:head"/>
                    </div>
                    <div>
                        <img src="img/{TEI:graphic/@url}" width="100%" alt="Sorry!"/>
                    </div>
                    <div class="imageMythFigDisc">
                        <xsl:apply-templates select="TEI:figDesc"/>
                    </div>
                </div>
            </xsl:when>
            <xsl:when test="@type='longLine'">
                <hr align="center" width="40%"/>
            </xsl:when>
            <xsl:when test="@type='shortLine'">
                <hr align="center" width="25%"/>
            </xsl:when>
        </xsl:choose>
    </xsl:template>    
    
    <xsl:template match="TEI:figure/TEI:head">
        <div class="image_head">
            <xsl:value-of select="text()"/>
        </div>
    </xsl:template>
    
    <xsl:template match="TEI:figure/TEI:figDesc">
        <div class="image_desc">
            <xsl:value-of select="text()"/>
        </div>
    </xsl:template>

    <xsl:template match="TEI:figure/TEI:graphic">
        <img class="imageMyth" src="img/{@url}"/>
    </xsl:template>
    
    <!-- illustrationer END -->
    
    <!-- drama START -->
    
    <xsl:template match="TEI:note[@type='drama']">
        <xsl:choose>
            <xsl:when test="@rendition='set' and @rend">
                <div class="{@rendition}_{@rend}">
                    <xsl:apply-templates/>
                </div>
            </xsl:when>
        </xsl:choose>
    </xsl:template>
    
    <xsl:template match="TEI:table[@type='cast']/TEI:row">
        <tr class="hat">
            <xsl:apply-templates/>
        </tr>
    </xsl:template>
    
    <xsl:template match="TEI:table[@type='cast']/TEI:head">
        <div class="cast">
            <xsl:apply-templates/>
        </div>
    </xsl:template>
    
    <xsl:template match="TEI:table[@type='cast']/TEI:row/TEI:cell">
        <xsl:choose>
            <xsl:when test="@rows">
                <td class="{@rend}" rowspan="{@rows}">
                    <xsl:apply-templates/>
                </td>
            </xsl:when>
            <xsl:when test="@cols">
                <td class="{@rend}" colspan="{@cols}">
                    <xsl:apply-templates/>
                </td>
            </xsl:when>
            <xsl:otherwise>
                <td class="{@rend}">
                    <xsl:apply-templates/>
                </td>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    <xsl:template match="TEI:span">
        <xsl:choose>
            <xsl:when test="@rend='2rows'">
                <span style="font-size:300%">
                    <xsl:apply-templates/>
                </span>
            </xsl:when>
        </xsl:choose>
    </xsl:template>
    
    <!-- drama END -->
    
    <!-- back START -->  
    
    <xsl:template match="TEI:back//TEI:div"> <!-- div i div i back, KSR 2014.06.12 -->
        <div class="chapter">
            <xsl:if test="@type">   
                <xsl:attribute name="name">
                    <xsl:for-each select="ancestor::TEI:div">
                        <xsl:text>&#x2003;</xsl:text>
                    </xsl:for-each>
                    <xsl:value-of select="@type"/>
               </xsl:attribute> 
            </xsl:if>
            <xsl:apply-templates select="node()[local-name()!='div']"/>
            <xsl:call-template name="footnote"/>
        </div>
        <xsl:apply-templates select="TEI:div"/>
    </xsl:template>
    
    <xsl:template match="TEI:table">        
        <table class="{@xml:id}">
            <xsl:apply-templates/>
        </table>
    </xsl:template>
    
    <xsl:template match="TEI:table[@xml:id='corrigenda']/TEI:row">
        <tr class="corrigenda">
            <xsl:apply-templates/>
        </tr>
    </xsl:template>
    
    <xsl:template match="TEI:table[@xml:id='corrigenda']/TEI:row/TEI:cell">
        <xsl:choose>
            <xsl:when test="@rows">
                <td class="{@rend}" rowspan="{@rows}">
                    <xsl:apply-templates/>
                </td>
            </xsl:when>
            <xsl:when test="@cols">
                <td class="{@rend}" colspan="{@cols}">
                    <xsl:apply-templates/>
                </td>
            </xsl:when>
            <xsl:otherwise>
                <td class="corrigenda">
                    <xsl:apply-templates/>
                </td>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    <!-- back END -->

</xsl:stylesheet>
