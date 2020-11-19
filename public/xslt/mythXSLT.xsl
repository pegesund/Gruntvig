<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet 
    xmlns:TEI="http://www.tei-c.org/ns/1.0" 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    version="1.0"
    exclude-result-prefixes="#all"
    >
  <!-- must we have this exclude-result-prefixes="#all" ? -->

<!-- KSR: 2011.11.03
     KK:  2014-04-29 
     KK:  2016-09-26 Introduction of read-more in pop-ups -->
    
    <xsl:template match="TEI:TEI">
        <div>
            <xsl:apply-templates select="//TEI:row">
                <xsl:sort lang="da"/>
                    <!--xsl:sort select="translate(concat(TEI:cell[@rend='normForm'], TEI:cell[@rend='epithet'], TEI:cell[@rend='latin'], TEI:cell[@rend='greek'], TEI:cell[@rend='pseudoEpithet']), 'æøåÆØÅ', '{|}{|}')"/-->
            </xsl:apply-templates>
        </div>
    </xsl:template>
       
    <xsl:template match="TEI:row">
        <div class="row myth" id="{@xml:id}">
          <xsl:apply-templates select="TEI:cell[1]"/> <!-- indgang: normForm, epithet, e.lign. standardpost -->
          <xsl:apply-templates select="TEI:cell[@rend='popUp']"/>    <!-- immediately displayed pop-up text -->
          <xsl:if
            test="TEI:cell[@rend='encyc' or @rend='orthography'] or //TEI:row[@sameAs=current()/@xml:id] or not(TEI:cell[@rend='normForm'])">
            <!-- if there is anything more to show -->
            <div class="app"> <!-- cmp. comXSLT.xsl line 450-456 -->
              <a class="readMore" onclick="$(this).next().slideToggle('slow')">
                Læs mere</a>
              <!-- not to be displayed in myth base -->
              <!-- @onclick is bound statically here as this popUp-text is not generated when $(".plus")...click() is called from newReader.js (line 27) -->
              <div class="appInvisible">
                <!-- to become displayed in pop-up -->
              <xsl:choose>
                <xsl:when test="not(TEI:cell[@rend='normForm'])"> <!-- referencepost -->
                  <xsl:call-template name="orthography"/>
                  <xsl:for-each select="//TEI:row[@xml:id=current()/@sameAs]">
                    <xsl:apply-templates select="TEI:cell[@rend='popUp']"/>
                    <xsl:apply-templates select="TEI:cell[@rend='encyc']"/>
                    <xsl:call-template name="orthography"/>
                  </xsl:for-each>
                </xsl:when>
                <xsl:otherwise>
                  <!-- standardpost -->
                <xsl:apply-templates select="TEI:cell[@rend='encyc']"/>
                <xsl:call-template name="orthography"/>
                <xsl:if
                  test="//TEI:row[@sameAs=current()/@xml:id and TEI:cell[@rend='saxo']]">
                  <div>
                    <i>
                      <xsl:text>Latinsk form: </xsl:text>
                    </i>
                    <xsl:for-each
                      select="//TEI:row[@sameAs=current()/@xml:id and TEI:cell[@rend='saxo']]">
                      <span>
                        <xsl:value-of select="./TEI:cell[@rend='saxo']"/>
                        <xsl:call-template name="delimiter"/>
                      </span>
                    </xsl:for-each>
                  </div>
                </xsl:if>
                <xsl:if
                  test="//TEI:row[@sameAs=current()/@xml:id and TEI:cell[@rend='epithet']]">
                  <div>
                    <i>
                      <xsl:text>Kaldes også: </xsl:text>
                    </i>
                    <xsl:for-each
                      select="//TEI:row[@sameAs=current()/@xml:id and TEI:cell[@rend='epithet']]">
                      <span>
                        <xsl:value-of select="./TEI:cell[@rend='epithet']"/>
                        <xsl:call-template name="delimiter"/>
                      </span>
                    </xsl:for-each>
                  </div>
                </xsl:if>
                <xsl:if
                  test="//TEI:row[@sameAs=current()/@xml:id and TEI:cell[@rend='pseudoEpithet']]">
                  <div>
                    <i>
                      <xsl:text>Benævnes også: </xsl:text>
                    </i>
                    <xsl:for-each
                      select="//TEI:row[@sameAs=current()/@xml:id and TEI:cell[@rend='pseudoEpithet']]">
                      <span>
                        <xsl:value-of select="./TEI:cell[@rend='pseudoEpithet']"/>
                        <xsl:call-template name="delimiter"/>
                      </span>
                    </xsl:for-each>
                  </div>
                </xsl:if>
                    <xsl:if
                        test="//TEI:row[@sameAs=current()/@xml:id and TEI:cell[@rend='latin']]">
                        <div>
                            <i>
                                <xsl:text>I romersk mytologi: </xsl:text>
                            </i>
                            <xsl:for-each
                                select="//TEI:row[@sameAs=current()/@xml:id and TEI:cell[@rend='latin']]">
                                <span>
                                    <xsl:value-of select="./TEI:cell[@rend='latin']"/>
                                    <xsl:call-template name="delimiter"/>
                                </span>
                            </xsl:for-each>
                        </div>
                    </xsl:if>
                    <xsl:if
                        test="//TEI:row[@sameAs=current()/@xml:id and TEI:cell[@rend='greek']]">
                        <div>
                            <i>
                                <xsl:text>I græsk mytologi: </xsl:text>
                            </i>
                            <xsl:for-each
                                select="//TEI:row[@sameAs=current()/@xml:id and TEI:cell[@rend='greek']]">
                                <span>
                                    <xsl:value-of select="./TEI:cell[@rend='greek']"/>
                                    <xsl:call-template name="delimiter"/>
                                </span>
                            </xsl:for-each>
                        </div>
                    </xsl:if>
                </xsl:otherwise>
              </xsl:choose>
              </div>
            </div>
          </xsl:if>
        </div>
    </xsl:template>
    
    <xsl:template match="TEI:cell[@rend='edit']"/>
    
    <xsl:template name="orthography">
        <xsl:if test="TEI:cell[@rend='orthography']">
            <div>
                <i>
                    <xsl:text>Staves også: </xsl:text>
                </i>
                <xsl:for-each select="TEI:cell[@rend='orthography']">
                    <xsl:apply-templates select="."/>
                </xsl:for-each>
                <xsl:text>.</xsl:text>
            </div>
        </xsl:if>
    </xsl:template>
    
    <xsl:template match="TEI:cell[@rend='orthography']">
        <span class="orthography">
            <xsl:apply-templates/>
            <xsl:if test="following-sibling::TEI:cell[@rend='orthography']">
                <xsl:choose>
                    <xsl:when test="following-sibling::TEI:cell[@rend='orthography'][position()!=last()]">
                        <xsl:call-template name="delimiterKomma"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:text> eller </xsl:text>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:if>
        </span>
    </xsl:template>
    
    <xsl:template match="TEI:cell[@rend='normForm']">
        <div class="{@rend}">
            <xsl:apply-templates/>
        </div>
    </xsl:template>
    
    <xsl:template match="TEI:cell[@rend='popUp' or @rend='encyc']">
        <div class="{@rend}">
            <xsl:apply-templates/>
            <xsl:choose>
                <xsl:when test="TEI:cell[@rend='popUp' or @rend='encyc']/TEI:addName[@type='patronym']">
                    <xsl:value-of select="."/>
                </xsl:when>
            </xsl:choose>
        </div>
    </xsl:template>
    
    <xsl:template match="TEI:cell[@rend='epithet' or @rend='latin' or @rend='greek' or @rend='pseudoEpithet' or @rend='saxo']"> <!-- referencepost -->
        <div class="{@rend} popUp">
            <xsl:variable name="sameAs" select="../@sameAs"/>
            <xsl:apply-templates/>
            <span class="sameAs">
                <xsl:if test="@rend='latin' or @rend='saxo'">
                    <xsl:text>, latinsk navn for </xsl:text>
                </xsl:if>   
                <xsl:if test="@rend='greek'">
                    <xsl:text>, græsk navn for </xsl:text>
                </xsl:if>   
                <xsl:if test="@rend='epithet' or @rend='pseudoEpithet'">
                    <xsl:text>, andet navn for </xsl:text>
                </xsl:if>   
                <a href="myter#{$sameAs}" style="display:none">&#160;<!-- milestone: adopted for entry in register; not to be used in popUp --> </a>
                    <xsl:apply-templates select="//TEI:row[@xml:id=$sameAs]/TEI:cell[@rend='normForm']/text()"/>
            </span>
        </div>
    </xsl:template>
    
    <xsl:template name="delimiter">
        <xsl:choose>
            <xsl:when test="position()=last()">
                <xsl:text>.</xsl:text>
            </xsl:when>
            <xsl:when test="position()=last()-1">
                <xsl:text> eller </xsl:text>
            </xsl:when>
            <xsl:otherwise>
                <xsl:text>, </xsl:text>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    <!--xsl:template name="delimiter">
        <xsl:choose>
            <xsl:when test="position()=1">
                <xsl:text> </xsl:text>
            </xsl:when>
            <xsl:when test="position()=1 and position()=last">
                <xsl:text>.</xsl:text>
            </xsl:when>
            <xsl:when test="position()=last()">
                <xsl:text>.</xsl:text>
            </xsl:when>
            <xsl:when test="position()=last()-1">
                <xsl:text> eller </xsl:text>
            </xsl:when>
            <xsl:otherwise>
                <xsl:text>.</xsl:text>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template-->
    
    <xsl:template name="delimiterKomma">
        <xsl:if test="following-sibling::TEI:cell[@rend='orthography']">
            <xsl:text>, </xsl:text>
        </xsl:if>
    </xsl:template>
    
    <xsl:template match="TEI:hi">
        <span class="{@rend}">
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    
    <xsl:template name="fullStop">
        <xsl:if test="following-sibling::TEI:cell[@rend='orthography'][position()=last()]">
            <xsl:text>.</xsl:text>
        </xsl:if>
        <xsl:if test="TEI:cell[@rend='latin' or @rend='greek' or @rend='saxo'][position()=last()]">
            <xsl:text>.</xsl:text>
        </xsl:if>
    </xsl:template>

</xsl:stylesheet>