package si.um.feri.kis.stax;

import java.text.SimpleDateFormat;
import java.time.LocalTime;
import java.time.format.DateTimeFormatter;
import java.time.temporal.ChronoField;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import javax.xml.stream.XMLInputFactory;
import javax.xml.stream.XMLStreamConstants;
import javax.xml.stream.XMLStreamReader;
import javax.xml.transform.stream.StreamSource;

public class RazpoznavalnikStAX {
	
	private List<Showtime> showtimeList;
	private Showtime showtime;
	
	public RazpoznavalnikStAX(String URLShowtimeListXML) {
		showtimeList = new ArrayList<Showtime>();
		preberi(URLShowtimeListXML);
	}
	
	public List<Showtime> getShowtimeList() {
		return showtimeList;
	}
	
	public void preberi(String xmlDoc) {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		try {
			XMLInputFactory xmlInputFactory = XMLInputFactory.newInstance();
			XMLStreamReader reader = xmlInputFactory.createXMLStreamReader(new StreamSource(xmlDoc));
			
			while(reader.hasNext()) {
				int event = reader.next();
				switch(event) {
					case XMLStreamConstants.START_ELEMENT:
						if(reader.getName().getLocalPart().compareTo("Showtime")==0) {
							showtime = new Showtime();
							showtime.setShowtimeID(reader.getAttributeValue(0));
							showtime.setMovieID(reader.getAttributeValue(1));
						}
						if(reader.getName().getLocalPart().compareTo("Center")==0) {
							showtime.setCenter(reader.getElementText());
						}
						if(reader.getName().getLocalPart().compareTo("Theater")==0) {
							showtime.setTheater(reader.getElementText());
						}
						if(reader.getName().getLocalPart().compareTo("Date")==0) {
							showtime.setDate(sdf.parse(reader.getElementText()));
						}
						if(reader.getName().getLocalPart().compareTo("Time")==0) {
							String time = reader.getElementText();
							Date trenutniDatum = showtime.getDate();
							
						    LocalTime localTime = LocalTime.parse(time, DateTimeFormatter.ofPattern("HH:mm:ss"));
						    trenutniDatum.setHours(localTime.get(ChronoField.CLOCK_HOUR_OF_DAY));
						    trenutniDatum.setMinutes(localTime.get(ChronoField.MINUTE_OF_HOUR));
						    trenutniDatum.setSeconds(localTime.get(ChronoField.SECOND_OF_MINUTE));
						    
							showtime.setDate(trenutniDatum);
						}
						if(reader.getName().getLocalPart().compareTo("Vstopnica")==0)
							showtime.setVstopnica(new Vstopnica(reader.getAttributeValue(0), reader.getAttributeValue(1), Double.parseDouble(reader.getElementText())));
						break;
					case XMLStreamConstants.END_ELEMENT:
						if(reader.getName().getLocalPart().compareTo("Showtime")==0)
							showtimeList.add(showtime);
						break;
				}
			}
		} catch (Exception e) {
			System.out.println("Napaka: " + e.getMessage());
			e.printStackTrace();
		}
	}
}