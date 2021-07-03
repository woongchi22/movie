package movie.vo;

import java.sql.*;

public class MovieBean {
	private String movieGenre;
	private String movieRuntime;
	private String movieYear;
	private String movieTitle;
	private int movieSeq;
	private String movieGrade;
	private String nick;
	private String director;
	private String nation;
	private String openDt;
	private String moviePoster;
	
	public String getMoviePoster() {
		return moviePoster;
	}
	public void setMoviePoster(String moviePoster) {
		this.moviePoster = moviePoster;
	}
	public String getOpenDt() {
		return openDt;
	}
	public void setOpenDt(String openDt) {
		this.openDt = openDt;
	}
	public String getDirector() {
		return director;
	}
	public void setDirector(String director) {
		this.director = director;
	}
	public String getNation() {
		return nation;
	}
	public void setNation(String nation) {
		this.nation = nation;
	}

	public String getNick() {
		return nick;
	}
	public void setNick(String nick) {
		this.nick = nick;
	}
	public String getMovieGrade() {
		return movieGrade;
	}
	public void setMovieGrade(String movieGrade) {
		this.movieGrade = movieGrade;
	}
	public String getMovieGenre() {
		return movieGenre;
	}
	public void setMovieGenre(String movieGenre) {
		this.movieGenre = movieGenre;
	}
	public String getMovieRuntime() {
		return movieRuntime;
	}
	public void setMovieRuntime(String movieRuntime) {
		this.movieRuntime = movieRuntime;
	}
	public String getMovieYear() {
		return movieYear;
	}
	public void setMovieYear(String movieYear) {
		this.movieYear = movieYear;
	}
	public String getMovieTitle() {
		return movieTitle;
	}
	public void setMovieTitle(String movieTitle) {
		this.movieTitle = movieTitle;
	}
	public int getMovieSeq() {
		return movieSeq;
	}
	public void setMovieSeq(int movieSeq) {
		this.movieSeq = movieSeq;
	}
	
	
}
