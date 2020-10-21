<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:TEI="http://www.tei-c.org/ns/1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

    <!-- KSR: 2011.05.11 -->
    <!-- NHB: 2013.01.02 -->

    <xsl:template match="TEI:TEI">

        <html>
            <head>
                 <link rel="stylesheet" href="https://prometheus.statsbiblioteket.dk/gvData/css/bookInventory1839CSS.css" type="text/css"/>
                <title>
                    <xsl:apply-templates
                        select="TEI:teiHeader/TEI:text/TEI:body/TEI:div[@type=starts-with(current(), 'bookInventory')]"/>
                </title>
            </head>
            <body>
                <xsl:apply-templates select="TEI:text"/>
            </body>
        </html>

    </xsl:template>

    <xsl:template match="TEI:head[@type='bookInventory']">
        <div class="bookInventory">
            <xsl:apply-templates/>
        </div>
        <div class="kbSignatur">
            <xsl:text>Det Kongelige Bibliotek,</xsl:text>
        </div>
        <div class="kbSignatur">
            <xsl:text>katalogsignatur: </xsl:text>
            <xsl:value-of select="//TEI:title[@key='KBsKatalogsignatur']"/>
        </div>
    </xsl:template>

    <xsl:template match="TEI:p">
        <xsl:if test="preceding::TEI:div[@type='bookInventory']">
            <div class="frontPage">
                <xsl:apply-templates/>
            </div>
        </xsl:if>
        <xsl:if test="preceding::TEI:div[@type='bookInventory1839']">
            <p class="{@rend}">
                    <xsl:apply-templates/>
                </p>
        </xsl:if>
    </xsl:template>
    <xsl:template match="TEI:lb">
        <br/>
    </xsl:template>

    <xsl:template match="TEI:p[@rend='translator']">
        <div class="translator">
            <xsl:text>(oversat af </xsl:text>
            <xsl:apply-templates/>
            <xsl:text>)</xsl:text>
        </div>
    </xsl:template>

    <xsl:template match="TEI:hi">
        <span class="{@rend}">
            <xsl:apply-templates/>
        </span>
    </xsl:template>

    <xsl:template match="TEI:table">
        <table>
            <xsl:apply-templates/>
        </table>
    </xsl:template>

    <xsl:template match="TEI:head">
        <div class="{@rend}">
            <xsl:apply-templates/>
        </div>
    </xsl:template>



    <xsl:template match="TEI:row[not(@type='addition')]">
        <tr class="row" id="{@xml:id}">
            <xsl:apply-templates select="TEI:cell"/>
        </tr>
    </xsl:template>


    <!--bookInventory1805-celler-->
    <xsl:template match="TEI:cell[@type='nr' and preceding::TEI:div[@type='bookInventory']]">
        <td class="nr">
            <xsl:apply-templates/>
        </td>
    </xsl:template>
    
    <xsl:template match="TEI:cell[@type='title' and  preceding::TEI:div[@type='bookInventory']]">
        <td class="nr">
            <xsl:apply-templates/>
        </td>
    </xsl:template>
    
    <xsl:template match="TEI:cell[@type='add' and  preceding::TEI:div[@type='bookInventory']]">
        <td class="nr">
            <xsl:if test="string-length()=0">
                <xsl:text> </xsl:text>
            </xsl:if>
            <xsl:apply-templates/>
        </td>
    </xsl:template>
    
    
    <xsl:template match="TEI:note[@type='titleNorm' and  preceding::TEI:div[@type='bookInventory']]">
        <td class="titleNorm">
            <xsl:apply-templates/>
        </td>
    </xsl:template>
    
    <xsl:template match="TEI:note[@type='author' and  preceding::TEI:div[@type='bookInventory']]">
        <span class="authorNorm">
            <xsl:apply-templates/>
            <xsl:call-template name="conjunction"/>
        </span>
    </xsl:template>
    
    <xsl:template match="TEI:note[@type='translator' and  preceding::TEI:div[@type='bookInventory']]">
        <td class="translatorNorm">
            <xsl:apply-templates/>
        </td>
    </xsl:template>
    
    <xsl:template match="TEI:note[@type='title' and  preceding::TEI:div[@type='bookInventory']]">
        <td class="titleNorm">
            <xsl:if test="string-length()=0">
                <xsl:text>[ikke identificeret]</xsl:text>
            </xsl:if>
            <xsl:apply-templates/>
        </td>
    </xsl:template>
    
    <xsl:template match="TEI:note[@type='year' and  preceding::TEI:div[@type='bookInventory']]">
        <td class="yearNorm">
            <xsl:if test="string-length()=0">
                <xsl:text> </xsl:text>
            </xsl:if>
            <xsl:apply-templates/>
        </td>
    </xsl:template>
    
    <xsl:template match="TEI:note[@type='place' and  preceding::TEI:div[@type='bookInventory']]">
        <td class="placeNorm">
            <xsl:if test="string-length()=0">
                <xsl:text>[uden sted]</xsl:text>
            </xsl:if>
            <xsl:apply-templates/>
        </td>
    </xsl:template>
    
    <xsl:template name="conjunction">
        <xsl:if test="following-sibling::TEI:note[@type='author' and  preceding::TEI:div[@type='bookInventory']]">;</xsl:if>
    </xsl:template>
    
    <!--bookInventory1839-celler-->

    <xsl:template match="TEI:cell[position()=1]">
        <!-- forfin testen: "and parent::TEI:row", den skal frasortere transcripts -->
        <td class="{@type}">
            
                <xsl:call-template name="noBrackets"/>
            
        </td>
        
    </xsl:template>
    
    <xsl:template match="TEI:cell[position()=2 and preceding::TEI:div[@type='bookInventory1839']]">
        <td class="{@type}">
            <xsl:call-template name="noBrackets"/>
        </td>
    </xsl:template>

    <xsl:template match="TEI:cell[position()=3 and preceding::TEI:div[@type='bookInventory1839']]">
        <td class="{@type}">
            <xsl:call-template name="noBrackets"/>
        </td>
    </xsl:template>

    <xsl:template match="TEI:cell[position()=4 and preceding::TEI:div[@type='bookInventory1839']]">
        <td class="{@type}">
            <xsl:call-template name="noBrackets"/>
        </td>
    </xsl:template>

    <xsl:template match="TEI:cell[position()=5 and preceding::TEI:div[@type='bookInventory1839']]">
        <td class="{@type}"><!-- rettet fra span-->
            <xsl:call-template name="noBrackets"/>
        </td>
    </xsl:template>

    <xsl:template match="TEI:cell[position()=6 and preceding::TEI:div[@type='bookInventory1839']]">
        <td class="{@type}">
            <xsl:call-template name="noBrackets"/>
        </td>
    </xsl:template>

    <xsl:template match="TEI:cell[position()=7 and preceding::TEI:div[@type='bookInventory1839']]">
        <td class="{@type}">
            <xsl:call-template name="noBrackets"/>
        </td>
    </xsl:template>

    <xsl:template match="TEI:cell[position()=8 and preceding::TEI:div[@type='bookInventory1839']]">
        <td class="{@type}">
            <xsl:call-template name="noBrackets"/>
        </td>
    </xsl:template>

    <xsl:template match="TEI:cell[position()=9 and preceding::TEI:div[@type='bookInventory1839']]">
        <td class="{@type}">
            <xsl:call-template name="noBrackets"/>
        </td>
    </xsl:template>

    <xsl:template match="TEI:cell[position()=10 and preceding::TEI:div[@type='bookInventory1839']]">
        <td class="{@type}">
            <xsl:call-template name="noBrackets"/>
        </td>
    </xsl:template>
    
    <xsl:template match="TEI:cell[position()=11 and preceding::TEI:div[@type='bookInventory1839']]"><!--hoejeste antal celler i Bogfortegnelse 1839 er 11-->
        <td class="{@type}">
            <xsl:call-template name="noBrackets"/>
        </td>
    </xsl:template>
    
    
    <xsl:template match="TEI:note[@type='pageNumber']"><!-- anvendes kun i Bogfortegnelse 1839 -->
        <tr>
            <td class="{@type}"><!-- ændret fra p til td. Virker fint indtil s. 16. Tjek html -->
            <xsl:text>[s.] </xsl:text>
            <xsl:apply-templates/>
        </td>
        </tr>
    </xsl:template>
    <!-- slut bookInventory1839-celler -->
    
    

<xsl:template name="noBrackets">
    <xsl:if test="not(@type='supplement' or ../TEI:row[@type='transcript'])"><!-- prøv evt. med parent i stedet for ../-->
    <xsl:choose>
        <xsl:when test="starts-with(current(), '[')"><!-- hvis det første bogstav er en kantet parentes ([, eng.: bracket), da udskrives et næsten tomt indhold, som kun har et whitespace -->
            <xsl:text> </xsl:text>
        </xsl:when>
        <xsl:when test="@rend='encapsulated'">
            <xsl:text>[</xsl:text>
            <xsl:apply-templates/>
            <xsl:text>]</xsl:text>
        </xsl:when>
        <xsl:otherwise>
            <!--<xsl:if test="../TEI:row[@type='transcript']">--><!-- tilpas xpath så transcripts udelukkes -->
                <xsl:apply-templates/>
            <!--</xsl:if>-->
        </xsl:otherwise>
    </xsl:choose>   
    </xsl:if>
    <xsl:if test="@type='supplement'">
        <xsl:apply-templates/>
    </xsl:if>
</xsl:template>
    
</xsl:stylesheet>
