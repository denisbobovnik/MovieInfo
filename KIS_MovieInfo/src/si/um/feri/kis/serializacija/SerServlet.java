package si.um.feri.kis.serializacija;

import java.io.*;
import java.net.*;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.*;
import javax.xml.bind.*;
import si.um.feri.kis.jaxb.*;

@WebServlet(urlPatterns="/SerServlet")
public class SerServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
    public SerServlet() {
    }
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("application/xml");
		response.setCharacterEncoding("UTF-8");
		PrintWriter out = response.getWriter();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		try {
			String center = request.getParameter("center");
			JAXBContext jaxbContext = JAXBContext.newInstance(ShowtimeList.class);
			Unmarshaller jaxbUnmarshaller = jaxbContext.createUnmarshaller();
			String xmlPath = "http://localhost:8080/KIS_MovieInfo/XML/ShowtimeList.xml";
			InputStream inputStream = new URL(xmlPath).openStream();
			
			Date danes = new Date();
		    ShowtimeList showtimeList = (ShowtimeList) jaxbUnmarshaller.unmarshal(inputStream);
            ShowtimeList predstaveCentra = new ShowtimeList();
            for(int i=0; i<showtimeList.getShowtimeList().size(); i++)
            	if(showtimeList.getShowtimeList().get(i).getCenter().equals(center) && (danes.before(sdf.parse(showtimeList.getShowtimeList().get(i).getDate())) || sdf.format(danes).equals(showtimeList.getShowtimeList().get(i).getDate())))
            		predstaveCentra.dodajPredstavo(showtimeList.getShowtimeList().get(i));
            
            Marshaller marshaller = jaxbContext.createMarshaller();
            marshaller.setProperty(Marshaller.JAXB_SCHEMA_LOCATION, "http://localhost:8080/KIS_MovieInfo/XML/Besednjak.xsd");
            marshaller.setProperty(Marshaller.JAXB_FORMATTED_OUTPUT, true);
            marshaller.marshal(predstaveCentra, out);
		} catch (JAXBException e) {
			e.printStackTrace();
		} catch (ParseException e) {
			e.printStackTrace();
		}
	}
}