<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:output method="html" encoding="UTF-8" indent="yes"/>

  <!-- ══════════════════
       ROOT TEMPLATE
  ══════════════════ -->
  <xsl:template match="/">
    <html lang="en">
      <head>
        <meta charset="UTF-8"/>
        <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
        <title>The Da Vinci Code</title>
        <link href="https://fonts.googleapis.com/css2?family=EB+Garamond:ital,wght@0,400;0,700;1,400;1,700&amp;display=swap" rel="stylesheet"/>
        <style>

          *, *::before, *::after {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
          }

          body {
            background: #c8c8c8;
            display: flex;
            justify-content: center;
            align-items: flex-start;
            min-height: 100vh;
            padding: 40px 20px;
            font-family: 'EB Garamond', Georgia, serif;
          }

          .page {
            background: #fffff5;
            width: 680px;
            min-height: 900px;
            padding: 56px 70px 60px 70px;
            box-shadow: 0 4px 30px rgba(0,0,0,0.22);
          }

          p.body-para {
            font-size: 1.03rem;
            line-height: 1.78;
            color: #111;
            margin-bottom: 18px;
            text-align: left;
          }

          p.italic-line {
            font-style: italic;
            font-size: 1.03rem;
            line-height: 1.78;
            color: #111;
            margin-bottom: 8px;
          }

          p.book-title {
            font-style: italic;
            font-size: 1.03rem;
            line-height: 1.78;
            color: #111;
            text-align: center;
            margin-top: 22px;
            margin-bottom: 22px;
          }

          p.book-title span.roman {
            font-style: normal;
          }

          .hypertext-block {
            font-family: 'Courier New', Courier, monospace;
            font-size: 0.88rem;
            line-height: 1.9;
            color: #111;
            text-align: center;
            margin: 18px 0 22px 0;
          }

          .hypertext-block .bold-word {
            font-weight: 700;
          }

          p.person-para {
            font-size: 1.03rem;
            line-height: 1.78;
            color: #111;
            margin-top: 18px;
          }

        </style>
      </head>
      <body>
        <div class="page">
          <xsl:apply-templates select="book/*"/>
        </div>
      </body>
    </html>
  </xsl:template>

  <!-- ══════════════════
       PARAGRAPH
  ══════════════════ -->
  <xsl:template match="p">
    <p class="body-para">
      <xsl:value-of select="."/>
    </p>
  </xsl:template>

  <!-- ══════════════════
       ITALIC LINES
  ══════════════════ -->
  <xsl:template match="italic">
    <xsl:choose>

      <!-- book title line -->
      <xsl:when test="contains(., 'Gravity of Genius') and contains(., 'Biography')">
        <p class="book-title">
          <em>The Gravity of Genius:</em>
          <xsl:text> </xsl:text>
          <span class="roman">Biography of a Modern Knight.</span>
        </p>
      </xsl:when>

      <!-- dialogue line inside italic -->
      <xsl:when test="contains(., 'Gravity of Genius') and contains(., 'Langdon called out')">
        <p class="italic-line">
          <em>"Gravity of Genius?"</em>
          <xsl:text> Langdon called out to Gettum. "Bio of a modern knight?"</xsl:text>
        </p>
      </xsl:when>

      <!-- all other italic lines -->
      <xsl:otherwise>
        <p class="italic-line">
          <em><xsl:value-of select="."/></em>
        </p>
      </xsl:otherwise>

    </xsl:choose>
  </xsl:template>

  <!-- ══════════════════════════════════════════
       HYPERTEXT BLOCK — FIX:
       wrap ALL hypertext siblings inside one div
       by only triggering on the FIRST hypertext,
       then looping through all of them together
  ══════════════════════════════════════════ -->
  <xsl:template match="hypertext[not(preceding-sibling::hypertext)]">
    <!-- open the wrapper div once, loop all hypertext siblings -->
    <div class="hypertext-block">
      <xsl:for-each select="../hypertext">
        <xsl:call-template name="hypertext-line"/>
      </xsl:for-each>
    </div>
  </xsl:template>

  <!-- skip hypertext nodes that are NOT the first — already handled above -->
  <xsl:template match="hypertext[preceding-sibling::hypertext]"/>

  <!-- named template: render one hypertext line -->
  <xsl:template name="hypertext-line">
    <div>
      <xsl:choose>
        <xsl:when test="contains(., 'knight')">
          <xsl:text>... honorable </xsl:text>
          <span class="bold-word">knight,</span>
          <xsl:text> Sir Isaac Newton...</xsl:text>
        </xsl:when>
        <xsl:when test="contains(., 'London')">
          <xsl:text>... in </xsl:text>
          <span class="bold-word">London</span>
          <xsl:text> in 1727 and...</xsl:text>
        </xsl:when>
        <xsl:when test="contains(., 'tomb')">
          <xsl:text>... his </xsl:text>
          <span class="bold-word">tomb</span>
          <xsl:text> in Westminster Abbey...</xsl:text>
        </xsl:when>
        <xsl:when test="contains(., 'Pope')">
          <xsl:text>... Alexander </xsl:text>
          <span class="bold-word">Pope,</span>
          <xsl:text> friend and colleague...</xsl:text>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="."/>
        </xsl:otherwise>
      </xsl:choose>
    </div>
  </xsl:template>

  <!-- ══════════════════
       PERSON
  ══════════════════ -->
  <xsl:template match="person">
    <p class="person-para">
      <xsl:value-of select="."/>
    </p>
  </xsl:template>

</xsl:stylesheet>
