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
		<xsl:choose>
			<xsl:when test="$nodename='id'">
				<field name="id"> 
					<xsl:value-of select="." />
				</field>
			</xsl:when>
			<xsl:otherwise>
				<field> 
					<xsl:attribute name="name">
						<xsl:value-of select="concat($nodename,'_txt_de')" />
					</xsl:attribute>
					<xsl:value-of select="." />
				</field>				
				<field> 
					<xsl:attribute name="name">
						<xsl:value-of select="concat($nodename,'_str')" />
					</xsl:attribute>
					<xsl:value-of select="." />
				</field>								
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	

</xsl:stylesheet>