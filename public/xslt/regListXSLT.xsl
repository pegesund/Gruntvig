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
                
                <!--<xsl:apply-templates select="TEI:text"/>-->
                
                
                <xsl:for-each select="//TEI:list">
                    <xsl:sort select="TEI:head"/>
                    <div class="regList">
                        <xsl:value-of select="TEI:head"/>
                    </div>
                    <ul>
                        <xsl:for-each select="TEI:item">
                            <a href="img/{@corresp}" target="_blank" class="reg" onclick="return blank('vejledning',this.href)">
                                <li class="simple">
                                    <xsl:apply-templates/>
                                </li>
                            </a>
                        </xsl:for-each>
                    </ul>
                </xsl:for-each>
            </body>
        </html>
        
    </xsl:template>
    
    <xsl:template match="TEI:hi">
        <span class="{@rend}">
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    
</xsl:stylesheet>