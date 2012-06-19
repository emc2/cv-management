<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output method="xml" version="1.0" indent="yes" encoding="UTF-8"
	      cdata-section-elements="pre script style"
	      doctype-system="http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd"
	      doctype-public="-//W3C//DTD XHTML 1.1//EN"/>

  <xsl:template match="/">
    <html xmlns="http://www.w3.org/1999/xhtml">
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
  </xsl:template>

</xsl:stylesheet>