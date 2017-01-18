<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output method="xml" version="1.0" indent="yes" encoding="UTF-8"
	      cdata-section-elements="pre script style"
	      doctype-system="http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd"
	      doctype-public="-//W3C//DTD XHTML 1.1//EN"/>

  <xsl:template match="/">
    <html version="-//W3C//DTD XHTML 1.1//EN"
	  xmlns="http://www.w3.org/1999/xhtml" xml:lang="en"
	  xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
	  xsi:schemaLocation="http://www.w3.org/1999/xhtml
			      http://www.w3.org/MarkUp/SCHEMA/xhtml11.xsd">
      <head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
	<title>Curriculum Vitae</title>
      </head>
      <body>
	<xsl:apply-templates select="cv"/>
      </body>
    </html>
  </xsl:template>

  <xsl:template match="cv">
    <div xmlns="http://www.w3.org/1999/xhtml" id="name">
      <xsl:value-of select="name"/>
    </div>
    <div xmlns="http://www.w3.org/1999/xhtml" id="contact-address">
      <xsl:value-of select="contact/location/street"/>
      <xsl:text> </xsl:text>
      <xsl:value-of select="contact/location/apt"/>
      <br/>
      <xsl:value-of select="contact/location/city"/>
      <xsl:text>, </xsl:text>
      <xsl:value-of select="contact/location/state"/>
      <xsl:text> </xsl:text>
      <xsl:value-of select="contact/location/country"/>
      <xsl:text> </xsl:text>
      <xsl:value-of select="contact/location/zip"/>
    </div>
    <div xmlns="http://www.w3.org/1999/xhtml" id="contact-phone">
      <xsl:value-of select="contact/phone"/>
    </div>
    <div xmlns="http://www.w3.org/1999/xhtml" id="contact-email">
      <xsl:value-of select="contact/email"/>
    </div>
    <div xmlns="http://www.w3.org/1999/xhtml" id="contact-github">
      <xsl:value-of select="contact/github"/>
    </div>
    <div xmlns="http://www.w3.org/1999/xhtml" id="contact-blog">
      <xsl:value-of select="contact/blog"/>
    </div>
    <div xmlns="http://www.w3.org/1999/xhtml" id="content">
      <xsl:apply-templates select="section"/>
    </div>
  </xsl:template>

  <xsl:template match="section">
    <h1 xmlns="http://www.w3.org/1999/xhtml">
      <xsl:value-of select="title"/>
    </h1>
    <xsl:apply-templates select="skillset|school|job|internship|project|reference|workshop|publication"/>
  </xsl:template>

  <xsl:template match="skillset">
    <h2 xmlns="http://www.w3.org/1999/xhtml">
      <xsl:value-of select="title"/>
    </h2>
    <ul xmlns="http://www.w3.org/1999/xhtml">
      <xsl:apply-templates select="skills"/>
    </ul>
  </xsl:template>

  <xsl:template match="skills">
    <li xmlns="http://www.w3.org/1999/xhtml">
      <b xmlns="http://www.w3.org/1999/xhtml">
	<xsl:value-of select="title"/>
	<xsl:text>:</xsl:text>
      </b>
	<xsl:text> </xsl:text>
      <xsl:apply-templates select="skill"/>
    </li>
  </xsl:template>

  <xsl:template match="skill[1]">
    <xsl:value-of select="."/>
  </xsl:template>

  <xsl:template match="skill">
    <xsl:text>, </xsl:text>
    <xsl:value-of select="."/>
  </xsl:template>

  <xsl:template match="school[@type='graduate']">
    <h2 xmlns="http://www.w3.org/1999/xhtml">
      <xsl:value-of select="name"/>
      <xsl:text> - </xsl:text>
      <xsl:value-of select="degree"/>
    </h2>
    <h3 xmlns="http://www.w3.org/1999/xhtml">
      <xsl:value-of select="field"/>
      <xsl:text> (</xsl:text>
      <xsl:apply-templates select="concentration"/>
    </h3>
    <h4 xmlns="http://www.w3.org/1999/xhtml">
      <xsl:apply-templates select="start"/>-<xsl:apply-templates select="end"/>
    </h4>
    <ul xmlns="http://www.w3.org/1999/xhtml">
      <li xmlns="http://www.w3.org/1999/xhtml">
	<xsl:text>Advisor: </xsl:text>
	<xsl:value-of select="advisor"/>
      </li>
      <xsl:apply-templates select="thesis"/>
      <xsl:apply-templates select="comment"/>
    </ul>
  </xsl:template>

  <xsl:template match="thesis[@status='research']">
    <li xmlns="http://www.w3.org/1999/xhtml">
      <xsl:text>Thesis in progress, </xsl:text>
      <xsl:value-of select="description"/>
    </li>
    <li xmlns="http://www.w3.org/1999/xhtml">
      <xsl:text>Committee </xsl:text>
      <xsl:apply-templates select="committee"/>
    </li>
  </xsl:template>

  <xsl:template match="thesis[@status='defended']">
    <li xmlns="http://www.w3.org/1999/xhtml">
      <xsl:text>Thesis "</xsl:text>
      <xsl:value-of select="title"/>
      <xsl:text>", </xsl:text>
      <xsl:value-of select="description"/>
      <xsl:text>, defended </xsl:text>
      <xsl:apply-templates select="date"/>
    </li>
    <li xmlns="http://www.w3.org/1999/xhtml">
      <xsl:text>Committee </xsl:text>
      <xsl:apply-templates select="committee"/>
    </li>
  </xsl:template>

  <xsl:template match="thesis[@status='complete']">
    <li xmlns="http://www.w3.org/1999/xhtml">
      <xsl:text>Thesis "</xsl:text>
      <xsl:value-of select="title"/>
      <xsl:text>", </xsl:text>
      <xsl:value-of select="description"/>
      <xsl:text>, completed </xsl:text>
      <xsl:apply-templates select="date"/>
    </li>
    <li xmlns="http://www.w3.org/1999/xhtml">
      <xsl:text>Committee </xsl:text>
      <xsl:apply-templates select="committee"/>
    </li>
  </xsl:template>

  <xsl:template match="school[@type='undergraduate']">
    <h2 xmlns="http://www.w3.org/1999/xhtml">
      <xsl:value-of select="name"/>
      <xsl:text> - </xsl:text>
      <xsl:value-of select="degree"/>
    </h2>
    <h3 xmlns="http://www.w3.org/1999/xhtml">
      <xsl:value-of select="major"/>
      <xsl:text> major, </xsl:text>
      <xsl:value-of select="minor"/>
      <xsl:text> minor</xsl:text>
    </h3>
    <h4 xmlns="http://www.w3.org/1999/xhtml">
      <xsl:apply-templates select="start"/>-<xsl:apply-templates select="end"/>
    </h4>
    <ul xmlns="http://www.w3.org/1999/xhtml">
      <xsl:apply-templates select="comment"/>
    </ul>
  </xsl:template>

  <xsl:template match="job">
    <h2 xmlns="http://www.w3.org/1999/xhtml">
      <xsl:value-of select="company"/>
    </h2>
    <h3 xmlns="http://www.w3.org/1999/xhtml">
      <xsl:value-of select="position"/>
    </h3>
    <h4 xmlns="http://www.w3.org/1999/xhtml">
      <xsl:apply-templates select="start"/>-<xsl:apply-templates select="end"/>
    </h4>
    <ul xmlns="http://www.w3.org/1999/xhtml">
      <li xmlns="http://www.w3.org/1999/xhtml">
	<xsl:value-of select="description"/>
      </li>
      <xsl:apply-templates select="comment"/>
    </ul>
  </xsl:template>

  <xsl:template match="internship">
    <h2 xmlns="http://www.w3.org/1999/xhtml">
      <xsl:value-of select="company"/>
    </h2>
    <h3 xmlns="http://www.w3.org/1999/xhtml">
      <xsl:value-of select="position"/>
    </h3>
    <ul xmlns="http://www.w3.org/1999/xhtml">
      <li xmlns="http://www.w3.org/1999/xhtml">
	<xsl:value-of select="description"/>
      </li>
      <xsl:apply-templates select="comment"/>
    </ul>
  </xsl:template>

  <xsl:template match="project">
    <h2 xmlns="http://www.w3.org/1999/xhtml">
      <xsl:value-of select="name"/>
    </h2>
    <ul xmlns="http://www.w3.org/1999/xhtml">
      <li xmlns="http://www.w3.org/1999/xhtml">
	<xsl:value-of select="description"/>
      </li>
      <xsl:apply-templates select="comment"/>
    </ul>
  </xsl:template>

  <xsl:template match="publication[@type='mastersthesis']">
    <xsl:variable name="comment">
      <xsl:apply-templates select="comment"/>
    </xsl:variable>
    <p xmlns="http://www.w3.org/1999/xhtml">
      <xsl:apply-templates select="author"/>
      <xsl:text>.  "</xsl:text>
      <xsl:value-of select="title"/>
      <xsl:text>."  Sc.M Thesis, </xsl:text>
      <xsl:apply-templates select="date"/>
      <xsl:text>.</xsl:text>
      <xsl:if test="not($comment = '')">
	<xsl:text> (</xsl:text>
	<xsl:value-of select="comment"/>
	<xsl:text>)</xsl:text>
      </xsl:if>
    </p>
  </xsl:template>

  <xsl:template match="publication[@type='submitted']">
    <xsl:variable name="comment">
      <xsl:apply-templates select="comment"/>
    </xsl:variable>
    <p xmlns="http://www.w3.org/1999/xhtml">
      <xsl:apply-templates select="author"/>
      <xsl:text>.  "</xsl:text>
      <xsl:value-of select="title"/>
      <xsl:text>."  Submitted to </xsl:text>
      <xsl:value-of select="conference"/>
      <xsl:text>.</xsl:text>
      <xsl:if test="not($comment = '')">
	<xsl:text> (</xsl:text>
	<xsl:value-of select="comment"/>
	<xsl:text>)</xsl:text>
      </xsl:if>
    </p>
  </xsl:template>

  <xsl:template match="publication[@type='published']">
    <xsl:variable name="comment">
      <xsl:apply-templates select="comment"/>
    </xsl:variable>
    <p xmlns="http://www.w3.org/1999/xhtml">
      <xsl:apply-templates select="author"/>
      <xsl:text>.  "</xsl:text>
      <xsl:value-of select="title"/>
      <xsl:text>." </xsl:text>
      <xsl:value-of select="conference"/>
      <xsl:text>.</xsl:text>
      <xsl:if test="not($comment = '')">
	<xsl:text> (</xsl:text>
	<xsl:value-of select="comment"/>
	<xsl:text>)</xsl:text>
      </xsl:if>
    </p>
  </xsl:template>

  <xsl:template match="publication[@type='preparation']">
    <xsl:variable name="comment">
      <xsl:apply-templates select="comment"/>
    </xsl:variable>
    <p xmlns="http://www.w3.org/1999/xhtml">
      <xsl:apply-templates select="author"/>
      <xsl:text>.  "</xsl:text>
      <xsl:value-of select="title"/>
      <xsl:text>."  In Preparation.</xsl:text>
      <xsl:if test="not($comment = '')">
	<xsl:text> (</xsl:text>
	<xsl:value-of select="comment"/>
	<xsl:text>)</xsl:text>
      </xsl:if>
    </p>
  </xsl:template>

  <xsl:template match="publication[@type='grant']">
    <xsl:variable name="comment">
      <xsl:apply-templates select="comment"/>
    </xsl:variable>
    <p xmlns="http://www.w3.org/1999/xhtml">
      <xsl:apply-templates select="author"/>
      <xsl:text>.  "</xsl:text>
      <xsl:value-of select="title"/>
      <xsl:text>."  </xsl:text>
      <xsl:value-of select="agency"/>
      <xsl:text> grant proposal.</xsl:text>
      <xsl:if test="not($comment = '')">
	<xsl:text> (</xsl:text>
	<xsl:value-of select="comment"/>
	<xsl:text>)</xsl:text>
      </xsl:if>
    </p>
  </xsl:template>

  <xsl:template match="author[1]">
    <xsl:value-of select="."/>
  </xsl:template>

  <xsl:template match="author">
    <xsl:text>, </xsl:text>
    <xsl:value-of select="."/>
  </xsl:template>

  <xsl:template match="workshop">
    <li xmlns="http://www.w3.org/1999/xhtml">
      <xsl:text>Participant in </xsl:text>
      <xsl:value-of select="description"/>
    </li>
  </xsl:template>

  <xsl:template match="comment">
    <li xmlns="http://www.w3.org/1999/xhtml">
      <xsl:value-of select="."/>
    </li>
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

  <xsl:template match="reference">
    <p xmlns="http://www.w3.org/1999/xhtml">
      <b xmlns="http://www.w3.org/1999/xhtml">
	<xsl:value-of select="name"/>
	<xsl:text>:</xsl:text>
      </b>
      <xsl:text> </xsl:text>
      <xsl:value-of select="description"/>
      <xsl:text>, </xsl:text>
      <xsl:value-of select="contact/email"/>
    </p>
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

  <xsl:template match="start">
    <xsl:apply-templates select="date"/>
  </xsl:template>

  <xsl:template match="end">
    <xsl:apply-templates select="date"/>
  </xsl:template>

</xsl:stylesheet>
