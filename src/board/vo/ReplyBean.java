package board.vo;

import java.util.Date;

public class ReplyBean {

	private int idx;
	private String name;
	private int movieSeq;
	private String content;
	private int re_ref;
	private Date date;
	
	public int getIdx() {
		return idx;
	}
	public void setIdx(int idx) {
		this.idx = idx;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public int getMovieSeq() {
		return movieSeq;
	}
	public void setMovieSeq(int movieSeq) {
		this.movieSeq = movieSeq;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public int getRe_ref() {
		return re_ref;
	}
	public void setRe_ref(int re_ref) {
		this.re_ref = re_ref;
	}
	public Date getDate() {
		return date;
	}
	public void setDate(Date date) {
		this.date = date;
	}
	
	
}
