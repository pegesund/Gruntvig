<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet 
    xmlns:TEI="http://www.tei-c.org/ns/1.0" 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    version="1.0">
    
    <!--
        Kim Steen Ravn:
        2012.06.06: started
        2012.07.24: hi-template
    -->

    <xsl:template match="TEI:TEI">
        
        <html>
            <head>
                <link rel="stylesheet" href="regListCSS.css" type="text/css"/>
                <title>
                    <xsl:apply-templates select="//TEI:title"/>
                </title>
            </head>
            <body>
                
                <div class="head">
                    <xsl:apply-templates select="//TEI:title"/>
                </div>
                
                <xsl:apply-templates select="TEI:text"/>
                
            </body>
        </html>
        
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
    
    <xsl:template match="TEI:row">
        <tr class="row">
            <xsl:apply-templates/>
        </tr>
    </xsl:template>
    
    <xsl:template match="TEI:cell>
        <td class="simple">
            <a href="{@corresp}" target="_blank" class="reg">
                <xsl:apply-templates/>
            </a>
        </td>
    </xsl:template>
    
    <xsl:template match="TEI:hi">
        <span class="{@rend}">
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    
</xsl:stylesheet>