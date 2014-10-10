<?xml version="1.0" encoding="UTF-8"?>
<!--
  bible_reg.xsl
  (c) Karsten Kynde 2011-10-21
  til brug for Grundtvigs Værker
-->
<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:TEI="http://www.tei-c.org/ns/1.0"
  xmlns="http://www.tei-c.org/ns/1.0">
  
  <xsl:output method="xml" omit-xml-declaration="no" encoding="UTF-8" indent="yes"/>

  <xsl:template match="/">
    <xsl:processing-instruction name="xml-stylesheet">type="text/xsl" href="bibleXSLT.xsl"</xsl:processing-instruction>
    
    <TEI>
      <teiHeader>
        <title>Bibelstedsregister</title>
        <fileDesc>
          <titleStmt>
            <author>xxx</author>
          </titleStmt>
          <encodingDesc>
            <projectDesc>       
              <p>Grundtvig Centeret er oprettet den 1. januar 2009.</p>
              <p>Grundtvig Centeret arbejder med:</p>
              <p>1. En digital og kommenteret udgave af Grundtvigs værker</p>
              <p>2. En forskningsindsats på de felter, hvor Grundtvig s&#x00E6;rligt markerede sig</p>
              <p>2.a. Teologi og kirke</p>
              <p>2.b. Demokrati og folkelighed</p>
              <p>3.c. P&#x00E6;dagogik og folkeoplysning</p>
              <p>3. Videnudveksling, undervisning og formidling</p>
            </projectDesc>      
            <editorialDecl xml:id="xmlGuideLines.xml" n="0.1">Retningslinjer for xml-mærkning af Grundtvigs værker</editorialDecl>
            <editorialDecl xml:id="txtGuideLines.xml" n="0.1">Tekstkritiske retningslinjer for Grundtvigs værker</editorialDecl>
            <editorialDecl xml:id="txrGuideLines.xml" n="0.1">Retningslinjer for tekstredegørelser til Grundtvigs værker</editorialDecl>
            <editorialDecl xml:id="comGuideLines.xml" n="0.1">Retningslinjer for punktkommentarer til  Grundtvigs værker</editorialDecl>
            <editorialDecl xml:id="typoGuideLines.xml" n="0.1">Retningslinjer for gengivelse af typografiske hierarkier i Grundtvigs værker</editorialDecl>
            <editorialDecl xml:id="introGuideLines.xml" n="0.1">Retningslinjer for indledninger til Grundtvigs værker</editorialDecl>
          </encodingDesc>
          <revisionDesc>
            <change xml:id="" who="" when=""></change>
          </revisionDesc>
        </fileDesc>
      </teiHeader>
    
    <text>
      
      <!-- GT -->
      
      <TEI:div xml:id="_1_Mos">
        <xsl:apply-templates select="//TEI:rs[starts-with(@key,'1 Mos')]">
          <xsl:sort select="@key"/>
        </xsl:apply-templates>
      </TEI:div>
      <TEI:div xml:id="_2_Mos">
        <xsl:apply-templates select="//TEI:rs[starts-with(@key,'2 Mos')]">
          <xsl:sort select="@key"/>
        </xsl:apply-templates>
      </TEI:div>
      <TEI:div xml:id="_3_Mos">
        <xsl:apply-templates select="//TEI:rs[starts-with(@key,'3 Mos')]">
          <xsl:sort select="@key"/>
        </xsl:apply-templates>
      </TEI:div>
      <TEI:div xml:id="_4_Mos">
        <xsl:apply-templates select="//TEI:rs[starts-with(@key,'4 Mos')]">
          <xsl:sort select="@key"/>
        </xsl:apply-templates>
      </TEI:div>
      <TEI:div xml:id="_5_Mos">
        <xsl:apply-templates select="//TEI:rs[starts-with(@key,'5 Mos')]">
          <xsl:sort select="@key"/>
        </xsl:apply-templates>
      </TEI:div>
      <TEI:div xml:id="Jos">
        <xsl:apply-templates select="//TEI:rs[starts-with(@key,'Jos')]">
          <xsl:sort select="@key"/>
        </xsl:apply-templates>
      </TEI:div>
      <TEI:div xml:id="Dom">
        <xsl:apply-templates select="//TEI:rs[starts-with(@key,'Dom')]">
          <xsl:sort select="@key"/>
        </xsl:apply-templates>
      </TEI:div>
      <TEI:div xml:id="Ruth">
        <xsl:apply-templates select="//TEI:rs[starts-with(@key,'Ruth')]">
          <xsl:sort select="@key"/>
        </xsl:apply-templates>
      </TEI:div>
      <TEI:div xml:id="_1_Sam">
        <xsl:apply-templates select="//TEI:rs[starts-with(@key,'1 Sam')]">
          <xsl:sort select="@key"/>
        </xsl:apply-templates>
      </TEI:div>
      <TEI:div xml:id="_2_Sam">
        <xsl:apply-templates select="//TEI:rs[starts-with(@key,'2 Sam')]">
          <xsl:sort select="@key"/>
        </xsl:apply-templates>
      </TEI:div>
      <TEI:div xml:id="_1_Kong">
        <xsl:apply-templates select="//TEI:rs[starts-with(@key,'1 Kong')]">
          <xsl:sort select="@key"/>
        </xsl:apply-templates>
      </TEI:div>
      <TEI:div xml:id="_2_Kong">
        <xsl:apply-templates select="//TEI:rs[starts-with(@key,'2 Kong')]">
          <xsl:sort select="@key"/>
        </xsl:apply-templates>
      </TEI:div>
      <TEI:div xml:id="_1_Krøn">
        <xsl:apply-templates select="//TEI:rs[starts-with(@key,'1 Krøn')]">
          <xsl:sort select="@key"/>
        </xsl:apply-templates>
      </TEI:div>
      <TEI:div xml:id="_2_Krøn">
        <xsl:apply-templates select="//TEI:rs[starts-with(@key,'2 Krøn')]">
          <xsl:sort select="@key"/>
        </xsl:apply-templates>
      </TEI:div>
      <TEI:div xml:id="Ezra">
        <xsl:apply-templates select="//TEI:rs[starts-with(@key,'Ezra')]">
          <xsl:sort select="@key"/>
        </xsl:apply-templates>
      </TEI:div>
      <TEI:div xml:id="Neh">
        <xsl:apply-templates select="//TEI:rs[starts-with(@key,'Neh')]">
          <xsl:sort select="@key"/>
        </xsl:apply-templates>
      </TEI:div>
      <TEI:div xml:id="Est">
        <xsl:apply-templates select="//TEI:rs[starts-with(@key,'Est')]">
          <xsl:sort select="@key"/>
        </xsl:apply-templates>
      </TEI:div>
      <TEI:div xml:id="Job">
        <xsl:apply-templates select="//TEI:rs[starts-with(@key,'Job')]">
          <xsl:sort select="@key"/>
        </xsl:apply-templates>
      </TEI:div>
      <TEI:div xml:id="Sl">
        <xsl:apply-templates select="//TEI:rs[starts-with(@key,'Sl')]">
          <xsl:sort select="@key"/>
        </xsl:apply-templates>
      </TEI:div>
      <TEI:div xml:id="Ordsp">
        <xsl:apply-templates select="//TEI:rs[starts-with(@key,'Ordsp')]">
          <xsl:sort select="@key"/>
        </xsl:apply-templates>
      </TEI:div>
      <TEI:div xml:id="Præd">
        <xsl:apply-templates select="//TEI:rs[starts-with(@key,'Præd')]">
          <xsl:sort select="@key"/>
        </xsl:apply-templates>
      </TEI:div>
      <TEI:div xml:id="Højs">
        <xsl:apply-templates select="//TEI:rs[starts-with(@key,'Højs')]">
          <xsl:sort select="@key"/>
        </xsl:apply-templates>
      </TEI:div>
      <TEI:div xml:id="Es">
        <xsl:apply-templates select="//TEI:rs[starts-with(@key,'Es')]">
          <xsl:sort select="@key"/>
        </xsl:apply-templates>
      </TEI:div>
      <TEI:div xml:id="Jer">
        <xsl:apply-templates select="//TEI:rs[starts-with(@key,'Jer')]">
          <xsl:sort select="@key"/>
        </xsl:apply-templates>
      </TEI:div>
      <TEI:div xml:id="Klages">
        <xsl:apply-templates select="//TEI:rs[starts-with(@key,'Klages')]">
          <xsl:sort select="@key"/>
        </xsl:apply-templates>
      </TEI:div>
      <TEI:div xml:id="Ez">
        <xsl:apply-templates select="//TEI:rs[starts-with(@key,'Ez')]">
          <xsl:sort select="@key"/>
        </xsl:apply-templates>
      </TEI:div>
      <TEI:div xml:id="Dan">
        <xsl:apply-templates select="//TEI:rs[starts-with(@key,'Dan')]">
          <xsl:sort select="@key"/>
        </xsl:apply-templates>
      </TEI:div>
      <TEI:div xml:id="Hos">
        <xsl:apply-templates select="//TEI:rs[starts-with(@key,'Hos')]">
          <xsl:sort select="@key"/>
        </xsl:apply-templates>
      </TEI:div>
      <TEI:div xml:id="Joel">
        <xsl:apply-templates select="//TEI:rs[starts-with(@key,'Joel')]">
          <xsl:sort select="@key"/>
        </xsl:apply-templates>
      </TEI:div>
      <TEI:div xml:id="Am">
        <xsl:apply-templates select="//TEI:rs[starts-with(@key,'Am')]">
          <xsl:sort select="@key"/>
        </xsl:apply-templates>
      </TEI:div>
      <TEI:div xml:id="Obad">
        <xsl:apply-templates select="//TEI:rs[starts-with(@key,'Obad')]">
          <xsl:sort select="@key"/>
        </xsl:apply-templates>
      </TEI:div>
      <TEI:div xml:id="Jon">
        <xsl:apply-templates select="//TEI:rs[starts-with(@key,'Jon')]">
          <xsl:sort select="@key"/>
        </xsl:apply-templates>
      </TEI:div>
      <TEI:div xml:id="Mika">
        <xsl:apply-templates select="//TEI:rs[starts-with(@key,'Mika')]">
          <xsl:sort select="@key"/>
        </xsl:apply-templates>
      </TEI:div>
      <TEI:div xml:id="Nah">
        <xsl:apply-templates select="//TEI:rs[starts-with(@key,'Nah')]">
          <xsl:sort select="@key"/>
        </xsl:apply-templates>
      </TEI:div>
      <TEI:div xml:id="Sef">
        <xsl:apply-templates select="//TEI:rs[starts-with(@key,'Sef')]">
          <xsl:sort select="@key"/>
        </xsl:apply-templates>
      </TEI:div>
      <TEI:div xml:id="Hagg">
        <xsl:apply-templates select="//TEI:rs[starts-with(@key,'Hagg')]">
          <xsl:sort select="@key"/>
        </xsl:apply-templates>
      </TEI:div>
      <TEI:div xml:id="Zak">
        <xsl:apply-templates select="//TEI:rs[starts-with(@key,'Zak')]">
          <xsl:sort select="@key"/>
        </xsl:apply-templates>
      </TEI:div>
      <TEI:div xml:id="Mal">
        <xsl:apply-templates select="//TEI:rs[starts-with(@key,'Mal')]">
          <xsl:sort select="@key"/>
        </xsl:apply-templates>
      </TEI:div>
      
      <!-- GT apokryfer -->
      
      <TEI:div xml:id="Tob">
        <xsl:apply-templates select="//TEI:rs[starts-with(@key,'Tob')]">
          <xsl:sort select="@key"/>
        </xsl:apply-templates>
      </TEI:div>
      <TEI:div xml:id="Judit">
        <xsl:apply-templates select="//TEI:rs[starts-with(@key,'Judit')]">
          <xsl:sort select="@key"/>
        </xsl:apply-templates>
      </TEI:div>
      <TEI:div xml:id="TilfEst">
        <xsl:apply-templates select="//TEI:rs[starts-with(@key,'TilfEst')]">
          <xsl:sort select="@key"/>
        </xsl:apply-templates>
      </TEI:div>
      <TEI:div xml:id="_1_Makk">
        <xsl:apply-templates select="//TEI:rs[starts-with(@key,'1 Makk')]">
          <xsl:sort select="@key"/>
        </xsl:apply-templates>
      </TEI:div>
      <TEI:div xml:id="_2_Makk">
        <xsl:apply-templates select="//TEI:rs[starts-with(@key,'2 Makk')]">
          <xsl:sort select="@key"/>
        </xsl:apply-templates>
      </TEI:div>
      <TEI:div xml:id="Visd">
        <xsl:apply-templates select="//TEI:rs[starts-with(@key,'Visd')]">
          <xsl:sort select="@key"/>
        </xsl:apply-templates>
      </TEI:div>
      <TEI:div xml:id="Sir">
        <xsl:apply-templates select="//TEI:rs[starts-with(@key,'Sir')]">
          <xsl:sort select="@key"/>
        </xsl:apply-templates>
      </TEI:div>
      <TEI:div xml:id="ManB">
        <xsl:apply-templates select="//TEI:rs[starts-with(@key,'ManB')]">
          <xsl:sort select="@key"/>
        </xsl:apply-templates>
      </TEI:div>
      <TEI:div xml:id="Bar">
        <xsl:apply-templates select="//TEI:rs[starts-with(@key,'Bar')]">
          <xsl:sort select="@key"/>
        </xsl:apply-templates>
      </TEI:div>
      <TEI:div xml:id="JerBr">
        <xsl:apply-templates select="//TEI:rs[starts-with(@key,'JerBr')]">
          <xsl:sort select="@key"/>
        </xsl:apply-templates>
      </TEI:div>
      <TEI:div xml:id="TilfDan">
        <xsl:apply-templates select="//TEI:rs[starts-with(@key,'TilfDan')]">
          <xsl:sort select="@key"/>
        </xsl:apply-templates>
      </TEI:div>
      
      <!-- NT -->
      
      <TEI:div xml:id="Matt">
        <xsl:apply-templates select="//TEI:rs[starts-with(@key,'Matt')]">
          <xsl:sort select="@key"/>
        </xsl:apply-templates>
      </TEI:div>
      <TEI:div xml:id="Mark">
        <xsl:apply-templates select="//TEI:rs[starts-with(@key,'Mark')]">
          <xsl:sort select="@key"/>
        </xsl:apply-templates>
      </TEI:div>
      <TEI:div xml:id="Luk">
        <xsl:apply-templates select="//TEI:rs[starts-with(@key,'Luk')]">
          <xsl:sort select="@key"/>
        </xsl:apply-templates>
      </TEI:div>
      <TEI:div xml:id="Joh">
        <xsl:apply-templates select="//TEI:rs[starts-with(@key,'Joh')]">
          <xsl:sort select="@key"/>
        </xsl:apply-templates>
      </TEI:div>
      <TEI:div xml:id="ApG">
        <xsl:apply-templates select="//TEI:rs[starts-with(@key,'ApG')]">
          <xsl:sort select="@key"/>
        </xsl:apply-templates>
      </TEI:div>      
      <TEI:div xml:id="Rom">
        <xsl:apply-templates select="//TEI:rs[starts-with(@key,'Rom')]">
          <xsl:sort select="@key"/>
        </xsl:apply-templates>
      </TEI:div>
      <TEI:div xml:id="_1_Kor">
        <xsl:apply-templates select="//TEI:rs[starts-with(@key,'1 Kor')]">
          <xsl:sort select="@key"/>
        </xsl:apply-templates>
      </TEI:div>
      <TEI:div xml:id="_2_Kor">
        <xsl:apply-templates select="//TEI:rs[starts-with(@key,'2 Kor')]">
          <xsl:sort select="@key"/>
        </xsl:apply-templates>
      </TEI:div>
      <TEI:div xml:id="Gal">
        <xsl:apply-templates select="//TEI:rs[starts-with(@key,'Gal')]">
          <xsl:sort select="@key"/>
        </xsl:apply-templates>
      </TEI:div>
      <TEI:div xml:id="Ef">
        <xsl:apply-templates select="//TEI:rs[starts-with(@key,'Ef')]">
          <xsl:sort select="@key"/>
        </xsl:apply-templates>
      </TEI:div>
      <TEI:div xml:id="Fil">
        <xsl:apply-templates select="//TEI:rs[starts-with(@key,'Fil')]">
          <xsl:sort select="@key"/>
        </xsl:apply-templates>
      </TEI:div>
      <TEI:div xml:id="Kol">
        <xsl:apply-templates select="//TEI:rs[starts-with(@key,'Kol')]">
          <xsl:sort select="@key"/>
        </xsl:apply-templates>
      </TEI:div>
      <TEI:div xml:id="_1_Thess">
        <xsl:apply-templates select="//TEI:rs[starts-with(@key,'1 Thess')]">
          <xsl:sort select="@key"/>
        </xsl:apply-templates>
      </TEI:div>
      <TEI:div xml:id="_2_Thess">
        <xsl:apply-templates select="//TEI:rs[starts-with(@key,'2 Thess')]">
          <xsl:sort select="@key"/>
        </xsl:apply-templates>
      </TEI:div>
      <TEI:div xml:id="_1_Tim">
        <xsl:apply-templates select="//TEI:rs[starts-with(@key,'1 Tim')]">
          <xsl:sort select="@key"/>
        </xsl:apply-templates>
      </TEI:div>
      <TEI:div xml:id="_2_Tim">
        <xsl:apply-templates select="//TEI:rs[starts-with(@key,'2 Tim')]">
          <xsl:sort select="@key"/>
        </xsl:apply-templates>
      </TEI:div>
      <TEI:div xml:id="Tit">
        <xsl:apply-templates select="//TEI:rs[starts-with(@key,'Tit')]">
          <xsl:sort select="@key"/>
        </xsl:apply-templates>
      </TEI:div>
      <TEI:div xml:id="Filem">
        <xsl:apply-templates select="//TEI:rs[starts-with(@key,'Filem')]">
          <xsl:sort select="@key"/>
        </xsl:apply-templates>
      </TEI:div>
      <TEI:div xml:id="Hebr">
        <xsl:apply-templates select="//TEI:rs[starts-with(@key,'Hebr')]">
          <xsl:sort select="@key"/>
        </xsl:apply-templates>
      </TEI:div>
      <TEI:div xml:id="Jak">
        <xsl:apply-templates select="//TEI:rs[starts-with(@key,'Jak')]">
          <xsl:sort select="@key"/>
        </xsl:apply-templates>
      </TEI:div>
      <TEI:div xml:id="_1_Pet">
        <xsl:apply-templates select="//TEI:rs[starts-with(@key,'1 Pet')]">
          <xsl:sort select="@key"/>
        </xsl:apply-templates>
      </TEI:div>
      <TEI:div xml:id="_2_Pet">
        <xsl:apply-templates select="//TEI:rs[starts-with(@key,'2 Pet')]">
          <xsl:sort select="@key"/>
        </xsl:apply-templates>
      </TEI:div>
      <TEI:div xml:id="_1_Joh">
        <xsl:apply-templates select="//TEI:rs[starts-with(@key,'1 Joh')]">
          <xsl:sort select="@key"/>
        </xsl:apply-templates>
      </TEI:div>
      <TEI:div xml:id="_2_Joh">
        <xsl:apply-templates select="//TEI:rs[starts-with(@key,'2 Joh')]">
          <xsl:sort select="@key"/>
        </xsl:apply-templates>
      </TEI:div>
      <TEI:div xml:id="_3_Joh">
        <xsl:apply-templates select="//TEI:rs[starts-with(@key,'3 Joh')]">
          <xsl:sort select="@key"/>
        </xsl:apply-templates>
      </TEI:div>
      <TEI:div xml:id="Jud">
        <xsl:apply-templates select="//TEI:rs[starts-with(@key,'Jud')]">
          <xsl:sort select="@key"/>
        </xsl:apply-templates>
      </TEI:div>
      <TEI:div xml:id="Åb">
        <xsl:apply-templates select="//TEI:rs[starts-with(@key,'Åb')]">
          <xsl:sort select="@key"/>
        </xsl:apply-templates>
      </TEI:div>
    
    </text>
    </TEI>
  </xsl:template>

  <xsl:template match="TEI:rs|@*">
    <xsl:copy>
      <xsl:apply-templates select="@*"/>
    </xsl:copy>
  </xsl:template>

</xsl:stylesheet>
