<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" 
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:zzz="www.movieinfo.com"
	exclude-result-prefixes="zzz">

	<xsl:param name="center" />
	
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
				<fo:static-content flow-name="header">
					<fo:block>
						<fo:block-container position="absolute" top="2mm"
							left="2mm" width="100%" height="23px">
							<fo:block>
								<fo:external-graphic
									content-width="scale-to-fit" content-height="scale-to-fit"
									src="https://i.ibb.co/PrgB0dx/logo.png" width="150px"
									height="23px" />
							</fo:block>
							<fo:block><fo:leader leader-pattern="rule" leader-length="100%"
									rule-style="solid" rule-thickness="1pt" />
							</fo:block>
						</fo:block-container>
					</fo:block>
				</fo:static-content>
				<fo:static-content flow-name="footer">
					<fo:block>
						<fo:leader leader-pattern="rule" leader-length="100%"
							rule-style="solid" rule-thickness="1pt" />
					</fo:block>
					<fo:table table-layout="fixed" margin-bottom="20px"
						width="100%">
						<fo:table-column column-width="50%" />
						<fo:table-column column-width="50%" />
						<fo:table-body>
							<fo:table-row>
								<fo:table-cell padding="2mm">
									<fo:block text-align="left">MovieInfo. d.o.o.</fo:block>
									<fo:block text-align="left">Koroška cesta 46, 2000 Maribor
									</fo:block>
									<fo:block text-align="left">ID za DDV: SI37682885</fo:block>
									<fo:block text-align="left">Tel.: 00 386 2 88 34 756</fo:block>
									<fo:block text-align="left">
										E-mail: 
										<fo:basic-link
											external-destination="url('movie@info.com')"
											color="blue" text-decoration="underline">
											movie@info.com
										</fo:basic-link>
									</fo:block>
								</fo:table-cell>
								<fo:table-cell padding="2mm">
									<fo:block text-align="right">
										<fo:basic-link
											external-destination="url('http://localhost:8080/KIS_MovieInfo/index.html')"
											color="blue" text-decoration="underline">
											www.movieinfo.com
										</fo:basic-link>
									</fo:block>
									<fo:block text-align="right">Podatki so bili pridobljeni pri MovieInfo.</fo:block>
								</fo:table-cell>
							</fo:table-row>
						</fo:table-body>
					</fo:table>
				</fo:static-content>
				<fo:flow flow-name="xsl-region-body">
					<fo:block>
						<fo:block-container width="190mm" font-size="2em"
							border-color="#009F00" color="#009F00" border-after-style="solid"
							border-width="0.5mm">
							<fo:block>Spored objekta <xsl:value-of select="upper-case($center)" />
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
								<fo:table-header background-color="#DFDFDF">
									<fo:table-cell padding="2mm">
										<fo:block>Datum</fo:block>
									</fo:table-cell>
									<fo:table-cell padding="2mm">
										<fo:block>Kraj</fo:block>
									</fo:table-cell>
									<fo:table-cell padding="2mm">
										<fo:block>Tip</fo:block>
									</fo:table-cell>
									<fo:table-cell padding="2mm">
										<fo:block>Čas</fo:block>
									</fo:table-cell>
									<fo:table-cell padding="2mm">
										<fo:block>Film</fo:block>
									</fo:table-cell>
									<fo:table-cell padding="2mm">
										<fo:block>Dvorana</fo:block>
									</fo:table-cell>
									<fo:table-cell text-align="right" padding="2mm">
										<fo:block>Cena</fo:block>
									</fo:table-cell>
								</fo:table-header>
								<fo:table-body>
									<xsl:for-each select="document('ShowtimeList.xml')/zzz:ShowtimeList/zzz:Showtime[current-date() &lt;= zzz:Date and zzz:Center=$center]">
										<xsl:if test="position() &lt;= 14">
											<xsl:variable name="movieID" select="./@movieID"/>
											<fo:table-row>
												<fo:table-cell padding="2mm">
													<fo:block><xsl:value-of select="format-date(./zzz:Date, '[D01]. [M01]. [Y0001]')"/></fo:block>
												</fo:table-cell>
												<fo:table-cell padding="2mm">
													<fo:block><xsl:value-of select="./zzz:City"/></fo:block>
												</fo:table-cell>
												<fo:table-cell padding="2mm">
													<fo:block>
														<xsl:if test="./zzz:Vstopnica">
															<xsl:value-of select="./zzz:Vstopnica/@tipPredstave"/>
														</xsl:if>
													</fo:block>
												</fo:table-cell>
												<fo:table-cell padding="2mm">
													<fo:block><xsl:value-of select="./zzz:Time"/></fo:block>
												</fo:table-cell>
												<fo:table-cell padding="2mm">
													<fo:block>
														<fo:basic-link color="blue" text-decoration="underline">
														<xsl:attribute name="external-destination">
															url('http://localhost:8080/KIS_MovieInfo/FilmServlet?movieID=<xsl:value-of select="$movieID"/>')
														</xsl:attribute>
														<xsl:choose>
															<xsl:when test="document('MovieList.xml')/zzz:MovieList/zzz:Movie[@movieID=$movieID]/zzz:Title">
																<xsl:value-of select="document('MovieList.xml')/zzz:MovieList/zzz:Movie[@movieID=$movieID]/zzz:Title"/>
															</xsl:when>
															<xsl:otherwise>
																<xsl:value-of select="document('MovieList.xml')/zzz:MovieList/zzz:Movie[@movieID=$movieID]/zzz:OriginalTitle"/>
															</xsl:otherwise>
														</xsl:choose>
														</fo:basic-link>
													</fo:block>
												</fo:table-cell>
												<fo:table-cell padding="2mm">
													<fo:block><xsl:value-of select="./zzz:Theater"/></fo:block>
												</fo:table-cell>
												<fo:table-cell text-align="right" padding="2mm">
													<fo:block>
														<xsl:if test="./zzz:Vstopnica">
															<xsl:value-of select="./zzz:Vstopnica/text()"/><xsl:text> </xsl:text><xsl:value-of select="./zzz:Vstopnica/@valuta"/>
														</xsl:if>
													</fo:block>
												</fo:table-cell>
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