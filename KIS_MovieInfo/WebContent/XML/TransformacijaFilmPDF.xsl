<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" 
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:zzz="www.movieinfo.com"
	exclude-result-prefixes="zzz">

	<xsl:param name="movieID" />
	
	<xsl:output method="xml" encoding="UTF-8" indent="yes" />
	
	<xsl:template match="/">
		<xsl:variable name="izbran_film" select="zzz:MovieList/zzz:Movie[@movieID=$movieID]" />
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
				<fo:title>Film</fo:title>
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
							<fo:block>
								<fo:leader leader-pattern="rule" leader-length="100%" rule-style="solid" rule-thickness="1pt" />
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
							<fo:block>
								<xsl:text>Podatki o filmu </xsl:text>
								<xsl:choose>
									<xsl:when test="$izbran_film/zzz:Title">
										<xsl:value-of select="upper-case($izbran_film/zzz:Title)"/>
									</xsl:when>
									<xsl:otherwise>
										<xsl:value-of select="upper-case($izbran_film/zzz:OriginalTitle)"/>
									</xsl:otherwise>
								</xsl:choose>
							</fo:block>
						</fo:block-container>
					</fo:block>
					<fo:block>
						<fo:block-container position="absolute"
							width="50%" left="5mm" top="20mm" text-align="left">
							<fo:block background-color="#FFF1A5" padding="2mm">Osnovni podatki: </fo:block>
							<fo:block>Originalni naslov: <fo:inline font-weight="bold"><xsl:value-of select="$izbran_film/zzz:OriginalTitle"/></fo:inline></fo:block>
							<fo:block>Žanr: <fo:inline font-weight="bold"><xsl:value-of select="$izbran_film/zzz:Genre" /></fo:inline></fo:block>
							<xsl:if test="$izbran_film/zzz:Rated">
								<fo:block>Omejitev starosti: <fo:inline font-weight="bold"><xsl:value-of select="$izbran_film/zzz:Rated"/></fo:inline></fo:block>
							</xsl:if>
							<fo:block>Leto: <fo:inline font-weight="bold"><xsl:value-of select="$izbran_film/zzz:Year"/></fo:inline></fo:block>
							<fo:block>
								Dolžina: <fo:inline font-weight="bold"><xsl:value-of select="$izbran_film/zzz:Duration"/></fo:inline>
								<xsl:text> </xsl:text>
								<xsl:if test="$izbran_film/zzz:Duration/@enota">
									<fo:inline font-weight="bold"><xsl:value-of select="$izbran_film/zzz:Duration/@enota"/></fo:inline>
								</xsl:if>
							</fo:block>
							<fo:block>
								<xsl:if test="$izbran_film/zzz:Writer">
									Scenarij: 
										<xsl:for-each select="$izbran_film/zzz:Writer">
											<fo:inline font-weight="bold"><xsl:value-of select="./text()"/>,</fo:inline>
										</xsl:for-each>
								</xsl:if>
							</fo:block>
							<fo:block>
								<xsl:if test="$izbran_film/zzz:Director">
									Direktor: 
										<xsl:for-each select="$izbran_film/zzz:Director">
											<fo:inline font-weight="bold"><xsl:value-of select="./text()"/>,</fo:inline>
										</xsl:for-each>
								</xsl:if>
							</fo:block>
							<fo:block>Igrajo: <fo:inline font-weight="bold"><xsl:value-of select="$izbran_film/zzz:Cast"/></fo:inline></fo:block>
							<fo:block>
								<xsl:if test="$izbran_film/zzz:Producer">
									Producent: 
										<xsl:for-each select="$izbran_film/zzz:Producer">
											<fo:inline font-weight="bold"><xsl:value-of select="./text()"/>,</fo:inline>
										</xsl:for-each>
								</xsl:if>
							</fo:block>
							<fo:block>
								<xsl:if test="$izbran_film/zzz:Distributor">
									Distribucija: <fo:inline font-weight="bold"><xsl:value-of select="$izbran_film/zzz:Distributor"/></fo:inline>
								</xsl:if>
							</fo:block>
							<fo:block>
								Jezik
								<xsl:if test="$izbran_film/zzz:Language/@jezik">
									(<xsl:value-of select="substring($izbran_film/zzz:Language/@jezik,0,4)"/>.): 
								</xsl:if> 
								<fo:inline font-weight="bold"><xsl:value-of select="$izbran_film/zzz:Language"/></fo:inline>
							</fo:block>
							<fo:block>
								Država
								<xsl:if test="$izbran_film/zzz:Country/@jezik">
									(<xsl:value-of select="substring($izbran_film/zzz:Country/@jezik,0,4)"/>.): 
								</xsl:if> 
								<fo:inline font-weight="bold"><xsl:value-of select="$izbran_film/zzz:Country"/></fo:inline>
							</fo:block>
							<fo:block margin-top="5mm" background-color="#FFF1A5" padding="2mm">Ostali podatki: </fo:block>
							<fo:block>
								<xsl:if test="$izbran_film/zzz:Punchline">
									Fraza: <fo:inline font-weight="bold"><xsl:value-of select="$izbran_film/zzz:Punchline"/></fo:inline>
								</xsl:if>
							</fo:block>
							<fo:block>
								<xsl:if test="$izbran_film/zzz:IMDBID">
									IMDB: <fo:inline font-weight="bold">
									<fo:basic-link color="blue" text-decoration="underline">
										<xsl:attribute name="external-destination">
											<xsl:text>url('https://www.imdb.com/title/</xsl:text>
											<xsl:value-of select="$izbran_film/zzz:IMDBID/@value"/>
											<xsl:text>')</xsl:text>
										</xsl:attribute>
										https://www.imdb.com/title/<xsl:value-of select="$izbran_film/zzz:IMDBID/@value"/>
									</fo:basic-link></fo:inline>
								</xsl:if>
							</fo:block>
							<fo:block>
								<xsl:if test="$izbran_film/zzz:URL">
									Kolosej: <fo:inline font-weight="bold">
									<fo:basic-link color="blue" text-decoration="underline">
										<xsl:attribute name="external-destination">
											<xsl:text>url('</xsl:text>
											<xsl:value-of select="$izbran_film/zzz:URL"/>
											<xsl:text>')</xsl:text>
										</xsl:attribute>
										<xsl:value-of select="$izbran_film/zzz:URL"/>
									</fo:basic-link></fo:inline>
								</xsl:if>
							</fo:block>
							<fo:block>
								<xsl:if test="$izbran_film/zzz:Award">
									Nagrade: <fo:inline font-weight="bold"><xsl:value-of select="$izbran_film/zzz:Award"/></fo:inline>
								</xsl:if>
							</fo:block>
							<fo:block>
								<xsl:if test="$izbran_film/zzz:Localization">
									Lokalizacija: <fo:inline font-weight="bold"><xsl:value-of select="$izbran_film/zzz:Localization"/></fo:inline>
								</xsl:if>
							</fo:block>
							<fo:block>
								<xsl:if test="$izbran_film/zzz:NaVoljo=0">
									Status: <fo:inline font-weight="bold">Ni na voljo</fo:inline>
								</xsl:if>
								<xsl:if test="$izbran_film/zzz:NaVoljo=1">
									Status: <fo:inline font-weight="bold">Na voljo</fo:inline>
								</xsl:if>
							</fo:block>
							<xsl:if test="$izbran_film/zzz:Ratings">
								<fo:block>Ocene:</fo:block>
								<fo:list-block>
									<xsl:for-each select="$izbran_film/zzz:Ratings/zzz:Rating">
										<fo:list-item>
											<fo:list-item-label end-indent="label-end()">
												<fo:block>
													<fo:inline font-family="Symbol">&#183;</fo:inline>
												</fo:block>
											</fo:list-item-label>
											<fo:list-item-body start-indent="body-start()">
												<fo:block>
													<fo:inline font-weight="bold"><xsl:value-of select="./zzz:Source"/> - <xsl:value-of select="./zzz:Value"/></fo:inline>
												</fo:block>
											</fo:list-item-body>
										</fo:list-item>
									</xsl:for-each>
								</fo:list-block>
							</xsl:if>
						</fo:block-container>
						<fo:block-container position="absolute" width="45%" left="105mm" top="20mm">
							<fo:block>
								<xsl:choose>
									<xsl:when test="$izbran_film/zzz:Poster and substring($izbran_film/zzz:Poster,0,6)='https'">
										<fo:external-graphic content-width="scale-to-fit" content-height="scale-to-fit" width="226px" height="326px">
											<xsl:attribute name="src">
												<xsl:value-of select="$izbran_film/zzz:Poster" />
											</xsl:attribute>
										</fo:external-graphic>
									</xsl:when>
									<xsl:when test="$izbran_film/zzz:Poster and substring($izbran_film/zzz:Poster,0,5)='http'">
										<fo:external-graphic content-width="scale-to-fit" content-height="scale-to-fit" width="226px" height="326px">
											<xsl:attribute name="src">
												https<xsl:value-of select="substring-after($izbran_film/zzz:Poster,'p')" />
											</xsl:attribute>
										</fo:external-graphic>
									</xsl:when>
									<xsl:otherwise>
										<fo:external-graphic src="https://i.ibb.co/ZzsSLFY/movie-poster.jpg" content-width="scale-to-fit" content-height="scale-to-fit" width="226px" height="326px" />
									</xsl:otherwise>
								</xsl:choose>
							</fo:block>
							<fo:block>Vsebina:</fo:block>
							<fo:block><fo:inline font-weight="bold"><xsl:value-of select="substring($izbran_film/zzz:PlotOutline,0,186)"/>...</fo:inline></fo:block>
						</fo:block-container>
					</fo:block>
					<xsl:if test="document('ShowtimeList.xml')/zzz:ShowtimeList/zzz:Showtime[@movieID=$izbran_film/@movieID and current-date() &lt;= zzz:Date]">
						<fo:block>
							<fo:block-container position="absolute" width="190mm" left="0mm" top="170mm">
								<fo:block>Predstave filma</fo:block>
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
											<fo:block>Objekt</fo:block>
										</fo:table-cell>
										<fo:table-cell padding="2mm">
											<fo:block>Dvorana</fo:block>
										</fo:table-cell>
										<fo:table-cell text-align="right" padding="2mm">
											<fo:block>Cena</fo:block>
										</fo:table-cell>
									</fo:table-header>
									<fo:table-body>
										<xsl:for-each select="document('ShowtimeList.xml')/zzz:ShowtimeList/zzz:Showtime[@movieID=$izbran_film/@movieID and current-date() &lt;= zzz:Date]">
											<xsl:if test="position() &lt;= 3">
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
														<fo:block><xsl:value-of select="./zzz:Center"/></fo:block>
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
					</xsl:if>
				</fo:flow>
			</fo:page-sequence>
		</fo:root>
	</xsl:template>
</xsl:stylesheet>