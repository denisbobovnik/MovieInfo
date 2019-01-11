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
				<title>MovieInfo | Predstave</title>
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
								<li>
									<form style="display:inline; margin:0px; padding:0px;" id="filmi_form" action="/KIS_MovieInfo/FilmiServlet" method="get">
										<a onclick="document.getElementById('filmi_form').submit(); return false;">Filmi</a>
									</form>
								</li>
								<li><a href="seznamFilmovSAX.jsp">Filmi (SAX)</a></li>
								<li class="active">
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
								<h2>Prihajajoče predstave</h2>
							</div>
						</div>
						<xsl:variable name="stevillo_izvedb" select="count(document('ShowtimeList.xml')/zzz:ShowtimeList/zzz:Showtime[current-date() &lt;= zzz:Date]/zzz:Center[not(preceding::zzz:Center/. = .)])" />
						<xsl:for-each select="document('ShowtimeList.xml')/zzz:ShowtimeList/zzz:Showtime[current-date() &lt;= zzz:Date]/zzz:Center[not(preceding::zzz:Center/. = .)]">
							<xsl:variable name="trenutni_center" select="." />
							<div class="row">
								<div class="col-md-12 section-heading probootstrap-animate">
									<h3 style="display:inline-block;"><xsl:value-of select="$trenutni_center" /></h3>
									<form style="display:inline; margin-left:20px;" action="/KIS_MovieInfo/PredstavePDFServlet" method="post">
										<xsl:attribute name="id">pdf_center_<xsl:value-of select="substring-after(.,'Kolosej ')" /></xsl:attribute>
										<input type="hidden" name="center">
										 	<xsl:attribute name="value"><xsl:value-of select="."/></xsl:attribute>
										</input>
										<a>
											<xsl:attribute name="onclick">document.getElementById('pdf_center_<xsl:value-of select="substring-after(.,'Kolosej ')" />').submit(); return false;</xsl:attribute>
											<img width="50px" height="50px" src="img/pdf.png" alt="download_as_pdf" />
										</a>
									</form>
									<form style="display:inline; margin-left:10px;" action="/KIS_MovieInfo/PredstaveDOCXServlet" method="post">
										<xsl:attribute name="id">docx_center_<xsl:value-of select="substring-after(.,'Kolosej ')" /></xsl:attribute>
										<input type="hidden" name="center">
										 	<xsl:attribute name="value"><xsl:value-of select="."/></xsl:attribute>
										</input>
										<a>
											<xsl:attribute name="onclick">document.getElementById('docx_center_<xsl:value-of select="substring-after(.,'Kolosej ')" />').submit(); return false;</xsl:attribute>
											<img width="50px" height="50px" src="img/docx.png" alt="download_as_docx" />
										</a>
									</form>
								</div>
							</div>
							<div class="row">
								<xsl:variable name="item" select="document('ShowtimeList.xml')/zzz:ShowtimeList/zzz:Showtime[current-date() &lt;= zzz:Date and zzz:Center=$trenutni_center]" />
								<xsl:for-each select="$item">
									<xsl:variable name="movieID" select="./@movieID"/>
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
												<p style="margin-top:10px; margin-bottom: 0;">
												Čas: <b><xsl:value-of select="./zzz:Time"/></b><br />
												<form style="display:inline; margin:0px; padding:0px;" action="/KIS_MovieInfo/FilmServlet" method="get">
															 <xsl:attribute name="id">
															 	<xsl:text>posamezni_film_form_</xsl:text>
															 	<xsl:value-of select="$movieID"/>
															 </xsl:attribute>
															 <input type="hidden" name="movieID">
															 	<xsl:attribute name="value"><xsl:value-of select="$movieID"/></xsl:attribute>
															 </input>
												Film: <a>
																<xsl:attribute name="onclick">
																	<xsl:text>document.getElementById('</xsl:text>
																	<xsl:text>posamezni_film_form_</xsl:text>
																	<xsl:value-of select="$movieID"/>
																	<xsl:text>').submit(); return false;</xsl:text>
																</xsl:attribute>
																<xsl:choose>
																	<xsl:when test="document('MovieList.xml')/zzz:MovieList/zzz:Movie[@movieID=$movieID]/zzz:Title">
																		<b><xsl:value-of select="document('MovieList.xml')/zzz:MovieList/zzz:Movie[@movieID=$movieID]/zzz:Title"/></b>
																	</xsl:when>
																	<xsl:otherwise>
																		<b><xsl:value-of select="document('MovieList.xml')/zzz:MovieList/zzz:Movie[@movieID=$movieID]/zzz:OriginalTitle"/></b>
																	</xsl:otherwise>
																</xsl:choose>
															</a>
														</form>
														<br />
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
						</xsl:for-each>
						<xsl:if test="$stevillo_izvedb=0">
							<div class="row">
								<div class="col-md-12 section-heading probootstrap-animate">
									<h3>Na žalost ni nobenih predstav.</h3>
								</div>
							</div>
						</xsl:if>
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