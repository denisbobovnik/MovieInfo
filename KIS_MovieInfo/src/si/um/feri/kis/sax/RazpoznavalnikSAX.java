package si.um.feri.kis.sax;
import java.util.ArrayList;
import java.util.List;
import javax.xml.parsers.SAXParser;
import javax.xml.parsers.SAXParserFactory;
import org.xml.sax.Attributes;
import org.xml.sax.SAXException;
import org.xml.sax.helpers.DefaultHandler;

public class RazpoznavalnikSAX extends DefaultHandler{

	private List<Movie> movieList;
	private String string;
	private Movie movie;
	private Rating rating;
	private String imdb;
	
	public RazpoznavalnikSAX() {
		try {
			SAXParserFactory saxFactory = SAXParserFactory.newInstance();
			SAXParser parser = saxFactory.newSAXParser();
			parser.parse("http://localhost:8080/KIS_MovieInfo/XML/MovieList.xml", this);
		} catch (Exception e) {
			System.out.println("Napaka: " + e.getMessage());
			e.printStackTrace();
		}
	}
	
	public List<Movie> getMovieList() {
		return movieList;
	}
	
	@Override
	public void startDocument() throws SAXException {
		movieList = new ArrayList<Movie>();
	}
	
	@Override
	public void startElement(String uri, String localName, String qName, Attributes attributes) throws SAXException {
		if(qName.compareTo("Movie")==0) {
			movie = new Movie();
			movie.setMovieID(attributes.getValue("movieID"));
			movie.setKategorija(attributes.getValue("kategorija"));
		}
		if(qName.compareTo("Rating")==0) {
			rating = new Rating();
		}
		if(qName.compareTo("IMDBID")==0) {
			imdb = attributes.getValue("value");
		}
	}
	
	@Override
	public void characters(char[] ch, int start, int length) throws SAXException {
		string = new String(ch, start, length);
	}
	
	
	@Override
	public void endElement(String uri, String localName, String qName) throws SAXException {
		if(qName.compareTo("OriginalTitle")==0)
			if(movie != null)
				movie.setOriginalTitle(string);
		if(qName.compareTo("Genre")==0)
			if(movie != null)
				movie.setGenre(string);
		if(qName.compareTo("Language")==0)
			if(movie != null)
				movie.setLanguage(string);
		if(qName.compareTo("IMDBID")==0)
			if(movie != null)
				movie.setImdb(imdb);
		if(qName.compareTo("Year")==0)
			if(movie != null)
				movie.setYear(Integer.parseInt(string));
		if(qName.compareTo("Source")==0)
			if(rating != null)
				rating.setSource(string);
		if(qName.compareTo("Value")==0)
			if(rating != null)
				rating.setValue(string);
		if(qName.compareTo("Rating")==0)
			movie.addRating(rating);
		if(qName.compareTo("Movie")==0)
			movieList.add(movie);
	}
	
	@Override
	public void endDocument() throws SAXException {
		
	}
}