<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:marc="http://www.loc.gov/MARC21/slim" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" exclude-result-prefixes="marc" >
	<xsl:import href="http://www.loc.gov/standards/marcxml/xslt/MARC21slimUtils.xsl"/>
	<xsl:output method="xml" indent="yes" encoding="UTF-8"/>

	<xsl:template match="/">
		<xsl:if test="marc:collection">
			<collection>
				<xsl:for-each select="marc:collection">
					<xsl:for-each select="marc:record">
						<doc>
							<xsl:apply-templates select="."/>
						</doc>
					</xsl:for-each>
				</xsl:for-each>
			</collection>
		</xsl:if>
		<xsl:if test="marc:record">
			<doc>
				<xsl:apply-templates/>
			</doc>
		</xsl:if>
	</xsl:template>
	<xsl:template match="marc:record">
		<xsl:variable name="leader" select="marc:leader"/>
		<xsl:variable name="leader6" select="substring($leader,7,1)"/>
		<xsl:variable name="leader7" select="substring($leader,8,1)"/>
		<xsl:variable name="controlField008" select="marc:controlfield[@tag=008]"/>
		
		<id>
			<xsl:value-of select="marc:controlfield[@tag=001]"/>
		</id>
		
		<xsl:for-each select="marc:datafield[@tag=245]">
			<title>
				<xsl:call-template name="subfieldSelect">
					<xsl:with-param name="codes">ab</xsl:with-param>
				</xsl:call-template>
			</title>
		</xsl:for-each>

		<xsl:for-each select="marc:datafield[@tag=100]">
			<author>
				<xsl:call-template name="subfieldSelect">
					<xsl:with-param name="codes">a</xsl:with-param>
				</xsl:call-template>
			</author>
		</xsl:for-each>
		
		<xsl:for-each select="marc:datafield[@tag=700]">
			<editor>
				<xsl:call-template name="subfieldSelect">
					<xsl:with-param name="codes">a</xsl:with-param>
				</xsl:call-template>
			</editor>
		</xsl:for-each>
		
		<xsl:for-each select="marc:datafield[@tag=264]">
			<source>
				<xsl:call-template name="subfieldSelect">
					<xsl:with-param name="codes">abc</xsl:with-param>
				</xsl:call-template>
			</source>
		</xsl:for-each>
		
		<!-- erweiterter Abschnitt für die Umsetzung der maschinellen Verschlagwortung -->
		<xsl:for-each select="marc:datafield[@tag=650]">
			<xsl:choose>
				<xsl:when test="../marc:datafield[@tag=883]/marc:subfield[@code='a'] = 'maschinell gebildet' and marc:subfield[@code='8']/text() = ../marc:datafield[@tag=883]/marc:subfield[@code='8']/text()">
					<subject-auto>
						<xsl:call-template name="subfieldSelect">
							<xsl:with-param name="codes">abcdq</xsl:with-param>
						</xsl:call-template>
					</subject-auto>
				</xsl:when>
				<xsl:otherwise>
					<subject-intel>
						<xsl:call-template name="subfieldSelect">
							<xsl:with-param name="codes">abcdq</xsl:with-param>
						</xsl:call-template>
					</subject-intel>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:for-each>
		<!-- END  -->
		
		<xsl:for-each select="marc:datafield[@tag=082]">
			<subject-ddc>
				<xsl:call-template name="subfieldSelect">
					<xsl:with-param name="codes">a</xsl:with-param>
				</xsl:call-template>
			</subject-ddc>
		</xsl:for-each>
		
		<xsl:for-each select="marc:datafield[@tag=083]">
			<subject-sachgruppe>
				<xsl:call-template name="subfieldSelect">
					<xsl:with-param name="codes">a</xsl:with-param>
				</xsl:call-template>
			</subject-sachgruppe>
		</xsl:for-each>
		
		<xsl:for-each select="marc:datafield[@tag=651]">
			<subject-geo>
				<xsl:call-template name="subfieldSelect">
					<xsl:with-param name="codes">a</xsl:with-param>
				</xsl:call-template>
			</subject-geo>
		</xsl:for-each>
		
		<xsl:for-each select="marc:datafield[@tag=653]">
			<subject-vlb>
				<xsl:call-template name="subfieldSelect">
					<xsl:with-param name="codes">a</xsl:with-param>
				</xsl:call-template>
			</subject-vlb>
		</xsl:for-each>
		
		<xsl:for-each select="marc:datafield[@tag=689]">
			<subject-rswk>
				<xsl:call-template name="subfieldSelect">
					<xsl:with-param name="codes">aD</xsl:with-param>
				</xsl:call-template>
			</subject-rswk>
		</xsl:for-each>
		
		<xsl:for-each select="marc:datafield[@tag=490]">
			<source-series>
				<xsl:call-template name="subfieldSelect">
					<xsl:with-param name="codes">a</xsl:with-param>
				</xsl:call-template>
			</source-series>
		</xsl:for-each>
		
		<!-- default information on identifiers -->
		<xsl:for-each select="marc:datafield[@tag=856]">
			<link>
				<xsl:value-of select="marc:subfield[@code='u']"/>
			</link>
		</xsl:for-each>
		<xsl:for-each select="marc:datafield[@tag=020]">
			<isbn>
				<!--><xsl:text>URN:ISBN:</xsl:text>-->
				<xsl:value-of select="marc:subfield[@code='a']"/>
			</isbn>
		</xsl:for-each>
		<!--</oai_dc>-->
	</xsl:template>
</xsl:stylesheet>