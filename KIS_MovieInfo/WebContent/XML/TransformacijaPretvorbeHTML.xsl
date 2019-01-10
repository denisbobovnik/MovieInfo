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
				<title>MovieInfo | Pretvorbe</title>
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
								<li class="active">
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
				
				<div class="probootstrap-section">
					<div class="container">
						<div class="row">
							<div class="col-md-12 section-heading probootstrap-animate">
								<h2>Pretvorbe</h2>
							</div>
						</div>
						<div class="row">
							<div class="col-md-8 probootstrap-animate" data-animate-effect="fadeInLeft">
			
								<div class="panel-group probootstrap-panel" id="accordion" role="tablist" aria-multiselectable="true">
									<div class="panel panel-default">
										<div class="panel-heading" role="tab" id="headingOne">
											<h3 class="panel-title">
												<a role="button" data-toggle="collapse"
													data-parent="#accordion" href="#collapseOne"
													aria-expanded="true" aria-controls="collapseOne"> Pretvorba DOCX v XML </a>
											</h3>
										</div>
										<div id="collapseOne" class="panel-collapse collapse in"
											role="tabpanel" aria-labelledby="headingOne">
											<div class="panel-body">
												<p>Naložite spored v obliki Word datoteke in pretvorili jo bomo v okrnjen XML zapis.</p>
												<form style="display:inline; margin-left:10px;" id="docx2xml" action="/KIS_MovieInfo/DOCX2XML" method="post" enctype="multipart/form-data">
													<input type="file" name="file" required=""/>
													<br />
													<a role="button" class="btn btn-primary">
														<xsl:attribute name="onclick">document.getElementById('docx2xml').submit(); return false;</xsl:attribute>
														Pretvori
													</a>
												</form>
											</div>
										</div>
									</div>
									<div class="panel panel-default">
										<div class="panel-heading" role="tab" id="headingTwo">
											<h3 class="panel-title">
												<a class="collapsed" role="button" data-toggle="collapse"
													data-parent="#accordion" href="#collapseTwo"
													aria-expanded="false" aria-controls="collapseTwo">
													Pretvorba DOCX v PDF</a>
											</h3>
										</div>
										<div id="collapseTwo" class="panel-collapse collapse"
											role="tabpanel" aria-labelledby="headingTwo">
											<div class="panel-body">
												<p>Naložite vašo spremenjeno Word datoteko (iz zgornjega orodja) in pretvorili jo bomo v PDF obliko.</p>
												<form style="display:inline; margin-left:10px;" id="docx2pdf" action="/KIS_MovieInfo/DOCX2PDF" method="post" enctype="multipart/form-data">
													<input type="file" name="file" required=""/>
													<br />
													<a role="button" class="btn btn-primary">
														<xsl:attribute name="onclick">document.getElementById('docx2pdf').submit(); return false;</xsl:attribute>
														Pretvori
													</a>
												</form>
											</div>
										</div>
									</div>
								</div>
								<!-- END panel-group -->
							</div>
							<div class="col-md-4 probootstrap-animate" data-animate-effect="fadeInRight">
								<figure>
									<div class="probootstrap-video">
										<img src="https://www.expert-pdf.com/wp-content/uploads/2016/06/xConvertir5_250.png.pagespeed.ic.KqYt1k6X2X.png" alt="Free HTML5 Bootstrap Template by uicookies.com" class="img-responsive img-border" />
									</div>
									<figcaption>Slika pretvorbe.</figcaption>
								</figure>
							</div>
						</div>
					</div>
				</div>
				<!-- END section -->

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