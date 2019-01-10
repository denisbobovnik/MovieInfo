import java.io.File;
import java.io.IOException;
import java.net.MalformedURLException;
import java.net.URL;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.ParserConfigurationException;
import javax.xml.xpath.XPath;
import javax.xml.xpath.XPathConstants;
import javax.xml.xpath.XPathExpression;
import javax.xml.xpath.XPathExpressionException;
import javax.xml.xpath.XPathFactory;

import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;
import org.w3c.dom.Text;
import org.xml.sax.SAXException;

@WebServlet(urlPatterns="/PosodobitevBaze")
public class PosodobitevBaze extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public PosodobitevBaze() {
    }
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		DocumentBuilderFactory dbf = DocumentBuilderFactory.newInstance();
		try {
			DocumentBuilder db = dbf.newDocumentBuilder();
			Document doc = db.parse(new URL("http://www.kolosej.si/spored/xml/2.0/").openStream());
			NodeList listOfMovies = doc.getElementsByTagName("movie");

			/* pridobi vse filme in jih shrani v arraylist */
			ArrayList<String> idjiFilmov = vrniVseIDjeKolosejevihFilmov();
			
			Node firstMovieNode, firstShowNode;
			Element firstMovieElement, posterElement, firstShowElement;
			String kolosejevID, poster, kolosejevIDshowa;
			/*ResultSet trenutniFilm, obstojecePredstave;*/
			String[] tagi = { "title", "original_title", "genre", "url", "director", "writer", "distributor", "localization", "plot_outline" };
			String[] vrednosti = new String[tagi.length];
			String[] tagiSPreverjanjem = { "punchline", "producer", "cast", "language", "country" };
			String[] vrednostiTagovSPreverjanjem = new String[tagiSPreverjanjem.length];
			String[] stevilcniTagi = { "year", "duration" };
			int[] vrednostiStevilcnihTagov = new int[stevilcniTagi.length];
			NodeList posterList, textPOSTList, listOfShows;
			/*PreparedStatement ls = con.prepareStatement("SELECT movies_id, movie_id FROM movies WHERE movie_id = ?");*/
			int idFilma = 0;
			String[] tagiShowa = { "date", "time", "city", "center", "theater" };
			String[] vrednostiShowa = new String[tagiShowa.length];
			SimpleDateFormat formatCasa = new SimpleDateFormat("HH:mm:ss");
			Calendar koledar = Calendar.getInstance();
			Timestamp timestamp;
			SimpleDateFormat formatDatuma = new SimpleDateFormat("yyyy-MM-dd");
			java.util.Date dateParse;
			/*PreparedStatement psi = con.prepareStatement("UPDATE movies SET na_voljo = ? WHERE movie_id = ?");*/
		
			for (int i = 0; i < listOfMovies.getLength(); i++) {
				firstMovieNode = listOfMovies.item(i);
				if (firstMovieNode.getNodeType() == Node.ELEMENT_NODE) {
					firstMovieElement = (Element) firstMovieNode;
					kolosejevID = firstMovieNode.getAttributes().getNamedItem("id").getNodeValue();
					
					/*
					 * če je nek prebran film že v seznamu, ga odstrani iz
					 * seznama (torej je še na voljo)
					 */
					if (idjiFilmov.contains(kolosejevID))
						idjiFilmov.remove(kolosejevID);

					for (int stevecTagov = 0; stevecTagov < tagi.length; stevecTagov++)
						vrednosti[stevecTagov] = preberiIzXML(firstMovieElement, tagi[stevecTagov]);

					for (int stevecTagov = 0; stevecTagov < tagiSPreverjanjem.length; stevecTagov++)
						vrednostiTagovSPreverjanjem[stevecTagov] = preberiIzXMLterPreveri(firstMovieElement, tagiSPreverjanjem[stevecTagov]);

					for (int stevecTagov = 0; stevecTagov < stevilcniTagi.length; stevecTagov++)
						vrednostiStevilcnihTagov[stevecTagov] = preberiStevilcneVrednostiIzXML(firstMovieElement, stevilcniTagi[stevecTagov]);
					
					posterList = firstMovieElement.getElementsByTagName("poster");
					if (posterList.getLength() != 0) {
						posterElement = (Element) posterList.item(0);
						textPOSTList = posterElement.getChildNodes();
						poster = ((Node) textPOSTList.item(0)).getNodeValue().trim();
					} else
						poster = "";

					/* vnos v bazo */
					/*
					 * vsi filmi, ki se na na novo vnesejo, so po privzetem na
					 * voljo
					 */
					shraniMovie(0, kolosejevID, vrednosti[0], vrednosti[1], vrednostiTagovSPreverjanjem[0], " ", vrednosti[2], vrednostiStevilcnihTagov[0], vrednostiStevilcnihTagov[1], 
							vrednosti[3], poster, vrednosti[4], vrednostiTagovSPreverjanjem[1], vrednosti[5], vrednostiTagovSPreverjanjem[2], vrednosti[6],
							vrednostiTagovSPreverjanjem[3], vrednostiTagovSPreverjanjem[4], vrednosti[7], vrednosti[8], 0, 0, true);
					
					//ls.setString(1, kolosejevID);
					//trenutniFilm = ls.executeQuery();
					/*while (trenutniFilm.next())
						idFilma = trenutniFilm.getInt(1);
					*/
					listOfShows = firstMovieElement.getElementsByTagName("show");
					for (int k = 0; k < listOfShows.getLength(); k++) {
						firstShowNode = listOfShows.item(k);
						if (firstShowNode.getNodeType() == Node.ELEMENT_NODE) {
							firstShowElement = (Element) firstShowNode;
							kolosejevIDshowa = firstShowNode.getAttributes().getNamedItem("id").getNodeValue();

							for (int stevecTagov = 0; stevecTagov < tagiShowa.length; stevecTagov++)
								vrednostiShowa[stevecTagov] = preberiIzXML(firstShowElement, tagiShowa[stevecTagov]);

							koledar.setTime(formatCasa.parse(vrednostiShowa[1]));
							timestamp = new Timestamp(koledar.getTimeInMillis());
							dateParse = formatDatuma.parse(vrednostiShowa[0]);
							timestamp.setYear(dateParse.getYear());
							timestamp.setMonth(dateParse.getMonth());
							timestamp.setDate(dateParse.getDate());

							/* vnos v bazo */
							shraniShowtime(0, kolosejevIDshowa, timestamp, vrednostiShowa[2], vrednostiShowa[3], vrednostiShowa[4], idFilma);
						}
					}
				}
			}
			System.out.println("Podatki so uspešno preneseni v bazo!");

			/*
			 * preostale filme v seznamu nastavimo na false (niso več na voljo v
			 * XML)
			 */
			/*for (String s : idjiFilmov) {
				psi.setBoolean(1, false);
				psi.setString(2, s);
				psi.executeUpdate();
			}
			*/
		} catch (MalformedURLException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		} catch (ParserConfigurationException e) {
			e.printStackTrace();
		} catch (SAXException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	private ArrayList<String> vrniVseIDjeKolosejevihFilmov() {
		// TO-DO
		//https://www.roseindia.net/tutorial/java/swing/appendNodeToXML.html
		//https://estudij.um.si/pluginfile.php/422770/mod_resource/content/0/07%20-%20XSLT%20primeri%20naprej%2C%20XPath%202.0%2C%20XSLT%202.0%20in%203.0%2C%20XSL-FO.pdf
		//maš bcp datotek xml v XML mapi
		
		
		ArrayList<String> ret = new ArrayList<String>();
		try {
			DocumentBuilderFactory dbf = DocumentBuilderFactory.newInstance();
			DocumentBuilder db = dbf.newDocumentBuilder();
			Document doc = db.parse("http://localhost:8080/KIS_MovieInfo/XML/MovieList.xml");
			XPathFactory xpf = XPathFactory.newInstance();
			XPath xpath = xpf.newXPath();
			XPathExpression izraz = xpath.compile("/MovieList/Movie/KolosejMovieID/@value");
			Object rezultat = izraz.evaluate(doc, XPathConstants.NODESET);
		} catch (ParserConfigurationException e) {
			e.printStackTrace();
		} catch (SAXException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		} catch (XPathExpressionException e) {
			e.printStackTrace();
		}
		return ret;
	}

	private void shraniMovie(int i, String kolosejevID, String string, String string2, String string3, String string4,
			String string5, int j, int k, String string6, String poster, String string7, String string8, String string9,
			String string10, String string11, String string12, String string13, String string14, String string15, int l,
			int m, boolean b) {
		//tukaj shraniš v MovieList.xml
	}

	private void shraniShowtime(int id, String kolosejevIDshowa, Timestamp timestamp, String string, String string2, String string3, int idFilma) {
		//tukaj shraniš v ShowtimeList.xml
	}

	public static String preberiIzXML(Element firstElement, String prejetTag) {
		NodeList tagList = firstElement.getElementsByTagName(prejetTag);
		Element tagElement = (Element) tagList.item(0);
		NodeList textTAGList = tagElement.getChildNodes();
		String vrnjenTag = ((Node) textTAGList.item(0)).getNodeValue().trim();
		return vrnjenTag.replace("'", "\'");
	}

	public static String preberiIzXMLterPreveri(Element firstElement, String prejetTag) {
		NodeList tagList = firstElement.getElementsByTagName(prejetTag);
		Element tagElement = (Element) tagList.item(0);
		NodeList textTAGList = tagElement.getChildNodes();
		Text tagCheckedText = (Text) textTAGList.item(0);
		if (tagCheckedText == null) {
			Document doc = tagElement.getOwnerDocument();
			tagCheckedText = doc.createTextNode(prejetTag);
			tagElement.appendChild(tagCheckedText);
			tagCheckedText.setTextContent("");
		}
		String vrnjenTag = tagCheckedText.getWholeText();
		return vrnjenTag.replace("'", "\'");
	}

	public static int preberiStevilcneVrednostiIzXML(Element firstElement, String prejetTag) {
		NodeList tagList = firstElement.getElementsByTagName(prejetTag);
		Element tagElement = (Element) tagList.item(0);
		NodeList textTAGList = tagElement.getChildNodes();
		return Integer.parseInt(((Node) textTAGList.item(0)).getNodeValue().trim());
	}
}