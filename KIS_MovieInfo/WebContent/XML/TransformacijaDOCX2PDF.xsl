<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" 
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:dsp="http://schemas.microsoft.com/office/drawing/2008/diagram" 
	xmlns:cppr="http://schemas.microsoft.com/office/2006/coverPageProps" 
	xmlns:odx="http://opendope.org/xpaths" 
	xmlns:c14="http://schemas.microsoft.com/office/drawing/2007/8/2/chart" 
	xmlns:xdr="http://schemas.openxmlformats.org/drawingml/2006/spreadsheetDrawing" 
	xmlns:odgm="http://opendope.org/SmartArt/DataHierarchy" 
	xmlns:w16se="http://schemas.microsoft.com/office/word/2015/wordml/symex" 
	xmlns:wp14="http://schemas.microsoft.com/office/word/2010/wordprocessingDrawing" 
	xmlns:dgm="http://schemas.openxmlformats.org/drawingml/2006/diagram" 
	xmlns:pic="http://schemas.openxmlformats.org/drawingml/2006/picture" 
	xmlns:we="http://schemas.microsoft.com/office/webextensions/webextension/2010/11" 
	xmlns:pvml="urn:schemas-microsoft-com:office:powerpoint" 
	xmlns:mc="http://schemas.openxmlformats.org/markup-compatibility/2006" 
	xmlns:w10="urn:schemas-microsoft-com:office:word" 
	xmlns:wp="http://schemas.openxmlformats.org/drawingml/2006/wordprocessingDrawing" 
	xmlns:sl="http://schemas.openxmlformats.org/schemaLibrary/2006/main" 
	xmlns:w15="http://schemas.microsoft.com/office/word/2012/wordml" 
	xmlns:w14="http://schemas.microsoft.com/office/word/2010/wordml" 
	xmlns:a="http://schemas.openxmlformats.org/drawingml/2006/main" 
	xmlns:comp="http://schemas.openxmlformats.org/drawingml/2006/compatibility" 
	xmlns:b="http://schemas.openxmlformats.org/officeDocument/2006/bibliography" 
	xmlns:c="http://schemas.openxmlformats.org/drawingml/2006/chart" 
	xmlns:xvml="urn:schemas-microsoft-com:office:excel" 
	xmlns:m="http://schemas.openxmlformats.org/officeDocument/2006/math" 
	xmlns:oda="http://opendope.org/answers" 
	xmlns:wne="http://schemas.microsoft.com/office/word/2006/wordml" 
	xmlns:o="urn:schemas-microsoft-com:office:office" 
	xmlns:odc="http://opendope.org/conditions" 
	xmlns:cdr="http://schemas.openxmlformats.org/drawingml/2006/chartDrawing" 
	xmlns:r="http://schemas.openxmlformats.org/officeDocument/2006/relationships" 
	xmlns:odi="http://opendope.org/components" 
	xmlns:v="urn:schemas-microsoft-com:vml" 
	xmlns:w="http://schemas.openxmlformats.org/wordprocessingml/2006/main" 
	xmlns:lc="http://schemas.openxmlformats.org/drawingml/2006/lockedCanvas" 
	xmlns:wps="http://schemas.microsoft.com/office/word/2010/wordprocessingShape" 
	xmlns:odq="http://opendope.org/questions" 
	xmlns:wetp="http://schemas.microsoft.com/office/webextensions/taskpanes/2010/11" 
	xmlns:w16cid="http://schemas.microsoft.com/office/word/2016/wordml/cid" 
	exclude-result-prefixes="w14 w15 w16se w16cid wp14">
	
	<xsl:output method="xml" encoding="UTF-8" indent="yes" />
	
	<xsl:template match="/">
		<fo:root xmlns:fo="http://www.w3.org/1999/XSL/Format" font-family="Times New Roman">
			<fo:layout-master-set>
				<fo:simple-page-master master-name="A4"
					page-width="210mm" page-height="297mm" margin="10mm">
					<fo:region-body space-before="80pt" space-after="80pt" />
					<fo:region-before region-name="header" extent="3cm" />
					<fo:region-after region-name="footer" extent="3cm" />
				</fo:simple-page-master>
			</fo:layout-master-set>
			<fo:page-sequence master-reference="A4"
				initial-page-number="1">
				<fo:title>Spored</fo:title>
				<fo:flow flow-name="xsl-region-body">
					<fo:block>
						<fo:block-container width="190mm" font-size="2em"
							border-color="#009F00" color="#009F00" border-after-style="solid"
							border-width="0.5mm">
							<fo:block><xsl:value-of select="/w:document/w:body/w:p/w:r/w:t"/>
							</fo:block>
						</fo:block-container>
					</fo:block>
					<fo:block>
						<fo:block-container position="absolute"
							width="190mm" left="0mm" top="15mm">
							<fo:table table-layout="fixed" width="100%"
								border-color="#888888" border-width="medium" border-style="solid">
								<fo:table-column column-width="30mm" />
								<fo:table-column column-width="30mm" />
								<fo:table-column column-width="10mm" />
								<fo:table-column column-width="20mm" />
								<fo:table-column column-width="40mm" />
								<fo:table-column column-width="30mm" />
								<fo:table-column column-width="30mm" />
								<xsl:for-each select="/w:document/w:body/w:tbl/w:tr">
									<xsl:if test="position() = 0">
										<fo:table-header background-color="#DFDFDF">
											<xsl:for-each select="./w:tc">
												<fo:table-cell padding="2mm">
													<xsl:if test="position() = last()">
														<xsl:attribute name="text-align">right</xsl:attribute>
													</xsl:if>
													<fo:block><xsl:value-of select="./w:p/w:r/w:t"/></fo:block>
												</fo:table-cell>
											</xsl:for-each>
										</fo:table-header>
									</xsl:if>
								</xsl:for-each>
								<fo:table-body>
									<xsl:for-each select="/w:document/w:body/w:tbl/w:tr">
										<xsl:if test="not(position() = 0) and position() &lt;= 14">
											<fo:table-row>
												<xsl:for-each select="./w:tc">
													<fo:table-cell padding="2mm">
														<xsl:if test="position() = last()">
															<xsl:attribute name="text-align">right</xsl:attribute>
														</xsl:if>
														<fo:block><xsl:value-of select="./w:p/w:r/w:t"/></fo:block>
													</fo:table-cell>
												</xsl:for-each>
											</fo:table-row>
										</xsl:if>
									</xsl:for-each>
								</fo:table-body>
							</fo:table>
						</fo:block-container>
					</fo:block>
				</fo:flow>
			</fo:page-sequence>
		</fo:root>
	</xsl:template>
</xsl:stylesheet>