package si.um.feri.kis.stax;

import java.util.Date;

public class Showtime {
	private String showtimeID, movieID, center, theater;
	private Date date;
	private Vstopnica vstopnica;
	
	public Showtime() {
		
	}
	public Showtime(String showtimeID, String movieID, String center, String theater, Date date, Vstopnica vstopnica) {
		this.showtimeID = showtimeID;
		this.movieID = movieID;
		this.center = center;
		this.theater = theater;
		this.date = date;
		this.vstopnica = vstopnica;
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
		return center;
	}
	public void setCenter(String center) {
		this.center = center;
	}
	public String getTheater() {
		return theater;
	}
	public void setTheater(String theater) {
		this.theater = theater;
	}
	public Date getDate() {
		return date;
	}
	public void setDate(Date date) {
		this.date = date;
	}
	public Vstopnica getVstopnica() {
		return vstopnica;
	}
	public void setVstopnica(Vstopnica vstopnica) {
		this.vstopnica = vstopnica;
	}
}