<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

  <!-- XML template to transform Google search appliance (GSA) results in JSON, JSONP, pure HTML OR HTML + call back javascript
  ** Kishore Jonnalagedda, 06/18/2013
  ** kjonnala+gsa@gmail.com
  ** Released under Creative Commons CC BY-SA 3.0
  ** The template SearchResults.xslt is released under Creative Commons license "Attribution-ShareAlike 3.0 Unported" http://creativecommons.org/licenses/by-sa/3.0/
  ** Please feel free to improvise
  -->

  <xsl:output method="text" />

  <xsl:template match="/">
    <xsl:apply-templates select="GSP" />
  </xsl:template>

  <xsl:template match="GSP">
    <xsl:choose>
      <xsl:when test="PARAM[@name = 'callback']">
        <xsl:value-of select="PARAM[@name = 'callback']/@value" />
        <xsl:text disable-output-escaping="yes">
          ({
        </xsl:text>
      </xsl:when>
      <xsl:when test="PARAM[@name = 'htmlcallback'] and PARAM[@name = 'document_domain']">
        <![CDATA[<html>
        <head>
        <script type="text/javascript">
	        document.domain=]]><xsl:value-of select="PARAM[@name = 'document_domain']/@value" /><![CDATA[;
          parent.]]><xsl:value-of select="PARAM[@name= 'htmlcallback']/@value" /><![CDATA[ (
        ]]>
        {
      </xsl:when>
      
      <xsl:when test="PARAM[@name = 'htmlonly']">
        <![CDATA[<html>
        <head>
        <script type="text/javascript">
	        document.domain="]]><xsl:value-of select="PARAM[@name = 'document_domain']/@value" /><![CDATA[";
        </script>
        </head>
        <body>
        ]]>
        {
      </xsl:when>
      
      <xsl:otherwise>
        <xsl:text disable-output-escaping="yes">
{
        </xsl:text>
      </xsl:otherwise>
    </xsl:choose>
    <xsl:text disable-output-escaping="yes">
"query": "</xsl:text>
    <xsl:value-of select="Q" />
    <xsl:text>",</xsl:text>

    <xsl:if test="GM">
      <xsl:text disable-output-escaping="yes">
        "keymatch": [
      </xsl:text>
      <xsl:apply-templates select="GM" />
      <xsl:text>
        ],
      </xsl:text>
    </xsl:if>
    
    <xsl:if test="Synonyms">
      <xsl:text disable-output-escaping="yes">
        "synonyms": [
      </xsl:text>
      <xsl:apply-templates select="Synonyms"/>
      <xsl:text>
        ],
      </xsl:text>
    </xsl:if>
    
    <xsl:if test="Spelling">
      <xsl:text disable-output-escaping="yes">
        "spelling": [
      </xsl:text>
      <xsl:apply-templates select="Spelling"/>
      <xsl:text>
        ],
      </xsl:text>
    </xsl:if>

    <xsl:apply-templates select="RES" />

    <xsl:call-template name="results_navigation_wrapper">
      <xsl:with-param name="prev" select="RES/NB/PU" />
      <xsl:with-param name="next" select="RES/NB/NU" />
      <xsl:with-param name="view_begin" select="RES/@SN" />
      <xsl:with-param name="view_end" select="RES/@EN" />
      <xsl:with-param name="guess" select="RES/M" />
    </xsl:call-template>

    <xsl:choose>
      
      <xsl:when test="PARAM[@name = 'callback']">
        <xsl:text disable-output-escaping="yes">})</xsl:text>
      </xsl:when>
      
      <xsl:when test="PARAM[@name = 'htmlcallback']">
        <xsl:text disable-output-escaping="yes">
          <![CDATA[
});
        </script>
        </head>
        <body>
        

            </body>
          </html>
          ]]>
        </xsl:text>
      </xsl:when>

      <xsl:when test="PARAM[@name = 'htmlonly']">
        <xsl:text disable-output-escaping="yes">
          <![CDATA[
}
            </body>
          </html>
          ]]>
        </xsl:text>

      </xsl:when>
      
      <xsl:otherwise>
        <xsl:text disable-output-escaping="yes">
          }
        </xsl:text>
      </xsl:otherwise>
    </xsl:choose>

  </xsl:template>


  <!-- Results settings -->
  <xsl:template name="results_navigation_wrapper">
    <xsl:param name="prev" />
    <xsl:param name="next" />
    <xsl:param name="view_begin" />
    <xsl:param name="view_end" />
    <xsl:param name="guess" />

    <xsl:text disable-output-escaping="yes">
      "results_nav": {
      "total_results": "</xsl:text>
    <xsl:value-of select="$guess" />
    <xsl:text>",
      "results_start": "</xsl:text>
    <xsl:value-of select="$view_begin" />
    <xsl:text>",
      "results_end": "</xsl:text>
    <xsl:value-of select="$view_end" />
    <xsl:text>",
      "current_view": "</xsl:text>
    <xsl:value-of select="$view_begin - 1" />
    <xsl:text>"</xsl:text>
    <xsl:if test="/GSP/RES/NB/PU">
      <xsl:text>
        ,
        "have_prev": "1"
      </xsl:text>
    </xsl:if>
    <xsl:if test="/GSP/RES/NB/NU">
      <xsl:text>
        ,
        "have_next": "1"
      </xsl:text>
    </xsl:if>
    <xsl:text>
      }
    </xsl:text>

  </xsl:template>

  <xsl:template match="GM">
    <xsl:text disable-output-escaping="yes">
      {
    </xsl:text>
    <xsl:text disable-output-escaping="yes">	"title": "</xsl:text>
    <xsl:value-of select="GD" />
    <xsl:text disable-output-escaping="yes">",
      "url": "</xsl:text>
    <xsl:value-of select="GL" />
    <xsl:text disable-output-escaping="yes">"
      }
    </xsl:text>
    <xsl:if test="position() != last()">
      <xsl:text>
        ,
      </xsl:text>
    </xsl:if>
  </xsl:template>
  
  <xsl:template match="Synonyms">
    <xsl:for-each select="./*">
      <xsl:text disable-output-escaping="yes">"</xsl:text>
      <xsl:value-of select="." />
      <xsl:text disable-output-escaping="yes">"</xsl:text>
      <xsl:if test="position() != last()">
        <xsl:text>,</xsl:text>
      </xsl:if>
    </xsl:for-each>
  </xsl:template>
  
  <xsl:template match="Spelling">
    <xsl:for-each select="./*">
      <xsl:text disable-output-escaping="yes">"</xsl:text>
      <xsl:value-of select="." />
      <xsl:text disable-output-escaping="yes">"</xsl:text>
      <xsl:if test="position() != last()">
        <xsl:text>,</xsl:text>
      </xsl:if>
    </xsl:for-each>
  </xsl:template>

  <xsl:template match="RES">
    <xsl:text disable-output-escaping="yes">
"results": [
    </xsl:text>
    <xsl:apply-templates select="R" />
    <xsl:text disable-output-escaping="yes">
],
    </xsl:text>
  </xsl:template>

  <xsl:template match="R">
    <xsl:text disable-output-escaping="yes">
      {
    </xsl:text>
    <xsl:apply-templates select="U" />
    <xsl:apply-templates select="T" />
    <xsl:apply-templates select="S" />
    <xsl:text disable-output-escaping="yes">    "meta_tags" : [
    </xsl:text>
    <xsl:apply-templates select="MT" />
    <xsl:text disable-output-escaping="yes">
         ]
    </xsl:text>

    <xsl:apply-templates select="HAS" />
    <xsl:if test="string(@MIME)">
      <xsl:text disable-output-escaping="yes">
        ,
        "mime": "</xsl:text>
      <xsl:value-of select="@MIME" />
      <xsl:text disable-output-escaping="yes">"</xsl:text>
    </xsl:if>
    <xsl:text disable-output-escaping="yes">
      }
    </xsl:text>
    <xsl:if test="position() != last()">
      <xsl:text>
        ,
      </xsl:text>
    </xsl:if>
  </xsl:template>

  <xsl:template match="U">
    <xsl:text disable-output-escaping="yes">    "url": "</xsl:text>
    <xsl:value-of select="." />
    <xsl:text disable-output-escaping="yes">",
    </xsl:text>
  </xsl:template>

  <xsl:template match="T">
    <xsl:text disable-output-escaping="yes">    "title": "</xsl:text>
    <xsl:call-template name="replace_apos">
      <xsl:with-param name="string" select="." />
    </xsl:call-template>
    <xsl:text disable-output-escaping="yes">",
    </xsl:text>
  </xsl:template>

  <xsl:template match="S">
    <xsl:text disable-output-escaping="yes">    "summary": "</xsl:text>
    <xsl:call-template name="replace_apos">
      <xsl:with-param name="string" select="." />
    </xsl:call-template>
    <xsl:text disable-output-escaping="yes">",
    </xsl:text>
  </xsl:template>

  <xsl:template match="MT">
    <xsl:text disable-output-escaping="yes">       {
            "name": "</xsl:text>
    <xsl:value-of select="(@N)" />
    <xsl:text disable-output-escaping="yes">",
    </xsl:text>
    <xsl:text disable-output-escaping="yes">        "value": "</xsl:text>
    <xsl:call-template name="escapeQuote" />
    <xsl:text disable-output-escaping="yes">"
           }
    </xsl:text>
    <xsl:if test="position() != last()">
      <xsl:text>
        ,
      </xsl:text>
    </xsl:if>
  </xsl:template>

  <xsl:template match="HAS">
    <xsl:if test="string(C/@SZ)">
      <xsl:text disable-output-escaping="yes">
        ,
        "size": "</xsl:text>
      <xsl:value-of select="C/@SZ" />
      <xsl:text disable-output-escaping="yes">"</xsl:text>
    </xsl:if>
  </xsl:template>

  <!-- *** Find and replace *** -->
  <xsl:template name="replace_string">
    <xsl:param name="find" />
    <xsl:param name="replace" />
    <xsl:param name="string" />
    <xsl:choose>
      <xsl:when test="contains($string, $find)">
        <xsl:value-of select="substring-before($string, $find)" />
        <xsl:value-of select="$replace" />
        <xsl:call-template name="replace_string">
          <xsl:with-param name="find" select="$find" />
          <xsl:with-param name="replace" select="$replace" />
          <xsl:with-param name="string"
                          select="substring-after($string, $find)" />
        </xsl:call-template>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="$string" />
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template name="replace_apos">
    <xsl:param name="string" />
    <xsl:variable name="apos">'</xsl:variable>
    <xsl:call-template name="replace_string">
      <xsl:with-param name="string" select="$string" />
      <xsl:with-param name="find" select="$apos" />
      <xsl:with-param name="replace" select="'&amp;#39;'" />
    </xsl:call-template>
  </xsl:template>
  
  <xsl:template name="escapeQuote">
      <xsl:param name="pText" select="(@V)"/>

      <xsl:if test="string-length($pText) >0">
       <xsl:value-of select=
        "substring-before(concat($pText, '&quot;'), '&quot;')"/>

       <xsl:if test="contains($pText, '&quot;')">
        <xsl:text>\"</xsl:text>

        <xsl:call-template name="escapeQuote">
          <xsl:with-param name="pText" select=
          "substring-after($pText, '&quot;')"/>
        </xsl:call-template>
       </xsl:if>
      </xsl:if>
    </xsl:template>
</xsl:stylesheet>
