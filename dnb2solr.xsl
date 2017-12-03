<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" >
	<xsl:output method="xml" indent="yes" encoding="UTF-8"/>

	<xsl:template match="/">
		<add>
			<xsl:apply-templates select="//doc" />
		</add>
	</xsl:template>

	<xsl:template match="doc">
		<doc>
			<xsl:apply-templates />
		</doc>
	</xsl:template>
	
	<xsl:template match="*">
		<xsl:variable name="nodename" select="local-name(.)" />
		<field> 
			<xsl:attribute name="name">
				<xsl:value-of select="$nodename" />
			</xsl:attribute>
			<xsl:value-of select="." />
		</field>
	</xsl:template>
	

</xsl:stylesheet>