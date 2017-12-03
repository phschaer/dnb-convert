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
		
		
		<!-- 001 - DNB-ID -->
		
		<id>
			<xsl:value-of select="marc:controlfield[@tag=001]"/>
		</id>
		
		<!-- 010 - ISBN -->
		
		<xsl:for-each select="marc:datafield[@tag=020]">
			<isbn>
				<!--><xsl:text>URN:ISBN:</xsl:text>-->
				<xsl:value-of select="marc:subfield[@code='a']"/>
			</isbn>
		</xsl:for-each>		

		<!-- 082 - DDC -->
		
		<xsl:for-each select="marc:datafield[@tag=082]">
			<subject-ddc>
				<xsl:call-template name="subfieldSelect">
					<xsl:with-param name="codes">a</xsl:with-param>
				</xsl:call-template>
			</subject-ddc>
		</xsl:for-each>
		
		<!-- 083 - Sachgruppe -->
		
		<xsl:for-each select="marc:datafield[@tag=083]">
			<subject-sachgruppe>
				<xsl:call-template name="subfieldSelect">
					<xsl:with-param name="codes">a</xsl:with-param>
				</xsl:call-template>
			</subject-sachgruppe>
		</xsl:for-each>
		
		<!-- 100 - Person : Autor -->
		
		<xsl:for-each select="marc:datafield[@tag=100]">
			<author>
				<xsl:call-template name="subfieldSelect">
					<xsl:with-param name="codes">a</xsl:with-param>
				</xsl:call-template>
			</author>
		</xsl:for-each>

		<!-- 700 - Person : Herausgeber -->
		
		<xsl:for-each select="marc:datafield[@tag=700]">
			<editor>
				<xsl:call-template name="subfieldSelect">
					<xsl:with-param name="codes">a</xsl:with-param>
				</xsl:call-template>
			</editor>
		</xsl:for-each>

		<!-- 245 - Titel und Titelzusatz -->		
		
		<xsl:for-each select="marc:datafield[@tag=245]">
			<title>
				<xsl:call-template name="subfieldSelect">
					<xsl:with-param name="codes">ab</xsl:with-param>
				</xsl:call-template>
			</title>
		</xsl:for-each>

		<!-- 264 - Impressum -->				
		
		<xsl:for-each select="marc:datafield[@tag=264]">
			<source>
				<xsl:call-template name="subfieldSelect">
					<xsl:with-param name="codes">abc</xsl:with-param>
				</xsl:call-template>
			</source>
		</xsl:for-each>
		
		<!-- 830 - Reihentitel -->	
		
		<xsl:for-each select="marc:datafield[@tag=830]">
			<source-series>
				<xsl:call-template name="subfieldSelect">
					<xsl:with-param name="codes">av</xsl:with-param>
				</xsl:call-template>
			</source-series>
		</xsl:for-each>
					
		<!-- 600 - Schlagwort-Person -->	
		
		<xsl:for-each select="marc:datafield[@tag=600]">
			<subject-person>
				<xsl:call-template name="subfieldSelect">
					<xsl:with-param name="codes">a</xsl:with-param>
				</xsl:call-template>
			</subject-person>
		</xsl:for-each>		

		<!-- 630 - Schlagwort-Person -->	
		
		<xsl:for-each select="marc:datafield[@tag=630]">
			<subject-corp>
				<xsl:call-template name="subfieldSelect">
					<xsl:with-param name="codes">a</xsl:with-param>
				</xsl:call-template>
			</subject-corp>
		</xsl:for-each>		
		
		<!-- 648 - Schlagwort-Person -->	
		
		<xsl:for-each select="marc:datafield[@tag=648]">
			<subject-time>
				<xsl:call-template name="subfieldSelect">
					<xsl:with-param name="codes">a</xsl:with-param>
				</xsl:call-template>
			</subject-time>
		</xsl:for-each>		
		
		<!-- 650 - Schlagwort -->			
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

		<!-- 651 - Schlagwort-Geo -->							

		<xsl:for-each select="marc:datafield[@tag=651]">
			<subject-geo>
				<xsl:call-template name="subfieldSelect">
					<xsl:with-param name="codes">a</xsl:with-param>
				</xsl:call-template>
			</subject-geo>
		</xsl:for-each>
				
		<!-- 653 - Schlagwort-VLB -->			

		<xsl:for-each select="marc:datafield[@tag=653]">
			<subject-vlb>
				<xsl:call-template name="subfieldSelect">
					<xsl:with-param name="codes">a</xsl:with-param>
				</xsl:call-template>
			</subject-vlb>
		</xsl:for-each>

		<!-- 655 - Schlagwort-Form -->			
		
		<xsl:for-each select="marc:datafield[@tag=655]">			
				<subject-form>
					<xsl:call-template name="subfieldSelect">
						<xsl:with-param name="codes">a</xsl:with-param>
					</xsl:call-template>
				</subject-form>
		</xsl:for-each>

		<!-- 689 - Schlagwort-RSWK -->			
		
		<xsl:for-each select="marc:datafield[@tag=689]">
			<xsl:variable name="rswk">
				<xsl:call-template name="subfieldSelect">
					<xsl:with-param name="codes">a</xsl:with-param>
				</xsl:call-template>
			</xsl:variable>
			<xsl:if test="normalize-space($rswk) != ''">
				<subject-rswk>
					<xsl:value-of select="$rswk" />
				</subject-rswk>
			</xsl:if>
		</xsl:for-each>
				
		<!-- 856 - Links -->			
		
		<xsl:for-each select="marc:datafield[@tag=856]">
			<link>
				<xsl:value-of select="marc:subfield[@code='u']"/>
			</link>
		</xsl:for-each>

	</xsl:template>
</xsl:stylesheet>