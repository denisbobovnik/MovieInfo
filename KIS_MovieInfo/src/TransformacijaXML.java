import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.xml.XMLConstants;
import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.ParserConfigurationException;
import javax.xml.transform.OutputKeys;
import javax.xml.transform.Transformer;
import javax.xml.transform.TransformerConfigurationException;
import javax.xml.transform.TransformerException;
import javax.xml.transform.TransformerFactory;
import javax.xml.transform.dom.DOMSource;
import javax.xml.transform.stream.StreamResult;
import javax.xml.transform.stream.StreamSource;
import javax.xml.validation.Schema;
import javax.xml.validation.SchemaFactory;
import javax.xml.validation.Validator;
import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;
import org.xml.sax.SAXException;

@WebServlet(urlPatterns="/TransformacijaXML")
public class TransformacijaXML extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
    public TransformacijaXML() {
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("application/xml");
		response.setCharacterEncoding("UTF-8");
		PrintWriter out = response.getWriter();
		DocumentBuilderFactory dbFactory = DocumentBuilderFactory.newInstance();
		dbFactory.setNamespaceAware(true);
		DocumentBuilder dBuilder;
		try {
			dBuilder = dbFactory.newDocumentBuilder();
			Document doc = dBuilder.parse("http://localhost:8080/KIS_MovieInfo/XML/MovieList.xml");
			Element movieListDokument = doc.getDocumentElement();
			
			NodeList movieList = movieListDokument.getElementsByTagName("Movie");
			List<Element> movieListFiltrirano = new ArrayList<Element>();
			
			for(int i=0; i<movieList.getLength(); i++) {
				Element movie = (Element) movieList.item(i);
				if(!(movie.getAttribute("kategorija").equals("novi")||movie.getAttribute("kategorija").equals("popularni")))
					continue;
				
				if(movie.getAttribute("kategorija").equals("novi")) {
					if(!(jeVtemCentruPredToUro(movie, "Kolosej Ljubljana", 19) && (imaOcenoIMDBVecjoAliEnako(movie, 7.2))))
						continue;
				} else if (movie.getAttribute("kategorija").equals("popularni")) {
					if(!(jeNastalVZadnjihXLetih(movie, 5) && jeTehnologijeX(movie, "3D")))
						continue;
				}
				
				if(!movieListFiltrirano.contains(movie))
					movieListFiltrirano.add(movie);
			}
			
			SchemaFactory xsdFactory = SchemaFactory.newInstance(XMLConstants.W3C_XML_SCHEMA_NS_URI);
			Schema shema = xsdFactory.newSchema(new StreamSource("http://localhost:8080/KIS_MovieInfo/XML/Besednjak.xsd"));
			
			DocumentBuilderFactory tovarna = DocumentBuilderFactory.newInstance();
			tovarna.setNamespaceAware(true);
			tovarna.setValidating(true);
			tovarna.setSchema(shema);
			
			DocumentBuilder builder = tovarna.newDocumentBuilder();
			Document document = builder.newDocument();
			
			Node firstDocRoot = document.importNode(movieListDokument, false);
			document.appendChild(firstDocRoot);
			
			for(Element movie : movieListFiltrirano) {				
				List<Element> showtimeList = vrniVsePredstaveFilma(movie);
				if(showtimeList.size()>0) {
					Element showtimes = doc.createElementNS("www.movieinfo.com", "Showtimes");
					movie.appendChild(showtimes);
					
					for(Element showtime : showtimeList) {
						Node firstDocImportedShowtime = doc.importNode(showtime, true);
						showtimes.appendChild(firstDocImportedShowtime);
					}
				}
			}
			
			for(Element movie : movieListFiltrirano) {
				Node firstDocImportedNode = document.importNode(movie, true);
				firstDocRoot.appendChild(firstDocImportedNode);
			}
		
			Validator validator = shema.newValidator();
			validator.validate(new DOMSource(document));
		
			StreamResult xmlRET = new StreamResult(out); 
			printDocument(document, xmlRET);
		} catch (ParserConfigurationException e) {
			e.printStackTrace();
		} catch (SAXException e) {
			e.printStackTrace();
		}
	}
	
	private boolean jeVtemCentruPredToUro(Element movie, String centerString, int timeInt) {
		DocumentBuilderFactory dbFactory = DocumentBuilderFactory.newInstance();
		dbFactory.setNamespaceAware(true);
		DocumentBuilder dBuilder;
		try {
			dBuilder = dbFactory.newDocumentBuilder();
			Document doc = dBuilder.parse("http://localhost:8080/KIS_MovieInfo/XML/ShowtimeList.xml");
			Element showtimeListDokument = doc.getDocumentElement();
			
			NodeList showtimeList = showtimeListDokument.getElementsByTagName("Showtime");
			List<Element> showtimeListFiltrirano = new ArrayList<Element>();
			
			for(int i=0; i<showtimeList.getLength(); i++) {
				Element showtime = (Element) showtimeList.item(i);
				if(!showtime.getAttribute("movieID").equals(movie.getAttribute("movieID")))
					continue;
				
				Element center = (Element) showtime.getElementsByTagName("Center").item(0);
				if(!center.getTextContent().equals(centerString))
					continue;
				
				Element time = (Element) showtime.getElementsByTagName("Time").item(0);
				if(Integer.parseInt(time.getTextContent().substring(0, time.getTextContent().substring(0, time.getTextContent().lastIndexOf(":")).lastIndexOf(":")))>=timeInt)
					continue;
				
				if(!showtimeListFiltrirano.contains(showtime))
					showtimeListFiltrirano.add(showtime);
			}
			
			if(showtimeListFiltrirano.size()>0)
				return true;
			
		} catch (ParserConfigurationException e) {
			e.printStackTrace();
		} catch (SAXException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		return false;
	}
	private boolean imaOcenoIMDBVecjoAliEnako(Element movie, double ocena) {
		if(movie.getElementsByTagName("Ratings").item(0) != null) {
			Element ratings = (Element) movie.getElementsByTagName("Ratings").item(0);
			
			boolean imaIMDBOcenoSploh = false;
			NodeList ratingList = ratings.getElementsByTagName("Rating");
			for(int i=0; i<ratingList.getLength(); i++) {
				Element rating = (Element) ratingList.item(i);
				Element source = (Element) rating.getElementsByTagName("Source").item(0);
				if(source.getTextContent().equals("IMDB"))
					imaIMDBOcenoSploh = true;
			}
			
			if(imaIMDBOcenoSploh) {
				for(int i=0; i<ratingList.getLength(); i++) {
					Element rating = (Element) ratingList.item(i);
					Element source = (Element) rating.getElementsByTagName("Source").item(0);
					Element value = (Element) rating.getElementsByTagName("Value").item(0);
					if(source.getTextContent().equals("IMDB")) {
						if(Double.parseDouble(value.getTextContent().substring(0, value.getTextContent().lastIndexOf("/")))>=ocena)
							return true;
					}
				}
			}
		}
		return false;
	}
	private boolean jeNastalVZadnjihXLetih(Element movie, int leta) {
		Element year = (Element) movie.getElementsByTagName("Year").item(0);
		if(Calendar.getInstance().get(Calendar.YEAR)-Integer.parseInt(year.getTextContent())<=5)
			return true;
		return false;
	}
	private boolean jeTehnologijeX(Element movie, String tehnologija) {
		DocumentBuilderFactory dbFactory = DocumentBuilderFactory.newInstance();
		dbFactory.setNamespaceAware(true);
		DocumentBuilder dBuilder;
		try {
			dBuilder = dbFactory.newDocumentBuilder();
			Document doc = dBuilder.parse("http://localhost:8080/KIS_MovieInfo/XML/ShowtimeList.xml");
			Element showtimeListDokument = doc.getDocumentElement();
			
			NodeList showtimeList = showtimeListDokument.getElementsByTagName("Showtime");
			List<Element> showtimeListFiltrirano = new ArrayList<Element>();
			
			for(int i=0; i<showtimeList.getLength(); i++) {
				Element showtime = (Element) showtimeList.item(i);
				if(!showtime.getAttribute("movieID").equals(movie.getAttribute("movieID")))
					continue;
				
				if(showtime.getElementsByTagName("Vstopnica").item(0) == null)
					continue;
				
				Element vstopnica = (Element) showtime.getElementsByTagName("Vstopnica").item(0);
				if(!vstopnica.getAttribute("tipPredstave").equals(tehnologija))
					continue;
				
				if(!showtimeListFiltrirano.contains(showtime))
					showtimeListFiltrirano.add(showtime);
			}
			
			if(showtimeListFiltrirano.size()>0)
				return true;
			
		} catch (ParserConfigurationException e) {
			e.printStackTrace();
		} catch (SAXException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		return false;
	}
	private List<Element> vrniVsePredstaveFilma(Element movie) {
		DocumentBuilderFactory dbFactory = DocumentBuilderFactory.newInstance();
		dbFactory.setNamespaceAware(true);
		DocumentBuilder dBuilder;
		List<Element> ret = new ArrayList<Element>();
		try {
			dBuilder = dbFactory.newDocumentBuilder();
			Document doc = dBuilder.parse("http://localhost:8080/KIS_MovieInfo/XML/ShowtimeList.xml");
			Element showtimeListDokument = doc.getDocumentElement();
			
			NodeList showtimeList = showtimeListDokument.getElementsByTagName("Showtime");
			for(int i=0; i<showtimeList.getLength(); i++) {
				Element showtime = (Element) showtimeList.item(i);
				if(!showtime.getAttribute("movieID").equals(movie.getAttribute("movieID")))
					continue;
				
				if(!ret.contains(showtime))
					ret.add(showtime);
			}
		} catch (ParserConfigurationException e) {
			e.printStackTrace();
		} catch (SAXException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		return ret;
	}
	public static void printDocument(Document doc, StreamResult out) {
	    try {
			TransformerFactory tf = TransformerFactory.newInstance();
		    Transformer transformer = tf.newTransformer();
		    transformer.setOutputProperty(OutputKeys.OMIT_XML_DECLARATION, "no");
		    transformer.setOutputProperty(OutputKeys.METHOD, "xml");
		    transformer.setOutputProperty(OutputKeys.INDENT, "yes");
		    transformer.setOutputProperty(OutputKeys.ENCODING, "UTF-8");
		    transformer.transform(new DOMSource(doc), out);
		} catch (TransformerConfigurationException e) {
			e.printStackTrace();
		} catch (TransformerException e) {
			e.printStackTrace();
		}
	}
}