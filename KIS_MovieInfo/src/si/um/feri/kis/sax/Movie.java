package si.um.feri.kis.sax;

import java.util.ArrayList;
import java.util.List;

public class Movie {
	private String movieID, kategorija, originalTitle, genre, language, imdb;
	private int year;
	private List<Rating> ratings;
	
	public Movie() {
		ratings = new ArrayList<Rating>();
	}
	public Movie(String movieID, String kategorija, String originalTitle, String genre, String language, String imdb, int year) {
		this.movieID = movieID;
		this.kategorija = kategorija;
		this.originalTitle = originalTitle;
		this.genre = genre;
		this.language = language;
		this.imdb = imdb;
		this.year = year;
		ratings = new ArrayList<Rating>();
	}
	
	public void addRating(Rating r) {
		if(ratings==null)
			ratings = new ArrayList<Rating>();
		ratings.add(r);
	}

	public String getMovieID() {
		return movieID;
	}
	public void setMovieID(String movieID) {
		this.movieID = movieID;
	}
	public String getKategorija() {
		return kategorija;
	}
	public void setKategorija(String kategorija) {
		this.kategorija = kategorija;
	}
	public String getOriginalTitle() {
		return originalTitle;
	}
	public void setOriginalTitle(String originalTitle) {
		this.originalTitle = originalTitle;
	}
	public String getGenre() {
		return genre;
	}
	public void setGenre(String genre) {
		this.genre = genre;
	}
	public String getLanguage() {
		return language;
	}
	public void setLanguage(String language) {
		this.language = language;
	}
	public String getImdb() {
		return imdb;
	}
	public void setImdb(String imdb) {
		this.imdb = imdb;
	}
	public int getYear() {
		return year;
	}
	public void setYear(int year) {
		this.year = year;
	}
	public List<Rating> getRatings() {
		return ratings;
	}
	public void setRatings(List<Rating> ratings) {
		this.ratings = ratings;
	}
}