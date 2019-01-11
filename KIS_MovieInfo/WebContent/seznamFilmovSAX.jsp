<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="si.um.feri.kis.sax.*"%>
<%@page import="java.util.*"%>
<!DOCTYPE html>

<html lang="en">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>MovieInfo | Seznam filmov SAX</title>
<meta name="description" content="Free Bootstrap Theme by uicookies.com">
<meta name="keywords" content="free website templates, free bootstrap themes, free template, free bootstrap, free website template">
<link href="https://fonts.googleapis.com/css?family=Open+Sans:300,400" rel="stylesheet">
<link rel="stylesheet" href="css/styles-merged.css">
<link rel="stylesheet" href="css/style.min.css">
<link rel="stylesheet" href="css/custom.css">
</head>
<body>

	<!-- START: header -->

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
					<li class="active"><a href="seznamFilmovSAX.jsp">Filmi (SAX)</a></li>
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
	<!-- END: header -->
	
	<section class="probootstrap-section">
		<div class="container">
			<div class="row">
				<div class="col-md-12 section-heading probootstrap-animate">
					<h2>Seznam filmov SAX</h2>
				</div>
			</div>
			<div class="row">
				<div class="col-md-12 section-heading probootstrap-animate">
					<% RazpoznavalnikSAX prebraniPodatki = new RazpoznavalnikSAX(); %>
					<% if(prebraniPodatki.getMovieList().size()>0) { %>
						<table class="table table-bordered">
							<tr>
								<th style="color: white">ID</th>
								<th style="color: white">KATEGORIJA</th>
								<th style="color: white">NASLOV</th>
								<th style="color: white">LETO</th>
								<th style="color: white">ŽANR</th>
								<th style="color: white">JEZIK</th>
								<th style="color: white">IMDB</th>
								<th style="color: white">OCENA</th>
							</tr>
							<% for(Movie movie : prebraniPodatki.getMovieList()) { %>
								<tr>
									<td style="color: white"><%=movie.getMovieID() %></td>
									<% if(movie.getKategorija() == null) { %>
										<td style="color: white">nekategoriziran</td>
									<% } else { %>
										<td style="color: white"><%=movie.getKategorija() %></td>
									<% } %>
									<td style="color: white"><%=movie.getOriginalTitle() %></td>
									<td style="color: white"><%=movie.getYear() %></td>
									<td style="color: white"><%=movie.getGenre() %></td>
									<td style="color: white"><%=movie.getLanguage() %></td>
									<% if(movie.getImdb() == null) { %>
										<td style="color: white">neuvrščen</td>
									<% } else { %>
										<td>
											<a target="_blank" role="button" class="btn btn-primary btn-sm" href="https://www.imdb.com/title/<%=movie.getImdb()%>">Link</a>
										</td>
									<% } %>
									<% 
										List<Rating> seznamOcen = movie.getRatings();
										boolean vsebuje = false; 
										String ocena = "";
										if(seznamOcen != null) {
											for(Rating rating : seznamOcen) {
												if(rating.getSource().equals("MovieInfo")) {
													vsebuje = true;
													ocena = rating.getValue();
												}
											}
										}
										if(vsebuje) { %>
											<td style="color: white"><%=ocena %></td>
										<% } else { %>
											<td style="color: white">neocenjen</td>
										<% } %>
								</tr>
							<% } %>
						</table>
					<% } else { %>
						<h3>Na žalost ni nobenih filmov.</h3>
					<% } %>
				</div>
			</div>
		</div>
	</section>
	
	<footer class="probootstrap-footer probootstrap-bg">
		<div class="container">
			<div class="row copyright">
				<div class="col-md-6">
					<div class="probootstrap-footer-widget">
						<p>
							&copy; 2018 <a href="index.html">MovieInfo</a>.
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