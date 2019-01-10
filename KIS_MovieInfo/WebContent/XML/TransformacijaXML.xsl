<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
	xmlns:zzz="www.movieinfo.com">
	
	<!-- želimo imeti seznam novih filmov, ki so v koloseju Ljubljana pred 19h zvečer, z oceno IMDB 7.2 ali več;
	     skupaj z vsemi filmi popularnimi filmi, nastalih v zadnjih 5 letih, ki so bili tehnologije 3D
	     zapisane naj bodo tudi predstave -->
	<xsl:template match="/">
		<MovieList 
			xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
			xmlns="www.movieinfo.com"
			xsi:schemaLocation="www.movieinfo.com Besednjak.xsd">
			
			<xsl:for-each select="zzz:MovieList/zzz:Movie[@kategorija='novi']">
				<xsl:variable name="movieID" select="./@movieID"/>
				<xsl:variable name="IMDBValue" select="number(substring-before(./zzz:Ratings/zzz:Rating[zzz:Source='IMDB']/zzz:Value/text(), '/'))" />
				<xsl:if test="$IMDBValue>=7.2 and document('ShowtimeList.xml')/zzz:ShowtimeList/zzz:Showtime/zzz:Center/text()='Kolosej Ljubljana' and number(substring-before(document('ShowtimeList.xml')/zzz:ShowtimeList/zzz:Showtime[@movieID=$movieID]/zzz:Time/text(), ':'))&lt;19">
					<Movie>
						<xsl:attribute name="movieID"><xsl:value-of select="@movieID" /></xsl:attribute>
						<xsl:if test="@kategorija">
							<xsl:attribute name="kategorija"><xsl:value-of select="@kategorija" /></xsl:attribute>
						</xsl:if>
						<OriginalTitle><xsl:value-of select="./zzz:OriginalTitle" /></OriginalTitle>
						<xsl:if test="zzz:Trailer">
							<Trailer><xsl:value-of select="./zzz:Trailer" /></Trailer>
						</xsl:if>
						<Genre><xsl:value-of select="./zzz:Genre" /></Genre>
						<xsl:if test="zzz:Rated">
							<Rated><xsl:value-of select="./zzz:Rated" /></Rated>
						</xsl:if>
						<Year><xsl:value-of select="./zzz:Year" /></Year>
						<Duration enota="minut"><xsl:value-of select="./zzz:Duration" /></Duration>
						<xsl:if test="zzz:Director">
							<Director><xsl:value-of select="./zzz:Director" /></Director>
						</xsl:if>
						<xsl:if test="zzz:Producer">
						<Producer><xsl:value-of select="./zzz:Producer" /></Producer>
						</xsl:if>
						<xsl:if test="zzz:Writer">
						<Writer><xsl:value-of select="./zzz:Writer" /></Writer>
						</xsl:if>
						<Cast><xsl:value-of select="./zzz:Cast" /></Cast>
						<xsl:if test="zzz:Distributor">
							<Distributor><xsl:value-of select="./zzz:Distributor" /></Distributor>
						</xsl:if>
						<Language><xsl:value-of select="./zzz:Language" /></Language>
						<Country><xsl:value-of select="./zzz:Country" /></Country>
						<PlotOutline><xsl:value-of select="./zzz:PlotOutline" /></PlotOutline>
						<xsl:if test="zzz:KolosejMovieID">
							<KolosejMovieID>
								<xsl:attribute name="value"><xsl:value-of select="./zzz:KolosejMovieID/@value" /></xsl:attribute>
							</KolosejMovieID>
						</xsl:if>
						<xsl:if test="zzz:Title">
							<Title><xsl:value-of select="./zzz:Title" /></Title>
						</xsl:if>
						<xsl:if test="zzz:Punchline">
							<Punchline><xsl:value-of select="./zzz:Punchline" /></Punchline>
						</xsl:if>
						<xsl:if test="zzz:URL">
							<URL><xsl:value-of select="./zzz:URL" /></URL>
						</xsl:if>
						<xsl:if test="zzz:Poster">
							<Poster><xsl:value-of select="./zzz:Poster" /></Poster>
						</xsl:if>
						<xsl:if test="zzz:Award">
							<Award><xsl:value-of select="./zzz:Award" /></Award>
						</xsl:if>
						<xsl:if test="zzz:IMDBID">
							<IMDBID>
								<xsl:attribute name="value"><xsl:value-of select="./zzz:IMDBID/@value" /></xsl:attribute>
							</IMDBID>
						</xsl:if>
						<xsl:if test="zzz:Localization">
							<Localization><xsl:value-of select="./zzz:Localization" /></Localization>
						</xsl:if>
						<SumOfScores><xsl:value-of select="./zzz:SumOfScores" /></SumOfScores>
						<NumOfScores><xsl:value-of select="./zzz:NumOfScores" /></NumOfScores>
						<NaVoljo><xsl:value-of select="./zzz:NaVoljo" /></NaVoljo>
						
						<xsl:if test="zzz:Ratings">
							<Ratings>
								<xsl:for-each select="./zzz:Ratings/zzz:Rating">
									<Rating>
										<Source><xsl:value-of select="./zzz:Source" /></Source>
										<Value><xsl:value-of select="./zzz:Value" /></Value>
									</Rating>
								</xsl:for-each>
							</Ratings>
						</xsl:if>
						<Showtimes>
							<xsl:for-each select="document('ShowtimeList.xml')/zzz:ShowtimeList/zzz:Showtime">
								<xsl:if test="@movieID=$movieID and $IMDBValue>=7.2 and number(substring-before(./zzz:Time/text(), ':'))&lt;19 and ./zzz:Center/text()='Kolosej Ljubljana'">
									<Showtime>
										<xsl:attribute name="showtimeID"><xsl:value-of select="@showtimeID" /></xsl:attribute>
										<xsl:attribute name="movieID"><xsl:value-of select="@movieID" /></xsl:attribute>
										<xsl:if test="zzz:KolosejShowtimeID">
											<KolosejShowtimeID>
												<xsl:attribute name="value"><xsl:value-of select="./zzz:KolosejShowtimeID/@value" /></xsl:attribute>
											</KolosejShowtimeID>
										</xsl:if>
										<Date><xsl:value-of select="./zzz:Date" /></Date>
										<Time><xsl:value-of select="./zzz:Time" /></Time>
										<City><xsl:value-of select="./zzz:City" /></City>
										<Center><xsl:value-of select="./zzz:Center" /></Center>
										<Theater><xsl:value-of select="./zzz:Theater" /></Theater>
									</Showtime>
								</xsl:if>
							</xsl:for-each>
						</Showtimes>
					</Movie>
				</xsl:if>
			</xsl:for-each>
			
			<!-- leto je statično nastavljeno, ker xslt 1.0 ne podpira date funkcij, 2.0 pa nisem želel nastavljati, ker sem komaj popravil napako z transformacijskim pogonom v eclipsu -->
			<xsl:for-each select="zzz:MovieList/zzz:Movie[@kategorija='popularni' and 2018-number(./zzz:Year/text())&lt;=5]">
				<xsl:variable name="movieID" select="./@movieID"/>
				<xsl:if test="document('ShowtimeList.xml')/zzz:ShowtimeList/zzz:Showtime[@movieID=$movieID]/zzz:Vstopnica[@tipPredstave='3D']">
				<Movie>
						<xsl:attribute name="movieID"><xsl:value-of select="@movieID" /></xsl:attribute>
						<xsl:if test="@kategorija">
							<xsl:attribute name="kategorija"><xsl:value-of select="@kategorija" /></xsl:attribute>
						</xsl:if>
						<OriginalTitle><xsl:value-of select="./zzz:OriginalTitle" /></OriginalTitle>
						<xsl:if test="zzz:Trailer">
							<Trailer><xsl:value-of select="./zzz:Trailer" /></Trailer>
						</xsl:if>
						<Genre><xsl:value-of select="./zzz:Genre" /></Genre>
						<xsl:if test="zzz:Rated">
							<Rated><xsl:value-of select="./zzz:Rated" /></Rated>
						</xsl:if>
						<Year><xsl:value-of select="./zzz:Year" /></Year>
						<Duration enota="minut"><xsl:value-of select="./zzz:Duration" /></Duration>
						<xsl:if test="zzz:Director">
							<Director><xsl:value-of select="./zzz:Director" /></Director>
						</xsl:if>
						<xsl:if test="zzz:Producer">
						<Producer><xsl:value-of select="./zzz:Producer" /></Producer>
						</xsl:if>
						<xsl:if test="zzz:Writer">
						<Writer><xsl:value-of select="./zzz:Writer" /></Writer>
						</xsl:if>
						<Cast><xsl:value-of select="./zzz:Cast" /></Cast>
						<xsl:if test="zzz:Distributor">
							<Distributor><xsl:value-of select="./zzz:Distributor" /></Distributor>
						</xsl:if>
						<Language><xsl:value-of select="./zzz:Language" /></Language>
						<Country><xsl:value-of select="./zzz:Country" /></Country>
						<PlotOutline><xsl:value-of select="./zzz:PlotOutline" /></PlotOutline>
						<xsl:if test="zzz:KolosejMovieID">
							<KolosejMovieID>
								<xsl:attribute name="value"><xsl:value-of select="./zzz:KolosejMovieID/@value" /></xsl:attribute>
							</KolosejMovieID>
						</xsl:if>
						<xsl:if test="zzz:Title">
							<Title><xsl:value-of select="./zzz:Title" /></Title>
						</xsl:if>
						<xsl:if test="zzz:Punchline">
							<Punchline><xsl:value-of select="./zzz:Punchline" /></Punchline>
						</xsl:if>
						<xsl:if test="zzz:URL">
							<URL><xsl:value-of select="./zzz:URL" /></URL>
						</xsl:if>
						<xsl:if test="zzz:Poster">
							<Poster><xsl:value-of select="./zzz:Poster" /></Poster>
						</xsl:if>
						<xsl:if test="zzz:Award">
							<Award><xsl:value-of select="./zzz:Award" /></Award>
						</xsl:if>
						<xsl:if test="zzz:IMDBID">
							<IMDBID>
								<xsl:attribute name="value"><xsl:value-of select="./zzz:IMDBID/@value" /></xsl:attribute>
							</IMDBID>
						</xsl:if>
						<xsl:if test="zzz:Localization">
							<Localization><xsl:value-of select="./zzz:Localization" /></Localization>
						</xsl:if>
						<SumOfScores><xsl:value-of select="./zzz:SumOfScores" /></SumOfScores>
						<NumOfScores><xsl:value-of select="./zzz:NumOfScores" /></NumOfScores>
						<NaVoljo><xsl:value-of select="./zzz:NaVoljo" /></NaVoljo>
						
						<xsl:if test="zzz:Ratings">
							<Ratings>
								<xsl:for-each select="./zzz:Ratings/zzz:Rating">
									<Rating>
										<Source><xsl:value-of select="./zzz:Source" /></Source>
										<Value><xsl:value-of select="./zzz:Value" /></Value>
									</Rating>
								</xsl:for-each>
							</Ratings>
						</xsl:if>
						<Showtimes>
							<xsl:for-each select="document('ShowtimeList.xml')/zzz:ShowtimeList/zzz:Showtime">
								<xsl:if test="@movieID=$movieID and ./zzz:Vstopnica[@tipPredstave='3D']">
									<Showtime>
										<xsl:attribute name="showtimeID"><xsl:value-of select="@showtimeID" /></xsl:attribute>
										<xsl:attribute name="movieID"><xsl:value-of select="@movieID" /></xsl:attribute>
										<xsl:if test="zzz:KolosejShowtimeID">
											<KolosejShowtimeID>
												<xsl:attribute name="value"><xsl:value-of select="./zzz:KolosejShowtimeID/@value" /></xsl:attribute>
											</KolosejShowtimeID>
										</xsl:if>
										<Date><xsl:value-of select="./zzz:Date" /></Date>
										<Time><xsl:value-of select="./zzz:Time" /></Time>
										<City><xsl:value-of select="./zzz:City" /></City>
										<Center><xsl:value-of select="./zzz:Center" /></Center>
										<Theater><xsl:value-of select="./zzz:Theater" /></Theater>
									</Showtime>
								</xsl:if>
							</xsl:for-each>
						</Showtimes>
					</Movie>
				</xsl:if>
			</xsl:for-each>
		</MovieList>
	</xsl:template>
	
</xsl:stylesheet>