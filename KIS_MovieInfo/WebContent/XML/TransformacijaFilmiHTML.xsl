<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" 
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:zzz="www.movieinfo.com"
	exclude-result-prefixes="zzz">
	
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
								<li><a href="seznamPredstavStAX.jsp">Predstave (StAX)</a></li>
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
				
				<section class="probootstrap-section">
					<div class="container">
						<div class="row">
							<div class="col-md-12 section-heading probootstrap-animate">
								<h2>Seznam filmov</h2>
							</div>
						</div>
						<div class="row">
							<xsl:variable name="stevillo_izvedb" select="count(zzz:MovieList/zzz:Movie)" />
							<xsl:for-each select="zzz:MovieList/zzz:Movie">
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
								<xsl:if test="position() mod 3 = 0">
									<br />
								</xsl:if>
							</xsl:for-each>
							<xsl:if test="$stevillo_izvedb=0">
								<div class="col-md-12 section-heading probootstrap-animate">
									<h3>Na žalost ni nobenih filmov.</h3>
								</div>
							</xsl:if>
						</div>
					</div>
				</section>
				
				<footer class="probootstrap-footer probootstrap-bg">
					<div class="container">
						<div class="row copyright">
							<div class="col-md-6">
								<div class="probootstrap-footer-widget">
									<p>
										<xsl:text disable-output-escaping="yes"><![CDATA[&copy;]]></xsl:text> 2019 <a href="index.html">MovieInfo</a>.
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