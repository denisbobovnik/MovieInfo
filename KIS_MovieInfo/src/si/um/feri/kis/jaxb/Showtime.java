package si.um.feri.kis.jaxb;

import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlAttribute;
import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlRootElement;
import javax.xml.bind.annotation.XmlType;

@XmlRootElement(name = "Showtime")
@XmlType (propOrder={"Date","Time","City","Center","Theater","Vstopnica"})
@XmlAccessorType (XmlAccessType.FIELD)
public class Showtime {
	
	@XmlAttribute
	private String showtimeID;
	
	@XmlAttribute
	private String movieID;
	
	private String Center, Theater, Date, Time, City;
	
	@XmlElement(name = "Vstopnica")
	private Vstopnica Vstopnica;

	public Showtime() {
		
	}
	public Showtime(String showtimeID, String movieID, String Center, String Theater, String Date, String Time, String City, Vstopnica Vstopnica) {
		this.showtimeID = showtimeID;
		this.movieID = movieID;
		this.Center = Center;
		this.City = City;
		this.Time = Time;
		this.Theater = Theater;
		this.Date = Date;
		this.Vstopnica = Vstopnica;
	}
	
	public String getShowtimeID() {
		return showtimeID;
	}
	public void setShowtimeID(String showtimeID) {
		this.showtimeID = showtimeID;
	}
	public String getMovieID() {
		return movieID;
	}
	public void setMovieID(String movieID) {
		this.movieID = movieID;
	}
	public String getCenter() {
		return Center;
	}
	public void setCenter(String Center) {
		this.Center = Center;
	}
	public String getTheater() {
		return Theater;
	}
	public void setTheater(String Theater) {
		this.Theater = Theater;
	}
	public String getDate() {
		return Date;
	}
	public void setDate(String Date) {
		this.Date = Date;
	}
	public String getTime() {
		return Time;
	}
	public void setTime(String Time) {
		this.Time = Time;
	}
	public String getCity() {
		return City;
	}
	public void setCity(String City) {
		this.City = City;
	}
	public Vstopnica getVstopnica() {
		return Vstopnica;
	}
	public void setVstopnica(Vstopnica Vstopnica) {
		this.Vstopnica = Vstopnica;
	}
}