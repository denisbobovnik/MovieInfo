<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="si.um.feri.kis.stax.*"%>
<%@page import="java.util.*"%>
<%@page import="java.text.*"%>
<!DOCTYPE html>

<html lang="en">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>MovieInfo | Prihajajoče predstave (StAX)</title>
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
					<li><a href="seznamFilmovSAX.jsp">Filmi (SAX)</a></li>
					<li>
						<form style="display:inline; margin:0px; padding:0px;" id="predstave_form" action="/KIS_MovieInfo/PredstaveServlet" method="get">
							<a onclick="document.getElementById('predstave_form').submit(); return false;">Predstave</a>
						</form>
					</li>
					<li class="active"><a href="seznamPredstavStAX.jsp">Predstave (StAX)</a></li>
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
					<h2>Prihajajoče predstave (StAX)</h2>
				</div>
			</div>
			<div class="row">
				<div class="col-md-12 section-heading probootstrap-animate">
					<% SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss"); %>
					<% RazpoznavalnikStAX prebraniPodatki = new RazpoznavalnikStAX("http://localhost:8080/KIS_MovieInfo/XML/ShowtimeList.xml"); %>
					<% List<Showtime> predstaveKiPridejoVPostev = new ArrayList<Showtime>(); %>
					<% 
						for(Showtime showtime: prebraniPodatki.getShowtimeList()) {
							if(showtime.getDate().before(new Date()))
								continue;
							predstaveKiPridejoVPostev.add(showtime);
						}
					%>
					<% if(predstaveKiPridejoVPostev.size()>0) { %>
						<table class="table table-bordered">
							<tr>
								<th style="color: white">ID</th>
								<th style="color: white">ID_FILM</th>
								<th style="color: white">CENTER</th>
								<th style="color: white">DVORANA</th>
								<th style="color: white">DATUM/ČAS</th>
								<th style="color: white">TIP</th>
								<th style="color: white">CENA</th>
							</tr>
							<% for(Showtime showtime : predstaveKiPridejoVPostev) { %>
								<tr>
									<td style="color: white"><%=showtime.getShowtimeID() %></td>
									<td style="color: white"><%=showtime.getMovieID() %></td>
									<td style="color: white"><%=showtime.getCenter() %></td>
									<td style="color: white"><%=showtime.getTheater() %></td>
									<td style="color: white"><%=sdf.format(showtime.getDate()) %></td>
									<% if(showtime.getVstopnica() == null) { %>
										<td style="color: white">nedefiniran</td>
										<td style="color: white">nedoločena</td>
									<% } else { %>
										<td style="color: white"><%=showtime.getVstopnica().getTipPredstave() %></td>
										<td style="color: white"><%=showtime.getVstopnica().getCena() + " " + showtime.getVstopnica().getValuta() %></td>
									<% } %>
								</tr>
							<% } %>
						</table>
					<% } else { %>
						<h3>Na žalost ni nobenih predstav.</h3>
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
							&copy; 2019 <a href="index.html">MovieInfo</a>.
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