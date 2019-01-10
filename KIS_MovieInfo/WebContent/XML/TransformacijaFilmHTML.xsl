<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" 
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:zzz="www.movieinfo.com"
	exclude-result-prefixes="zzz">

	<xsl:param name="movieID" />
	
	<xsl:output method="html" encoding="UTF-8" indent="yes" omit-xml-declaration="yes" doctype-public="string"  />

	<xsl:template match="/">
		<html lang="en">
			<head>
				<meta charset="utf-8" />
				<meta name="viewport" content="width=device-width, initial-scale=1" />
				<title>MovieInfo | Filmi</title>
				<meta name="description" content="Free Bootstrap Theme by uicookies.com" />
				<meta name="keywords" content="free website templates, free bootstrap themes, free template, free bootstrap, free website template" />
				<link href="https://fonts.googleapis.com/css?family=Open+Sans:300,400" rel="stylesheet" />
				<link rel="stylesheet" href="css/styles-merged.css" />
				<link rel="stylesheet" href="css/style.min.css" />
				<link rel="stylesheet" href="css/custom.css" />
			</head>
			<body>
				<div class="probootstrap-loader"></div>
				
				<header role="banner" class="probootstrap-header">
					<div class="container">
						<a href="index.html" class="probootstrap-logo">MovieInfo<span>.</span></a>
			
						<a href="#" class="probootstrap-burger-menu visible-xs"><i>Meni</i></a>
						<div class="mobile-menu-overlay"></div>
			
						<nav role="navigation" class="probootstrap-nav hidden-xs">
							<ul class="probootstrap-main-nav">
								<li class="active">
									<form style="display:inline; margin:0px; padding:0px;" id="filmi_form" action="/KIS_MovieInfo/FilmiServlet" method="get">
										<a onclick="document.getElementById('filmi_form').submit(); return false;">Filmi</a>
									</form>
								</li>
								<li><a href="seznamFilmovSAX.jsp">Filmi (SAX)</a></li>
								<li>
									<form style="display:inline; margin:0px; padding:0px;" id="predstave_form" action="/KIS_MovieInfo/PredstaveServlet" method="get">
										<a onclick="document.getElementById('predstave_form').submit(); return false;">Predstave</a>
									</form>
								</li>
								<li>
									<form style="display:inline; margin:0px; padding:0px;" id="aktualno_form" action="/KIS_MovieInfo/AktualnoServlet" method="get">
										<a onclick="document.getElementById('aktualno_form').submit(); return false;">Aktualno</a>
									</form>
								</li>
								<li>
									<form style="display:inline; margin:0px; padding:0px;" id="aktualno_dom_form" action="/KIS_MovieInfo/TransformacijaXML" method="get">
										<a onclick="document.getElementById('aktualno_dom_form').submit(); return false;">Aktualno (DOM)</a>
									</form>
								</li>
								<li>
									<form style="display:inline; margin:0px; padding:0px;" id="pretvorbe_form" action="/KIS_MovieInfo/PretvorbeServlet" method="get">
										<a onclick="document.getElementById('pretvorbe_form').submit(); return false;">Pretvorbe</a>
									</form>
								</li>
							</ul>
							<ul class="probootstrap-right-nav hidden-xs">
								<li><a href="https://twitter.com/denisbobovnik"><i class="icon-twitter"></i></a></li>
								<li><a href="https://www.facebook.com/bobovnikdenis"><i class="icon-facebook2"></i></a></li>
								<li><a href="https://www.instagram.com/denis.bobovnik/"><i class="icon-instagram2"></i></a></li>
							</ul>
							<div class="extra-text visible-xs">
								<a href="#" class="probootstrap-burger-menu"><i>Meni</i></a>
								<h5>Naslov</h5>
								<p>Koroška cesta 46, 2000 Maribor</p>
								<h5>Poveži se</h5>
								<ul class="social-buttons">
									<li><a href="https://twitter.com/denisbobovnik"><i class="icon-twitter"></i></a></li>
									<li><a href="https://www.facebook.com/bobovnikdenis"><i class="icon-facebook2"></i></a></li>
									<li><a href="https://www.instagram.com/denis.bobovnik/"><i class="icon-instagram2"></i></a></li>
								</ul>
							</div>
						</nav>
					</div>
				</header>
				
				<xsl:choose>
					<xsl:when test="zzz:MovieList/zzz:Movie[@movieID=$movieID]">
						<xsl:variable name="izbran_film" select="zzz:MovieList/zzz:Movie[@movieID=$movieID]" />
						
						<section class="page-title">
							<div class="container">
								<xsl:choose>
									<xsl:when test="$izbran_film/zzz:Title">
										<h1><xsl:value-of select="$izbran_film/zzz:Title"/></h1>
									</xsl:when>
									<xsl:otherwise>
										<h1><xsl:value-of select="$izbran_film/zzz:OriginalTitle"/></h1>
									</xsl:otherwise>
								</xsl:choose>
								<h5><xsl:value-of select="$izbran_film/zzz:OriginalTitle"/>
									<xsl:text disable-output-escaping="yes"><![CDATA[&nbsp;]]></xsl:text>
									<xsl:text disable-output-escaping="yes"><![CDATA[&nbsp;]]></xsl:text>
									<xsl:text disable-output-escaping="yes"><![CDATA[&nbsp;]]></xsl:text>
									<xsl:text disable-output-escaping="yes"><![CDATA[&nbsp;]]></xsl:text>
									<xsl:choose>
										<xsl:when test="contains($izbran_film/zzz:Genre, ',')">
											<xsl:for-each select="tokenize($izbran_film/zzz:Genre,', ')">
												<span class="badge badge-secondary"><xsl:sequence select="."/></span>
												<xsl:text disable-output-escaping="yes"><![CDATA[&nbsp;]]></xsl:text>
												<xsl:text disable-output-escaping="yes"><![CDATA[&nbsp;]]></xsl:text>
											</xsl:for-each>
										</xsl:when>
										<xsl:otherwise>
											<span class="badge badge-secondary"><xsl:value-of select="$izbran_film/zzz:Genre" /></span>
										</xsl:otherwise>
									</xsl:choose>
								</h5>
							</div>
						</section>
						
						<section class="probootstrap-section">
							<div class="container">
								<div class="row">
									<div class="col-md-9">
										<xsl:if test="$izbran_film/zzz:Trailer">
											<xsl:for-each select="$izbran_film/zzz:Trailer">
												<iframe width="858" height="480" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen="">
													<xsl:attribute name="src"><xsl:value-of select="."/></xsl:attribute>
												</iframe>
											</xsl:for-each>
										</xsl:if>
									
										<xsl:if test="$izbran_film/zzz:Punchline">
											<h4><xsl:value-of select="$izbran_film/zzz:Punchline"/></h4>
										</xsl:if>
										
										<h2>Vsebina</h2>
										<p><xsl:value-of select="$izbran_film/zzz:PlotOutline"/></p>
					
										<xsl:if test="$izbran_film/zzz:Award">
											<h2>Nagrade:</h2>
											<p><xsl:value-of select="$izbran_film/zzz:Award"/></p>
										</xsl:if>
										
										<xsl:if test="$izbran_film/zzz:Ratings">
											<h2>Ocene</h2>
											<ul>
												<xsl:for-each select="$izbran_film/zzz:Ratings/zzz:Rating">
													<li>
														<xsl:value-of select="./zzz:Source"/>
														<xsl:text disable-output-escaping="yes"><![CDATA[&nbsp;]]></xsl:text>
														-
														<xsl:text disable-output-escaping="yes"><![CDATA[&nbsp;]]></xsl:text>
														<xsl:value-of select="./zzz:Value"/>
													</li>
												</xsl:for-each>
											</ul>
										</xsl:if>
										
										<xsl:choose>
											<xsl:when test="$izbran_film/zzz:IMDBID and $izbran_film/zzz:URL">
												<p>
													<a target="_blank" role="button" class="btn btn-primary btn-sm">
														<xsl:attribute name="href">
															<xsl:text>https://www.imdb.com/title/</xsl:text>
															<xsl:value-of select="$izbran_film/zzz:IMDBID/@value"/>
														</xsl:attribute>
														<xsl:text>IMDB</xsl:text>
													</a>
													<xsl:text disable-output-escaping="yes"><![CDATA[&nbsp;]]></xsl:text>
													<xsl:text disable-output-escaping="yes"><![CDATA[&nbsp;]]></xsl:text>
													<a target="_blank" role="button" class="btn btn-primary btn-sm">
														<xsl:attribute name="href">
															<xsl:value-of select="$izbran_film/zzz:URL"/>
														</xsl:attribute>
														<xsl:text>Kolosej</xsl:text>
													</a>
												</p>
											</xsl:when>
											<xsl:when test="$izbran_film/zzz:IMDBID and not($izbran_film/zzz:URL)">
												<p>
													<a target="_blank" role="button" class="btn btn-primary btn-sm">
														<xsl:attribute name="href">
															<xsl:text>https://www.imdb.com/title/</xsl:text>
															<xsl:value-of select="$izbran_film/zzz:IMDBID/@value"/>
														</xsl:attribute>
														<xsl:text>IMDB</xsl:text>
													</a>
												</p>
											</xsl:when>
											<xsl:when test="not($izbran_film/zzz:IMDBID) and $izbran_film/zzz:URL">
												<p>	
													<a target="_blank" role="button" class="btn btn-primary btn-sm">
														<xsl:attribute name="href">
															<xsl:value-of select="$izbran_film/zzz:URL"/>
														</xsl:attribute>
														<xsl:text>Kolosej</xsl:text>
													</a>
												</p>
											</xsl:when>
											<xsl:otherwise>
											</xsl:otherwise>
										</xsl:choose>
										
									</div>
									<div class="col-md-3">
										<div class="panel-group probootstrap-panel" id="accordion" role="tablist" aria-multiselectable="true">
											<p>
												<xsl:choose>
													<xsl:when test="$izbran_film/zzz:Poster">
														<a>
															<xsl:attribute name="href"><xsl:value-of select="$izbran_film/zzz:Poster"/></xsl:attribute>
															<xsl:attribute name="target">_blank</xsl:attribute>
															<img width="324px" height="465px">
																<xsl:attribute name="src"><xsl:value-of select="$izbran_film/zzz:Poster"/></xsl:attribute>
																<xsl:attribute name="alt"><xsl:value-of select="$izbran_film/zzz:OriginalTitle"/></xsl:attribute>
																<xsl:attribute name="class">img-responsive img-border</xsl:attribute>
															</img>
														</a>
													</xsl:when>
													<xsl:otherwise>
														<a href="img/movie_poster.jpg" target="_blank">
															<img width="324px" height="465px" src="img/movie_poster.jpg" class="img-responsive img-border">
																<xsl:attribute name="alt"><xsl:value-of select="$izbran_film/zzz:OriginalTitle"/></xsl:attribute>
															</img>
														</a>
													</xsl:otherwise>
												</xsl:choose>
											</p>
											
											<xsl:if test="$izbran_film/zzz:Localization">
												<p><i><xsl:value-of select="$izbran_film/zzz:Localization"/></i></p>
											</xsl:if>
											
											<xsl:if test="$izbran_film/zzz:Rated">
												<span class="label label-warning"><xsl:value-of select="$izbran_film/zzz:Rated"/></span>
											</xsl:if>
											<br /><br />
											<p>Leto: <b><xsl:value-of select="$izbran_film/zzz:Year"/></b></p>
											<p>
												Dolžina: 
													<b>
														<xsl:value-of select="$izbran_film/zzz:Duration"/>
														<xsl:text disable-output-escaping="yes"><![CDATA[&nbsp;]]></xsl:text>
														<xsl:if test="$izbran_film/zzz:Duration/@enota">
															<xsl:value-of select="$izbran_film/zzz:Duration/@enota"/>
														</xsl:if>
													</b>
											</p>
											<xsl:if test="$izbran_film/zzz:Writer">
												<p>
													Scenarij: 
													<b>
														<xsl:for-each select="$izbran_film/zzz:Writer">
															<xsl:value-of select="./text()"/>,
														</xsl:for-each>
													</b>
												</p>
											</xsl:if>
											<xsl:if test="$izbran_film/zzz:Director">
												<p>
													Direktor: 
													<b>
														<xsl:for-each select="$izbran_film/zzz:Director">
															<xsl:value-of select="./text()"/>,
														</xsl:for-each>
													</b>
												</p>
											</xsl:if>
											<xsl:if test="$izbran_film/zzz:Producer">
												<p>
													Producent: 
													<b>
														<xsl:for-each select="$izbran_film/zzz:Producer">
															<xsl:value-of select="./text()"/>,
														</xsl:for-each>
													</b>
												</p>
											</xsl:if>
											<p>Igrajo: <b><xsl:value-of select="$izbran_film/zzz:Cast"/></b></p>
											<p>Jezik
												<xsl:if test="$izbran_film/zzz:Language/@jezik">
													(<xsl:value-of select="substring($izbran_film/zzz:Language/@jezik,0,4)"/>.): 
												</xsl:if> 
												<b><xsl:value-of select="$izbran_film/zzz:Language"/></b></p>
											<p>Država 
												<xsl:if test="$izbran_film/zzz:Country/@jezik">
													(<xsl:value-of select="substring($izbran_film/zzz:Country/@jezik,0,4)"/>.): 
												</xsl:if> 
												<b><xsl:value-of select="$izbran_film/zzz:Country"/></b></p>
											<xsl:if test="$izbran_film/zzz:Distributor">
												<p>Distribucija: <b><xsl:value-of select="$izbran_film/zzz:Distributor"/></b></p>
											</xsl:if>
											<form style="display:inline;" id="movie_pdf" action="/KIS_MovieInfo/FilmPDFServlet" method="post">
												<input type="hidden" name="movie_id_pdf">
												 	<xsl:attribute name="value"><xsl:value-of select="$movieID"/></xsl:attribute>
												</input>
												<a onclick="document.getElementById('movie_pdf').submit(); return false;">
													<img width="50px" height="50px" src="img/pdf.png" alt="download_as_pdf" />
												</a>
											</form>
										</div>
									</div>
								</div>
							</div>
						</section>
						
						<xsl:if test="document('ShowtimeList.xml')/zzz:ShowtimeList/zzz:Showtime[@movieID=$izbran_film/@movieID and current-date() &lt;= zzz:Date]">
							<section class="probootstrap-section">
								<div class="container">
									<div class="row">
										<div class="col-md-12 section-heading probootstrap-animate">
											<h2>Predstave filma</h2>
										</div>
									</div>
									<div class="row">
										<xsl:for-each select="document('ShowtimeList.xml')/zzz:ShowtimeList/zzz:Showtime[@movieID=$izbran_film/@movieID and current-date() &lt;= zzz:Date]">
											<div class="col-md-4">
												<div class="service left-icon probootstrap-animate">
													<div class="icon">
														<img  width="50px" src="img/ticket.png" />
													</div>
													<div class="text">
														<h3 class="heading"><xsl:value-of select="format-date(./zzz:Date, '[D01]. [M01]. [Y0001]')"/></h3>
														<span class="label label-info"><xsl:value-of select="./zzz:City"/></span>
														<xsl:if test="./zzz:Vstopnica">
															<xsl:text disable-output-escaping="yes"><![CDATA[&nbsp;]]></xsl:text>
															<xsl:text disable-output-escaping="yes"><![CDATA[&nbsp;]]></xsl:text>
															<span class="label label-success"><xsl:value-of select="./zzz:Vstopnica/@tipPredstave"/></span>
														</xsl:if>
														<p style="margin-top:10px">
														Čas: <b><xsl:value-of select="./zzz:Time"/></b><br />
														Objekt: <b><xsl:value-of select="./zzz:Center"/></b><br />
														Dvorana: <b><xsl:value-of select="./zzz:Theater"/></b>
														<xsl:if test="./zzz:Vstopnica">
															<br />Cena: <b>
																	<xsl:value-of select="./zzz:Vstopnica/text()"/>
																	<xsl:text disable-output-escaping="yes"><![CDATA[&nbsp;]]></xsl:text>
																	<xsl:value-of select="./zzz:Vstopnica/@valuta"/>
																</b>
														</xsl:if>
														</p>
													</div>
												</div>
											</div>
											<xsl:if test="position() mod 3 = 0">
												<br />
											</xsl:if>
										</xsl:for-each>
									</div>
								</div>
							</section>
						</xsl:if>
						
						<xsl:if test="$izbran_film/@kategorija">
							<xsl:if test="zzz:MovieList/zzz:Movie[@kategorija=$izbran_film/@kategorija and not(@movieID=$izbran_film/@movieID)]">
								<section class="probootstrap-section">
									<div class="container">
										<div class="row">
											<div class="col-md-12 section-heading probootstrap-animate">
												<h2>Filmi podobnih kategorij</h2>
											</div>
										</div>
										<div class="row">
											<xsl:for-each select="zzz:MovieList/zzz:Movie[@kategorija=$izbran_film/@kategorija and not(@movieID=$izbran_film/@movieID)]">
												<xsl:if test="position() &lt;= 3">
													<div class="col-md-4 col-sm-6 probootstrap-animate">
														<div class="probootstrap-card">
															<div class="probootstrap-card-media">
																<a>
																	<xsl:attribute name="onclick">
																		<xsl:text>document.getElementById('</xsl:text>
																		<xsl:text>posamezni_film_form_</xsl:text>
																		<xsl:value-of select="@movieID"/>
																		<xsl:text>').submit(); return false;</xsl:text>
																	</xsl:attribute>											
																	<xsl:choose>
																		<xsl:when test="zzz:Poster">
																			<img width="324px" height="465px" class="img-responsive img-border">
																			    <xsl:attribute name="src"><xsl:value-of select="./zzz:Poster"/></xsl:attribute>
																			    <xsl:attribute name="alt"><xsl:value-of select="./zzz:OriginalTitle"/></xsl:attribute>
																			</img>
																		</xsl:when>
																		<xsl:otherwise>
																			<img width="324px" height="465px" src="img/movie_poster.jpg" class="img-responsive img-border">
																			    <xsl:attribute name="alt"><xsl:value-of select="./zzz:OriginalTitle"/></xsl:attribute>
																			</img>
																		</xsl:otherwise>
																	</xsl:choose>
																</a>
															</div>
															<div class="probootstrap-card-text">
																<xsl:choose>
																	<xsl:when test="zzz:Title">
																		<h2 class="probootstrap-card-heading mb0"><xsl:value-of select="./zzz:Title" /></h2>
																		<p class="category"><xsl:value-of select="./zzz:OriginalTitle" />
																			<xsl:text disable-output-escaping="yes"><![CDATA[&nbsp;]]></xsl:text>
																			<xsl:text disable-output-escaping="yes"><![CDATA[&nbsp;]]></xsl:text>
																			<xsl:text disable-output-escaping="yes"><![CDATA[&nbsp;]]></xsl:text>
																			<xsl:text disable-output-escaping="yes"><![CDATA[&nbsp;]]></xsl:text>
																			<xsl:choose>
																				<xsl:when test="contains(./zzz:Genre, ',')">
																					<xsl:for-each select="tokenize(./zzz:Genre,', ')">
																						<span class="badge badge-secondary"><xsl:sequence select="."/></span>
																						<xsl:text disable-output-escaping="yes"><![CDATA[&nbsp;]]></xsl:text>
																						<xsl:text disable-output-escaping="yes"><![CDATA[&nbsp;]]></xsl:text>
																					</xsl:for-each>
																				</xsl:when>
																				<xsl:otherwise>
																					<span class="badge badge-secondary"><xsl:value-of select="./zzz:Genre" /></span>
																				</xsl:otherwise>
																			</xsl:choose>
																		</p>
																	</xsl:when>
																	<xsl:otherwise>
																		<h2 class="probootstrap-card-heading mb0"><xsl:value-of select="./zzz:OriginalTitle" /></h2>
																		<p class="category"><xsl:value-of select="./zzz:OriginalTitle" />
																			<xsl:text disable-output-escaping="yes"><![CDATA[&nbsp;]]></xsl:text>
																			<xsl:text disable-output-escaping="yes"><![CDATA[&nbsp;]]></xsl:text>
																			<xsl:text disable-output-escaping="yes"><![CDATA[&nbsp;]]></xsl:text>
																			<xsl:text disable-output-escaping="yes"><![CDATA[&nbsp;]]></xsl:text>
																			<xsl:choose>
																				<xsl:when test="contains(./zzz:Genre, ',')">
																					<xsl:for-each select="tokenize(./zzz:Genre,', ')">
																						<span class="badge badge-secondary"><xsl:sequence select="."/></span>
																						<xsl:text disable-output-escaping="yes"><![CDATA[&nbsp;]]></xsl:text>
																						<xsl:text disable-output-escaping="yes"><![CDATA[&nbsp;]]></xsl:text>
																					</xsl:for-each>
																				</xsl:when>
																				<xsl:otherwise>
																					<span class="badge badge-secondary"><xsl:value-of select="./zzz:Genre" /></span>
																				</xsl:otherwise>
																			</xsl:choose>
																		</p>
																	</xsl:otherwise>
																</xsl:choose>
																<xsl:if test="./zzz:NaVoljo=0">
																	<span class="label label-danger">Ni na voljo</span>
																</xsl:if>
																<xsl:if test="./zzz:NaVoljo=1">
																	<span class="label label-success">Na voljo</span>
																</xsl:if>
																<br /><br />
																<p><xsl:value-of select="substring(./zzz:PlotOutline,0,70)" />...</p>
																<p>
																	<form style="display:inline; margin:0px; padding:0px;" action="/KIS_MovieInfo/FilmServlet" method="get">
																		 <xsl:attribute name="id">
																		 	<xsl:text>posamezni_film_form_</xsl:text>
																		 	<xsl:value-of select="@movieID"/>
																		 </xsl:attribute>
																		 <input type="hidden" name="movieID">
																		 	<xsl:attribute name="value"><xsl:value-of select="@movieID"/></xsl:attribute>
																		 </input>
																		<a>
																			<xsl:attribute name="onclick">
																				<xsl:text>document.getElementById('</xsl:text>
																				<xsl:text>posamezni_film_form_</xsl:text>
																				<xsl:value-of select="@movieID"/>
																				<xsl:text>').submit(); return false;</xsl:text>
																			</xsl:attribute>
																			<xsl:text>Ogled podrobnosti</xsl:text>
																		</a>
																	</form>
																</p>
															</div>
														</div>
													</div>
												</xsl:if>
											</xsl:for-each>
										</div>
									</div>
								</section>
							</xsl:if>
						</xsl:if>
					</xsl:when>
					<xsl:otherwise>
						<section class="probootstrap-section">
							<div class="container">
								<div class="row">
									<div class="col-md-12 section-heading probootstrap-animate">
										<br /><br /><br /><br />
										<h3>Film ne obstaja.</h3>
									</div>
								</div>
							</div>
						</section>
					</xsl:otherwise>
				</xsl:choose>
				
				<footer class="probootstrap-footer probootstrap-bg">
					<div class="container">
						<div class="row copyright">
							<div class="col-md-6">
								<div class="probootstrap-footer-widget">
									<p>
										<xsl:text disable-output-escaping="yes"><![CDATA[&copy;]]></xsl:text> 2018 <a href="index.html">MovieInfo</a>.
									</p>
								</div>
							</div>
							<div class="col-md-6">
								<div class="probootstrap-footer-widget right">
									<ul class="probootstrap-social">
										<li><a href="https://twitter.com/denisbobovnik"><i class="icon-twitter"></i></a></li>
										<li><a href="https://www.facebook.com/bobovnikdenis"><i class="icon-facebook2"></i></a></li>
										<li><a href="https://www.instagram.com/denis.bobovnik/"><i class="icon-instagram2"></i></a></li>
									</ul>
								</div>
							</div>
						</div>
					</div>
				</footer>

				<div class="gototop js-top">
					<a href="#" class="js-gotop"><i class="icon-chevron-thin-up"></i></a>
				</div>
			
				<script src="js/scripts.min.js"></script>
				<script src="js/main.min.js"></script>
				<script src="js/custom.js"></script>

			</body>
		</html>
	</xsl:template>
</xsl:stylesheet>