<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output method="text" encoding="UTF-8" omit-xml-declaration="yes"/>

  <xsl:variable name="linebreak">
    <xsl:text>
</xsl:text>
  </xsl:variable>

  <xsl:variable name="blankline">
    <xsl:value-of select="$linebreak"/>
    <xsl:value-of select="$linebreak"/>
  </xsl:variable>

  <xsl:variable name="sectionbreak">
    <xsl:value-of select="$linebreak"/>
    <xsl:value-of select="$linebreak"/>
    <xsl:value-of select="$linebreak"/>
  </xsl:variable>

  <xsl:template match="/">
    <xsl:apply-templates select="cv"/>
  </xsl:template>

  <xsl:template match="cv">
    <xsl:param name="indent"/>
    <xsl:value-of select="$indent"/>
    <xsl:value-of select="name"/>
    <xsl:value-of select="$blankline"/>
    <xsl:value-of select="$indent"/>
    <xsl:text>Contact Information-</xsl:text>
    <xsl:value-of select="$blankline"/>
    <xsl:value-of select="$indent"/>
    <xsl:apply-templates select="contact">
      <xsl:with-param name="indent">
	<xsl:value-of select="$indent"/>
	<xsl:text>  </xsl:text>
      </xsl:with-param>
    </xsl:apply-templates>
    <xsl:apply-templates select="section">
      <xsl:with-param name="indent" select="$indent"/>
    </xsl:apply-templates>
    <xsl:value-of select="$linebreak"/>
  </xsl:template>

  <xsl:template match="section">
    <xsl:param name="indent"/>
    <xsl:value-of select="$sectionbreak"/>
    <xsl:value-of select="$indent"/>
    <xsl:value-of select="title"/>
    <xsl:text>-</xsl:text>
    <xsl:value-of select="$linebreak"/>
    <xsl:apply-templates select="skillset|skills|school|job|project|reference|workshop|publication">
      <xsl:with-param name="indent">
	<xsl:value-of select="$indent"/>
	<xsl:text>  </xsl:text>
      </xsl:with-param>
    </xsl:apply-templates>
  </xsl:template>

  <xsl:template match="skillset">
    <xsl:param name="indent"/>
    <xsl:value-of select="$blankline"/>
    <xsl:value-of select="$indent"/>
    <xsl:value-of select="title"/>
    <xsl:text>-</xsl:text>
    <xsl:value-of select="$linebreak"/>
    <xsl:apply-templates select="skills">
      <xsl:with-param name="indent">
	<xsl:value-of select="$indent"/>
	<xsl:text>  </xsl:text>
      </xsl:with-param>
    </xsl:apply-templates>
  </xsl:template>

  <xsl:template match="skills">
    <xsl:param name="indent"/>
    <xsl:variable name="title" select="title" />
    <xsl:value-of select="$blankline"/>
    <xsl:value-of select="$indent"/>
    <xsl:value-of select="title"/>
    <xsl:text>: </xsl:text>
    <xsl:call-template name="wrap-string">
      <xsl:with-param name="str">
	<xsl:apply-templates select="skill">
	  <xsl:with-param name="separator">
	    <xsl:text>, </xsl:text>
	  </xsl:with-param>
	</xsl:apply-templates>
      </xsl:with-param>
      <xsl:with-param name="break-mark">
	<xsl:value-of select="$linebreak"/>
	<xsl:value-of select="$indent"/>
	<xsl:text>    </xsl:text>
      </xsl:with-param>
      <xsl:with-param name="wrap-col" select="80"/>
      <xsl:with-param name="pos" select="string-length($indent) + string-length($title) + 1"/>
    </xsl:call-template>
  </xsl:template>

  <xsl:template match="skill[1]">
    <xsl:value-of select="."/>
  </xsl:template>

  <xsl:template match="school[@type='graduate']">
    <xsl:param name="indent"/>
    <xsl:value-of select="$blankline"/>
    <xsl:value-of select="$indent"/>
    <xsl:value-of select="name"/>
    <xsl:text> (</xsl:text>
    <xsl:value-of select="degree"/>
    <xsl:text>):</xsl:text>
    <xsl:value-of select="$blankline"/>
    <xsl:value-of select="$indent"/>
    <xsl:text>  * </xsl:text>
    <xsl:value-of select="field"/>
    <xsl:text> (</xsl:text>
    <xsl:apply-templates select="concentration"/>
    <xsl:text>)</xsl:text>
    <xsl:value-of select="$linebreak"/>
    <xsl:value-of select="$indent"/>
    <xsl:text>  * Advisor: </xsl:text>
    <xsl:value-of select="advisor"/>
    <xsl:value-of select="$linebreak"/>
    <xsl:apply-templates select="thesis">
      <xsl:with-param name="indent">
	<xsl:value-of select="$indent"/>
	<xsl:text>  </xsl:text>
      </xsl:with-param>
    </xsl:apply-templates>
    <xsl:apply-templates select="comment">
      <xsl:with-param name="indent">
	<xsl:value-of select="$indent"/>
	<xsl:text>  </xsl:text>
      </xsl:with-param>
    </xsl:apply-templates>
  </xsl:template>

  <xsl:template match="thesis[@status='research']">
    <xsl:param name="indent"/>
    <xsl:value-of select="$indent"/>
    <xsl:call-template name="wrap-string">
      <xsl:with-param name="str">
	<xsl:text>* Thesis in progress, </xsl:text>
	<xsl:value-of select="description"/>
      </xsl:with-param>
      <xsl:with-param name="break-mark">
	<xsl:value-of select="$linebreak"/>
	<xsl:value-of select="$indent"/>
	<xsl:text>  </xsl:text>
      </xsl:with-param>
      <xsl:with-param name="wrap-col" select="80"/>
      <xsl:with-param name="pos" select="string-length($indent)"/>
    </xsl:call-template>
    <xsl:value-of select="$linebreak"/>
    <xsl:value-of select="$indent"/>
    <xsl:call-template name="wrap-string">
      <xsl:with-param name="str">
	<xsl:text>* Commitee: </xsl:text>
	<xsl:apply-templates select="committee"/>
      </xsl:with-param>
      <xsl:with-param name="break-mark">
	<xsl:value-of select="$linebreak"/>
	<xsl:value-of select="$indent"/>
	<xsl:text>  </xsl:text>
      </xsl:with-param>
      <xsl:with-param name="wrap-col" select="80"/>
      <xsl:with-param name="pos" select="string-length($indent) + 2"/>
    </xsl:call-template>
  </xsl:template>

  <xsl:template match="thesis[@status='defended']">
    <xsl:param name="indent"/>
    <xsl:value-of select="$indent"/>
    <xsl:call-template name="wrap-string">
      <xsl:with-param name="str">
	<xsl:text>* Thesis "</xsl:text>
	<xsl:value-of select="title"/>
	<xsl:text>", </xsl:text>
	<xsl:value-of select="description"/>
	<xsl:text>", defended </xsl:text>
	<xsl:apply-templates select="date"/>
      </xsl:with-param>
      <xsl:with-param name="break-mark">
	<xsl:value-of select="$linebreak"/>
	<xsl:value-of select="$indent"/>
	<xsl:text>  </xsl:text>
      </xsl:with-param>
      <xsl:with-param name="wrap-col" select="80"/>
      <xsl:with-param name="pos" select="string-length($indent)"/>
    </xsl:call-template>
    <xsl:value-of select="$linebreak"/>
    <xsl:value-of select="$indent"/>
    <xsl:call-template name="wrap-string">
      <xsl:with-param name="str">
	<xsl:text>* Commitee: </xsl:text>
	<xsl:apply-templates select="committee"/>
      </xsl:with-param>
      <xsl:with-param name="break-mark">
	<xsl:value-of select="$linebreak"/>
	<xsl:value-of select="$indent"/>
	<xsl:text>  </xsl:text>
      </xsl:with-param>
      <xsl:with-param name="wrap-col" select="80"/>
      <xsl:with-param name="pos" select="string-length($indent) + 2"/>
    </xsl:call-template>
  </xsl:template>

  <xsl:template match="thesis[@status='complete']">
    <xsl:param name="indent"/>
    <xsl:value-of select="$indent"/>
    <xsl:call-template name="wrap-string">
      <xsl:with-param name="str">
	<xsl:text>* Thesis "</xsl:text>
	<xsl:value-of select="title"/>
	<xsl:text>", </xsl:text>
	<xsl:value-of select="description"/>
	<xsl:text>", completed </xsl:text>
	<xsl:apply-templates select="date"/>
      </xsl:with-param>
      <xsl:with-param name="break-mark">
	<xsl:value-of select="$linebreak"/>
	<xsl:value-of select="$indent"/>
	<xsl:text>  </xsl:text>
      </xsl:with-param>
      <xsl:with-param name="wrap-col" select="80"/>
      <xsl:with-param name="pos" select="string-length($indent)"/>
    </xsl:call-template>
    <xsl:value-of select="$linebreak"/>
    <xsl:value-of select="$indent"/>
    <xsl:call-template name="wrap-string">
      <xsl:with-param name="str">
	<xsl:text>* Commitee: </xsl:text>
	<xsl:apply-templates select="committee"/>
      </xsl:with-param>
      <xsl:with-param name="break-mark">
	<xsl:value-of select="$linebreak"/>
	<xsl:value-of select="$indent"/>
	<xsl:text>  </xsl:text>
      </xsl:with-param>
      <xsl:with-param name="wrap-col" select="80"/>
      <xsl:with-param name="pos" select="string-length($indent) + 2"/>
    </xsl:call-template>
  </xsl:template>

  <xsl:template match="committee[1]">
    <xsl:value-of select="."/>
  </xsl:template>

  <xsl:template match="committee">
    <xsl:text>, </xsl:text>
    <xsl:value-of select="."/>
  </xsl:template>

  <xsl:template match="concentration[1]">
    <xsl:value-of select="."/>
  </xsl:template>

  <xsl:template match="concentration">
    <xsl:text>, </xsl:text>
    <xsl:value-of select="."/>
  </xsl:template>

  <xsl:template match="school[@type='undergraduate']">
    <xsl:param name="indent"/>
    <xsl:value-of select="$blankline"/>
    <xsl:value-of select="$indent"/>
    <xsl:value-of select="name"/>
    <xsl:text> (</xsl:text>
    <xsl:value-of select="degree"/>
    <xsl:text>):</xsl:text>
    <xsl:value-of select="$blankline"/>
    <xsl:value-of select="$indent"/>
    <xsl:text>  * </xsl:text>
    <xsl:value-of select="major"/>
    <xsl:text> major, </xsl:text>
    <xsl:value-of select="minor"/>
    <xsl:text> minor</xsl:text>
    <xsl:apply-templates select="comment">
      <xsl:with-param name="indent">
	<xsl:value-of select="$indent"/>
	<xsl:text>  </xsl:text>
      </xsl:with-param>
    </xsl:apply-templates>
  </xsl:template>

  <xsl:template match="job">
    <xsl:param name="indent"/>
    <xsl:variable name="position">
      <xsl:value-of select="position"/>
    </xsl:variable>
    <xsl:value-of select="$blankline"/>
    <xsl:value-of select="$indent"/>
    <xsl:value-of select="company"/>
    <xsl:if test="not($position = '')">
      <xsl:text>, </xsl:text>
      <xsl:value-of select="$position"/>
    </xsl:if>
    <xsl:text> (</xsl:text>
    <xsl:value-of select="location/city"/>
    <xsl:text>, </xsl:text>
    <xsl:value-of select="location/state"/>
    <xsl:text>):</xsl:text>
    <xsl:value-of select="$blankline"/>
    <xsl:value-of select="$indent"/>
    <xsl:call-template name="wrap-string">
      <xsl:with-param name="str">
	<xsl:text>  * </xsl:text>
	<xsl:apply-templates select="description"/>
      </xsl:with-param>
      <xsl:with-param name="break-mark">
	<xsl:value-of select="$linebreak"/>
	<xsl:value-of select="$indent"/>
	<xsl:text>    </xsl:text>
      </xsl:with-param>
      <xsl:with-param name="wrap-col" select="80"/>
      <xsl:with-param name="pos" select="string-length($indent) + 2"/>
    </xsl:call-template>
    <xsl:apply-templates select="comment">
      <xsl:with-param name="indent">
	<xsl:value-of select="$indent"/>
	<xsl:text>  </xsl:text>
      </xsl:with-param>
    </xsl:apply-templates>
  </xsl:template>

  <xsl:template match="project">
    <xsl:param name="indent"/>
    <xsl:value-of select="$blankline"/>
    <xsl:value-of select="$indent"/>
    <xsl:value-of select="name"/>
    <xsl:text>:</xsl:text>
    <xsl:value-of select="$blankline"/>
    <xsl:value-of select="$indent"/>
    <xsl:call-template name="wrap-string">
      <xsl:with-param name="str">
	<xsl:text>  * </xsl:text>
	<xsl:apply-templates select="description"/>
      </xsl:with-param>
      <xsl:with-param name="break-mark">
	<xsl:value-of select="$linebreak"/>
	<xsl:value-of select="$indent"/>
	<xsl:text>    </xsl:text>
      </xsl:with-param>
      <xsl:with-param name="wrap-col" select="80"/>
      <xsl:with-param name="pos" select="string-length($indent) + 2"/>
    </xsl:call-template>
    <xsl:apply-templates select="comment">
      <xsl:with-param name="indent">
	<xsl:value-of select="$indent"/>
	<xsl:text>  </xsl:text>
      </xsl:with-param>
    </xsl:apply-templates>
  </xsl:template>

  <xsl:template match="publication[@type='mastersthesis']">
    <xsl:param name="indent"/>
    <xsl:variable name="comment">
      <xsl:value-of select="comment"/>
    </xsl:variable>
    <xsl:value-of select="$blankline"/>
    <xsl:value-of select="$indent"/>
    <xsl:call-template name="wrap-string">
      <xsl:with-param name="str">
	<xsl:text>* </xsl:text>
	<xsl:apply-templates select="author"/>
	<xsl:text>. "</xsl:text>
	<xsl:value-of select="title"/>
	<xsl:text>"  Sc.M Thesis, </xsl:text>
	<xsl:apply-templates select="date"/>
	<xsl:text>.</xsl:text>
	<xsl:if test="not($comment = '')">
	  <xsl:text>"  </xsl:text>
	  <xsl:value-of select="$comment"/>
	  <xsl:text>.</xsl:text>
	</xsl:if>
      </xsl:with-param>
      <xsl:with-param name="break-mark">
	<xsl:value-of select="$linebreak"/>
	<xsl:value-of select="$indent"/>
	<xsl:text>    </xsl:text>
      </xsl:with-param>
      <xsl:with-param name="wrap-col" select="80"/>
      <xsl:with-param name="pos" select="string-length($indent) + 2"/>
    </xsl:call-template>
  </xsl:template>

  <xsl:template match="publication[@type='preparation']">
    <xsl:param name="indent"/>
    <xsl:variable name="comment">
      <xsl:value-of select="comment"/>
    </xsl:variable>
    <xsl:value-of select="$blankline"/>
    <xsl:value-of select="$indent"/>
    <xsl:call-template name="wrap-string">
      <xsl:with-param name="str">
	<xsl:text>* </xsl:text>
	<xsl:apply-templates select="author"/>
	<xsl:text>. "</xsl:text>
	<xsl:value-of select="title"/>
	<xsl:text>"  In preparation.</xsl:text>
	<xsl:if test="not($comment = '')">
	  <xsl:text>"  </xsl:text>
	  <xsl:value-of select="$comment"/>
	  <xsl:text>.</xsl:text>
	</xsl:if>
      </xsl:with-param>
      <xsl:with-param name="break-mark">
	<xsl:value-of select="$linebreak"/>
	<xsl:value-of select="$indent"/>
	<xsl:text>    </xsl:text>
      </xsl:with-param>
      <xsl:with-param name="wrap-col" select="80"/>
      <xsl:with-param name="pos" select="string-length($indent) + 2"/>
    </xsl:call-template>
  </xsl:template>

  <xsl:template match="publication[@type='grant']">
    <xsl:param name="indent"/>
    <xsl:variable name="comment">
      <xsl:value-of select="comment"/>
    </xsl:variable>
    <xsl:value-of select="$blankline"/>
    <xsl:value-of select="$indent"/>
    <xsl:call-template name="wrap-string">
      <xsl:with-param name="str">
	<xsl:text>* </xsl:text>
	<xsl:apply-templates select="author"/>
	<xsl:text>. "</xsl:text>
	<xsl:value-of select="title"/>
	<xsl:text>"  </xsl:text>
	<xsl:value-of select="agency"/>
	<xsl:text> grant proposal, </xsl:text>
	<xsl:apply-templates select="date"/>
	<xsl:text>.</xsl:text>
	<xsl:if test="not($comment = '')">
	  <xsl:text>  (</xsl:text>
	  <xsl:value-of select="$comment"/>
	  <xsl:text>)</xsl:text>
	</xsl:if>
      </xsl:with-param>
      <xsl:with-param name="break-mark">
	<xsl:value-of select="$linebreak"/>
	<xsl:value-of select="$indent"/>
	<xsl:text>    </xsl:text>
      </xsl:with-param>
      <xsl:with-param name="wrap-col" select="80"/>
      <xsl:with-param name="pos" select="string-length($indent) + 2"/>
    </xsl:call-template>
  </xsl:template>

  <xsl:template match="author[1]">
    <xsl:value-of select="."/>
  </xsl:template>

  <xsl:template match="author">
    <xsl:text>, </xsl:text>
    <xsl:value-of select="."/>
  </xsl:template>

  <xsl:template match="workshop">
    <xsl:param name="indent"/>
    <xsl:value-of select="$blankline"/>
    <xsl:value-of select="$indent"/>
    <xsl:call-template name="wrap-string">
      <xsl:with-param name="str">
	<xsl:text>* Participant in </xsl:text>
	<xsl:value-of select="description"/>
	<xsl:text>.</xsl:text>
      </xsl:with-param>
      <xsl:with-param name="break-mark">
	<xsl:value-of select="$linebreak"/>
	<xsl:value-of select="$indent"/>
	<xsl:text>    </xsl:text>
      </xsl:with-param>
      <xsl:with-param name="wrap-col" select="80"/>
      <xsl:with-param name="pos" select="string-length($indent) + 2"/>
    </xsl:call-template>
  </xsl:template>

  <xsl:template match="reference">
    <xsl:param name="indent"/>
    <xsl:value-of select="$linebreak"/>
    <xsl:value-of select="$indent"/>
    <xsl:text>* </xsl:text>
    <xsl:value-of select="name"/>
    <xsl:text>, </xsl:text>
    <xsl:value-of select="description"/>
    <xsl:text>, </xsl:text>
    <xsl:value-of select="contact/email"/>
  </xsl:template>

  <xsl:template match="comment">
    <xsl:param name="indent"/>
    <xsl:value-of select="$linebreak"/>
    <xsl:value-of select="$indent"/>
    <xsl:call-template name="wrap-string">
      <xsl:with-param name="str">
	<xsl:text>* </xsl:text>
	<xsl:value-of select="."/>
      </xsl:with-param>
      <xsl:with-param name="break-mark">
	<xsl:value-of select="$linebreak"/>
	<xsl:value-of select="$indent"/>
	<xsl:text>  </xsl:text>
      </xsl:with-param>
      <xsl:with-param name="wrap-col" select="80"/>
      <xsl:with-param name="pos" select="string-length($indent) + 2"/>
    </xsl:call-template>
  </xsl:template>

  <xsl:template match="skill">
    <xsl:param name="separator"/>
    <xsl:value-of select="$separator"/>
    <xsl:value-of select="."/>
  </xsl:template>

  <xsl:template match="contact">
    <xsl:param name="indent"/>
    <xsl:value-of select="$indent"/>
    <xsl:text>Address:</xsl:text>
    <xsl:value-of select="$linebreak"/>
    <xsl:apply-templates select="location">
      <xsl:with-param name="indent">
	<xsl:value-of select="$indent"/>
	<xsl:text>  </xsl:text>
      </xsl:with-param>
    </xsl:apply-templates>
    <xsl:value-of select="$blankline"/>
    <xsl:value-of select="$indent"/>
    <xsl:text>Phone: </xsl:text>
    <xsl:value-of select="phone"/>
    <xsl:value-of select="$linebreak"/>
    <xsl:value-of select="$indent"/>
    <xsl:text>Email: </xsl:text>
    <xsl:value-of select="email"/>
  </xsl:template>

  <xsl:template match="location">
    <xsl:param name="indent"/>
    <xsl:value-of select="$indent"/>
    <xsl:value-of select="street"/>
    <xsl:text> </xsl:text>
    <xsl:value-of select="apt"/>
    <xsl:value-of select="$linebreak"/>
    <xsl:value-of select="$indent"/>
    <xsl:value-of select="city"/>
    <xsl:text>, </xsl:text>
    <xsl:value-of select="state"/>
    <xsl:text>, </xsl:text>
    <xsl:value-of select="country"/>
    <xsl:text> </xsl:text>
    <xsl:value-of select="zip"/>
  </xsl:template>

  <xsl:template match="title"/>

  <xsl:template name="wrap-string">
    <xsl:param name="str" />
    <xsl:param name="wrap-col" />
    <xsl:param name="break-mark" />
    <xsl:param name="pos" select="0" />
    <xsl:choose>

      <xsl:when test="contains( $str, ' ' )">
	<xsl:variable name="first-word"
		      select="substring-before( $str, ' ' )" />
	<xsl:variable name="pos-now"
		      select="$pos + 1 + string-length( $first-word )" />
	<xsl:choose>

	  <xsl:when test="$pos > 0 and $pos-now >= $wrap-col">
	    <xsl:copy-of select="$break-mark" />
	    <xsl:call-template name="wrap-string">
	      <xsl:with-param name="str" select="$str" />
	      <xsl:with-param name="wrap-col" select="$wrap-col" />
	      <xsl:with-param name="break-mark" select="$break-mark" />
	      <xsl:with-param name="pos" select="0" />
	    </xsl:call-template>
	  </xsl:when>

	  <xsl:otherwise>
	    <xsl:value-of select="$first-word" />
	    <xsl:text> </xsl:text>
	    <xsl:call-template name="wrap-string">
	      <xsl:with-param name="str"
			      select="substring-after( $str, ' ' )" />
	      <xsl:with-param name="wrap-col" select="$wrap-col" />
	      <xsl:with-param name="break-mark" select="$break-mark" />
	      <xsl:with-param name="pos" select="$pos-now" />
	    </xsl:call-template>
	  </xsl:otherwise>

	</xsl:choose>
      </xsl:when>

      <xsl:otherwise>
	<xsl:if test="$pos + string-length( $str ) >= $wrap-col">
	  <xsl:copy-of select="$break-mark" />
	</xsl:if>
	<xsl:value-of select="$str" />
      </xsl:otherwise>

    </xsl:choose>
  </xsl:template>

  <xsl:template match="date">
    <xsl:variable name="month">
      <xsl:value-of select="month"/>
    </xsl:variable>
    <xsl:variable name="day">
      <xsl:value-of select="day"/>
    </xsl:variable>
    <xsl:if test="not($month = '')">
      <xsl:value-of select="$month"/>
      <xsl:text> </xsl:text>
    </xsl:if>
    <xsl:if test="not($day = '')">
      <xsl:value-of select="$day"/>
      <xsl:text>, </xsl:text>
    </xsl:if>
    <xsl:value-of select="year"/>
  </xsl:template>

</xsl:stylesheet>