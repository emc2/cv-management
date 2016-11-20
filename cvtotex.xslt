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
    <xsl:text>\documentclass[11pt,oneside]{article}
\usepackage{geometry}
\usepackage[T1]{fontenc}

\pagestyle{empty}
\geometry{letterpaper,tmargin=0.75in,bmargin=0.75in,lmargin=0.70in,rmargin=0.70in,headheight=0in,headsep=0in,footskip=.3in}

\setlength{\parindent}{0in}
\setlength{\parskip}{0in}
\setlength{\itemsep}{0in}
\setlength{\topsep}{0in}
\setlength{\tabcolsep}{0in}

% Name and contact information
\newcommand{\name}{</xsl:text>
    <xsl:value-of select="cv/name"/>
    <xsl:text>}
\newcommand{\addr}{</xsl:text>
    <xsl:value-of select="cv/contact/location/street"/>
    <xsl:text> </xsl:text>
    <xsl:value-of select="cv/contact/location/apt"/>
    <xsl:text> </xsl:text>
    <xsl:value-of select="cv/contact/location/city"/>
    <xsl:text>, </xsl:text>
    <xsl:value-of select="cv/contact/location/state"/>
    <xsl:text> </xsl:text>
    <xsl:value-of select="cv/contact/location/country"/>
    <xsl:text> </xsl:text>
    <xsl:value-of select="cv/contact/location/zip"/>
    <xsl:text>}
\newcommand{\phone}{</xsl:text>
    <xsl:value-of select="cv/contact/phone"/>
    <xsl:text>}
\newcommand{\email}{</xsl:text>
    <xsl:value-of select="cv/contact/email"/>
    <xsl:text>}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% New commands and environments

% This defines how the name looks
\newcommand{\bigname}[1]{
  \begin{center}\fontfamily{phv}\selectfont\Huge\scshape\textbf{#1}
  \end{center}
}

% A ressection is a main section
\newenvironment{ressection}[1]{
\begin{tabular*}{\textwidth}[t]{lp{0.10in}|l}
\begin{minipage}{1.1in}\fontfamily{phv}\selectfont\Large\raggedleft #1\end{minipage}&amp;&amp;\begin{minipage}{5.8in}\begin{itemize}
}{
\end{itemize}
\end{minipage}
\end{tabular*}
\vspace{16pt}
}

% A resitem is a simple list element in a ressection (first level)
\newcommand{\resitem}[1]{
  \vspace{-4pt}
\item \begin{flushleft} #1 \end{flushleft}
}

% A ressubitem is a simple list element in anything but a ressection (second level)
\newcommand{\ressubitem}[1]{
  \vspace{-1pt}
\item \begin{flushleft} #1 \end{flushleft}
}

% A resbigitem is a complex list element for stuff like jobs and education:
%  Arg 1: Name of company or university
%  Arg 2: Location
%  Arg 3: Title and/or date range
\newcommand*{\resbigitem}[3]{
  \vspace{-5pt}
\item \textbf{#1}---#2 (\emph{#3})
}

% This is a list that comes with a resbigitem
\newenvironment{ressubsec}[3]{
  \resbigitem{#1}{#2}{#3}
  \vspace{-2pt}
  \begin{itemize}
}{
\end{itemize}
}

% This is a simple sublist
\newenvironment{reslist}[1]{
  \resitem{\textbf{#1}}
  \begin{itemize}
}{
\end{itemize}
}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Now for the actual document:

\begin{document}
\fontfamily{ppl} \selectfont

% Name with horizontal rule
\bigname{\name}
\vspace{8pt}
{\small\itshape \addr \hfill \phone; \email}
\rule{\textwidth}{2pt}
%{\small\itshape \addr \hfill \phone; \email}
\vspace{8pt}

%%%%%%%%%%%%%%%%%%%%%%%%

</xsl:text>
    <xsl:apply-templates select="cv/section"/>
    <xsl:text>\end{document}
</xsl:text>
  </xsl:template>

  <xsl:template match="section">
    <xsl:text>\begin{ressection}{</xsl:text>
    <xsl:value-of select="title"/>
    <xsl:text>}
</xsl:text>
    <xsl:apply-templates select="skillset|school|job|internship|project|reference|workshop|publication"/>
    <xsl:text>\end{ressection}
</xsl:text>
  </xsl:template>

  <xsl:template match="skillset">
    <xsl:text>\begin{reslist}{</xsl:text>
    <xsl:value-of select="title"/>
    <xsl:text>}
</xsl:text>
    <xsl:apply-templates select="skills"/>
    <xsl:text>\end{reslist}
</xsl:text>
  </xsl:template>

  <xsl:template match="skills">
    <xsl:text>\resitem{\textbf{</xsl:text>
    <xsl:value-of select="title"/>
    <xsl:text>}: </xsl:text>
    <xsl:apply-templates select="skill"/>
    <xsl:text>}
</xsl:text>
  </xsl:template>

  <xsl:template match="skill[1]">
    <xsl:value-of select="."/>
  </xsl:template>

  <xsl:template match="skill">
    <xsl:text>, </xsl:text>
    <xsl:value-of select="."/>
  </xsl:template>

  <xsl:template match="school[@type='graduate']">
    <xsl:text>\begin{ressubsec}{</xsl:text>
    <xsl:value-of select="name"/>
    <xsl:text>}{</xsl:text>
    <xsl:value-of select="degree"/>
    <xsl:text>}{</xsl:text>
    <xsl:apply-templates select="start"/> - <xsl:apply-templates select="end"/>
    <xsl:text>}
\ressubitem{</xsl:text>
    <xsl:value-of select="field"/>
    <xsl:text> (</xsl:text>
    <xsl:apply-templates select="concentration"/>
    <xsl:text>)}
\ressubitem{Advisor: </xsl:text>
    <xsl:value-of select="advisor"/>
    <xsl:text>}
</xsl:text>
    <xsl:apply-templates select="thesis"/>
    <xsl:apply-templates select="comment"/>
    <xsl:text>\end{ressubsec}
</xsl:text>
  </xsl:template>

  <xsl:template match="thesis[@status='research']">
    <xsl:text>\ressubitem{Thesis in progress, </xsl:text>
    <xsl:value-of select="description"/>
    <xsl:text>}
\ressubitem{Committee: </xsl:text>
    <xsl:apply-templates select="committee"/>
    <xsl:text>}
</xsl:text>
  </xsl:template>

  <xsl:template match="thesis[@status='defended']">
    <xsl:text>\ressubitem{Thesis "</xsl:text>
    <xsl:value-of select="title"/>
    <xsl:text>", </xsl:text>
    <xsl:value-of select="description"/>
    <xsl:text>, defended </xsl:text>
    <xsl:apply-templates select="date"/>
    <xsl:text>}
\ressubitem{Committee: </xsl:text>
    <xsl:apply-templates select="committee"/>
    <xsl:text>}
</xsl:text>
  </xsl:template>

  <xsl:template match="thesis[@status='complete']">
    <xsl:text>\ressubitem{Thesis "</xsl:text>
    <xsl:value-of select="title"/>
    <xsl:text>", </xsl:text>
    <xsl:value-of select="description"/>
    <xsl:text>, completed </xsl:text>
    <xsl:apply-templates select="date"/>
    <xsl:text>}
\ressubitem{Committee: </xsl:text>
    <xsl:apply-templates select="committee"/>
    <xsl:text>}
</xsl:text>
  </xsl:template>

  <xsl:template match="school[@type='undergraduate']">
    <xsl:text>\begin{ressubsec}{</xsl:text>
    <xsl:value-of select="name"/>
    <xsl:text>}{</xsl:text>
    <xsl:value-of select="degree"/>
    <xsl:text>}{</xsl:text>
    <xsl:apply-templates select="start"/> - <xsl:apply-templates select="end"/>
    <xsl:text>}
\ressubitem{</xsl:text>
    <xsl:value-of select="major"/>
    <xsl:text> major, </xsl:text>
    <xsl:value-of select="minor"/>
    <xsl:text> minor}
</xsl:text>
    <xsl:apply-templates select="comment"/>
    <xsl:text>\end{ressubsec}
</xsl:text>
  </xsl:template>

  <xsl:template match="job">
    <xsl:text>\begin{ressubsec}{</xsl:text>
    <xsl:value-of select="company"/>
    <xsl:text>}{</xsl:text>
    <xsl:value-of select="position"/>
    <xsl:text>}{</xsl:text>
    <xsl:apply-templates select="start"/> - <xsl:apply-templates select="end"/>
    <xsl:text>}
\ressubitem{</xsl:text>
    <xsl:value-of select="description"/>
    <xsl:text>}
</xsl:text>
    <xsl:apply-templates select="comment"/>
    <xsl:text>\end{ressubsec}
</xsl:text>
  </xsl:template>

  <xsl:template match="internship">
    <xsl:text>\begin{reslist}{</xsl:text>
    <xsl:value-of select="company"/>---<xsl:value-of select="position"/>
    <xsl:text>}
\ressubitem{</xsl:text>
    <xsl:value-of select="description"/>
    <xsl:text>}
</xsl:text>
    <xsl:apply-templates select="comment"/>
    <xsl:text>\end{reslist}
</xsl:text>
  </xsl:template>

  <xsl:template match="project">
    <xsl:text>\begin{reslist}{</xsl:text>
    <xsl:value-of select="name"/>
    <xsl:text>}
\ressubitem{</xsl:text>
    <xsl:value-of select="description"/>
    <xsl:text>}
</xsl:text>
    <xsl:apply-templates select="comment"/>
    <xsl:text>\end{reslist}
</xsl:text>
  </xsl:template>

  <xsl:template match="publication[@type='mastersthesis']">
    <xsl:variable name="comment">
      <xsl:apply-templates select="comment"/>
    </xsl:variable>
    <xsl:text>\ressubitem{</xsl:text>
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
    <xsl:text>}
</xsl:text>
  </xsl:template>

  <xsl:template match="publication[@type='preparation']">
    <xsl:variable name="comment">
      <xsl:apply-templates select="comment"/>
    </xsl:variable>
    <xsl:text>\ressubitem{</xsl:text>
    <xsl:apply-templates select="author"/>
    <xsl:text>.  "</xsl:text>
    <xsl:value-of select="title"/>
    <xsl:text>."  In Preparation.</xsl:text>
    <xsl:if test="not($comment = '')">
      <xsl:text> (</xsl:text>
      <xsl:value-of select="comment"/>
      <xsl:text>)</xsl:text>
    </xsl:if>
    <xsl:text>}
</xsl:text>
  </xsl:template>

  <xsl:template match="publication[@type='submitted']">
    <xsl:variable name="comment">
      <xsl:apply-templates select="comment"/>
    </xsl:variable>
    <xsl:text>\ressubitem{</xsl:text>
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
    <xsl:text>}
</xsl:text>
  </xsl:template>

  <xsl:template match="publication[@type='published']">
    <xsl:variable name="comment">
      <xsl:apply-templates select="comment"/>
    </xsl:variable>
    <xsl:text>\ressubitem{</xsl:text>
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
    <xsl:text>}
</xsl:text>
  </xsl:template>

  <xsl:template match="publication[@type='grant']">
    <xsl:variable name="comment">
      <xsl:apply-templates select="comment"/>
    </xsl:variable>
    <xsl:text>\ressubitem{</xsl:text>
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
    <xsl:text>}
</xsl:text>
  </xsl:template>

  <xsl:template match="author[1]">
    <xsl:value-of select="."/>
  </xsl:template>

  <xsl:template match="author">
    <xsl:text>, </xsl:text>
    <xsl:value-of select="."/>
  </xsl:template>

  <xsl:template match="workshop">
    <xsl:text>\ressubitem{Participant in </xsl:text>
    <xsl:value-of select="description"/>
    <xsl:text>}
</xsl:text>
  </xsl:template>

  <xsl:template match="comment">
    <xsl:text>\ressubitem{</xsl:text>
    <xsl:value-of select="."/>
    <xsl:text>}
</xsl:text>
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

  <xsl:template match="start">
    <xsl:apply-templates select="date"/>
  </xsl:template>

  <xsl:template match="end">
    <xsl:apply-templates select="date"/>
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

  <xsl:template match="reference">
    <xsl:text>\ressubitem{</xsl:text>
    <xsl:value-of select="name"/>
    <xsl:text>, </xsl:text>
    <xsl:value-of select="description"/>
    <xsl:text>, </xsl:text>
    <xsl:value-of select="contact/email"/>
    <xsl:text>}
</xsl:text>
  </xsl:template>

</xsl:stylesheet>
