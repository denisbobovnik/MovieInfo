import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.math.BigInteger;
import java.net.MalformedURLException;
import java.net.URL;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.GregorianCalendar;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.xml.bind.annotation.adapters.HexBinaryAdapter;
import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.ParserConfigurationException;
import org.apache.poi.xwpf.usermodel.Borders;
import org.apache.poi.xwpf.usermodel.XWPFDocument;
import org.apache.poi.xwpf.usermodel.XWPFParagraph;
import org.apache.poi.xwpf.usermodel.XWPFStyle;
import org.apache.poi.xwpf.usermodel.XWPFStyles;
import org.apache.poi.xwpf.usermodel.XWPFTable;
import org.apache.poi.xwpf.usermodel.XWPFTableRow;
import org.openxmlformats.schemas.wordprocessingml.x2006.main.CTColor;
import org.openxmlformats.schemas.wordprocessingml.x2006.main.CTDecimalNumber;
import org.openxmlformats.schemas.wordprocessingml.x2006.main.CTFonts;
import org.openxmlformats.schemas.wordprocessingml.x2006.main.CTHpsMeasure;
import org.openxmlformats.schemas.wordprocessingml.x2006.main.CTOnOff;
import org.openxmlformats.schemas.wordprocessingml.x2006.main.CTPPr;
import org.openxmlformats.schemas.wordprocessingml.x2006.main.CTRPr;
import org.openxmlformats.schemas.wordprocessingml.x2006.main.CTString;
import org.openxmlformats.schemas.wordprocessingml.x2006.main.CTStyle;
import org.openxmlformats.schemas.wordprocessingml.x2006.main.STStyleType;
import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;
import org.xml.sax.SAXException;

@WebServlet(urlPatterns="/PredstaveDOCXServlet")
public class PredstaveDOCXServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public PredstaveDOCXServlet() {
    }
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			String center = request.getParameter("center");
	    	center = center.toUpperCase();
	    	
			DocumentBuilderFactory dbf = DocumentBuilderFactory.newInstance();
			DocumentBuilder db = dbf.newDocumentBuilder();
			Document doc = db.parse(new URL("http://localhost:8080/KIS_MovieInfo/XML/ShowtimeList.xml").openStream());
			Node showtimeList = doc.getElementsByTagName("ShowtimeList").item(0);
			NodeList showtimes = showtimeList.getChildNodes();

			XWPFDocument document = new XWPFDocument();
			
	    	XWPFStyles styles = document.createStyles();
	    	String heading1 = "My Heading 1";
	    	addCustomHeadingStyle(document, styles, heading1, 1, 36, "4288BC");
	    	
	    	XWPFParagraph paragraph = document.createParagraph();
	    	paragraph.setStyle(heading1);
	    	paragraph.setBorderBottom(Borders.SINGLE);
	    	paragraph.createRun().setText("Spored objekta " + center);
	    	
	    	XWPFTable table = document.createTable();
	    	XWPFTableRow glava = table.getRow(0);
	    	glava.getCell(0).setText("Datum");
	    	glava.addNewTableCell().setColor("D9D9D9");
	    	glava.addNewTableCell().setColor("D9D9D9");
	    	glava.addNewTableCell().setColor("D9D9D9");
	    	glava.addNewTableCell().setColor("D9D9D9");
	    	glava.addNewTableCell().setColor("D9D9D9");
	    	glava.addNewTableCell().setColor("D9D9D9");
	    	glava.getCell(0).setColor("D9D9D9");
	    	glava.getCell(1).setText("Kraj");
	    	glava.getCell(2).setText("Tip");
	    	glava.getCell(3).setText("Čas");
	    	glava.getCell(4).setText("Film");
	    	glava.getCell(5).setText("Dvorana");
	    	glava.getCell(6).setText("Cena");
			
			SimpleDateFormat adf = new SimpleDateFormat("yyyy-MM-dd");
			SimpleDateFormat sdf = new SimpleDateFormat("dd. MM. yyyy");
			Calendar danes = new GregorianCalendar();
			
			Node showtimeVozlisce;
			Element showtimeElement, vstopnicaElement;
			String movieID = "";
			String cenaVstopnice = "";
			String tipVstopnice = "";
			String centerXML = "";
			NodeList vstopnicaList = null;
			NodeList textCENAList = null;
			for (int i = 0; i < showtimes.getLength(); i++) {
				showtimeVozlisce = showtimes.item(i);
				if (showtimeVozlisce.getNodeType() == Node.ELEMENT_NODE) {
					showtimeElement = (Element) showtimeVozlisce;
					
					movieID = showtimeElement.getAttributes().getNamedItem("movieID").getNodeValue();
					
					centerXML = preberiIzXML(showtimeElement, "Center").toUpperCase();					
					if(!centerXML.equals(center))
						continue;
					
					Calendar cal = Calendar.getInstance();
					cal.setTime(adf.parse(preberiIzXML(showtimeElement, "Date")));
					
					if(cal.before(danes))
						continue;
					
					vstopnicaList = showtimeElement.getElementsByTagName("Vstopnica");
					if (vstopnicaList.getLength() != 0) {
						vstopnicaElement = (Element) vstopnicaList.item(0);
						tipVstopnice = vstopnicaElement.getAttributes().getNamedItem("tipPredstave").getNodeValue();
						textCENAList = vstopnicaElement.getChildNodes();
						cenaVstopnice = ((Node) textCENAList.item(0)).getNodeValue().trim();
						cenaVstopnice += " " + vstopnicaElement.getAttributes().getNamedItem("valuta").getNodeValue();
					}
					
					XWPFTableRow predstava = table.createRow();
					predstava.getCell(0).setText(sdf.format(cal.getTimeInMillis()));
					predstava.getCell(1).setText( preberiIzXML(showtimeElement, "City"));
					predstava.getCell(2).setText(tipVstopnice);
					predstava.getCell(3).setText(preberiIzXML(showtimeElement, "Time"));
			    	predstava.getCell(4).setText(vrniImeFilma(movieID));
			    	predstava.getCell(5).setText(preberiIzXML(showtimeElement, "Theater"));
			    	predstava.getCell(6).setText(cenaVstopnice);
			    	
			    	tipVstopnice = "";
			    	cenaVstopnice = "";
			    	movieID = "";
				}
			}
			
	    	ByteArrayOutputStream out = new ByteArrayOutputStream();
	    	document.write(out);
	    	byte [] outArray = out.toByteArray();
	    	
	        String filename="Spored objekta " + center;
	        filename = filename.replace(' ', '_') + ".docx";
	    	
	    	response.setContentType("application/ms-word");
	        response.setContentLength(outArray.length);
	        response.setHeader("Expires:", "0");
	        response.setHeader("Content-Disposition", "attachment; filename=" + filename);

	        OutputStream outStream = response.getOutputStream();
	        outStream.write(outArray);
	        outStream.flush();
		} catch (ParserConfigurationException e) {
			e.printStackTrace();
		} catch (SAXException e) {
			e.printStackTrace();
		} catch (ParseException e) {
			e.printStackTrace();
		}
	}
	
	private static void addCustomHeadingStyle(XWPFDocument docxDocument, XWPFStyles styles, String strStyleId, int headingLevel, int pointSize, String hexColor) {

	    CTStyle ctStyle = CTStyle.Factory.newInstance();
	    ctStyle.setStyleId(strStyleId);


	    CTString styleName = CTString.Factory.newInstance();
	    styleName.setVal(strStyleId);
	    ctStyle.setName(styleName);

	    CTDecimalNumber indentNumber = CTDecimalNumber.Factory.newInstance();
	    indentNumber.setVal(BigInteger.valueOf(headingLevel));

	    // lower number > style is more prominent in the formats bar
	    ctStyle.setUiPriority(indentNumber);

	    CTOnOff onoffnull = CTOnOff.Factory.newInstance();
	    ctStyle.setUnhideWhenUsed(onoffnull);

	    // style shows up in the formats bar
	    ctStyle.setQFormat(onoffnull);

	    // style defines a heading of the given level
	    CTPPr ppr = CTPPr.Factory.newInstance();
	    ppr.setOutlineLvl(indentNumber);
	    ctStyle.setPPr(ppr);

	    XWPFStyle style = new XWPFStyle(ctStyle);

	    CTHpsMeasure size = CTHpsMeasure.Factory.newInstance();
	    size.setVal(new BigInteger(String.valueOf(pointSize)));
	    CTHpsMeasure size2 = CTHpsMeasure.Factory.newInstance();
	    size2.setVal(new BigInteger("24"));

	    CTFonts fonts = CTFonts.Factory.newInstance();
	    fonts.setAscii("Loma" );

	    CTRPr rpr = CTRPr.Factory.newInstance();
	    rpr.setRFonts(fonts);
	    rpr.setSz(size);
	    rpr.setSzCs(size2);

	    CTColor color=CTColor.Factory.newInstance();
	    color.setVal(hexToBytes(hexColor));
	    rpr.setColor(color);
	    style.getCTStyle().setRPr(rpr);
	    // is a null op if already defined

	    style.setType(STStyleType.PARAGRAPH);
	    styles.addStyle(style);

	}

	public static byte[] hexToBytes(String hexString) {
	     HexBinaryAdapter adapter = new HexBinaryAdapter();
	     byte[] bytes = adapter.unmarshal(hexString);
	     return bytes;
	}

	public String preberiIzXML(Element firstElement, String prejetTag) {
		NodeList tagList = firstElement.getElementsByTagName(prejetTag);
		Element tagElement = (Element) tagList.item(0);
		NodeList textTAGList = tagElement.getChildNodes();
		String vrnjenTag = ((Node) textTAGList.item(0)).getNodeValue().trim();
		return vrnjenTag.replace("'", "\'");
	}
	
	public String vrniImeFilma(String movieID) throws MalformedURLException, SAXException, IOException, ParserConfigurationException {
		DocumentBuilderFactory dbf = DocumentBuilderFactory.newInstance();
		DocumentBuilder db = dbf.newDocumentBuilder();
		Document doc = db.parse(new URL("http://localhost:8080/KIS_MovieInfo/XML/MovieList.xml").openStream());
		Node movieList = doc.getElementsByTagName("MovieList").item(0);
		NodeList movies = movieList.getChildNodes();
		
		Node movieVozlisce = null;
		Element movieElement = null;
		String ime = "";
		for (int i = 0; i < movies.getLength(); i++) {
			movieVozlisce = movies.item(i);
			if (movieVozlisce.getNodeType() == Node.ELEMENT_NODE) {
				movieElement = (Element) movieVozlisce;
				if(movieElement.getAttributes().getNamedItem("movieID").getNodeValue().equals(movieID)) {
					NodeList titleList = movieElement.getElementsByTagName("Title");
					if (titleList.getLength() != 0)
						ime = preberiIzXML(movieElement, "Title");
					else
						ime = preberiIzXML(movieElement, "OriginalTitle");
				}
				
			}
		}
		return ime;
	}
}