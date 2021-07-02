package movie.dao;

import static db.JdbcUtil.close;

import java.sql.*;
import java.util.ArrayList;

import movie.vo.MovieBean;

public class MovieDao {
private MovieDao() {};
	
	private static MovieDao instance;

	public static MovieDao getInstance() {
		if(instance == null) {
			instance = new MovieDao();
		}
		return instance;
	}

	Connection con;
	
	public void setConnection(Connection con) {
		this.con = con;
	}
	
	PreparedStatement pstmt;
	ResultSet rs;

	
	
	
	public int movieSearch() {
		
		
		return 0;
	}




	public ArrayList<MovieBean> getMovieByChart() {
		
		System.out.println("dao-chart");
		ArrayList<MovieBean> list = new ArrayList<MovieBean>();
		String sql = "SELECT movieseq,title,sum(count),poster, count from chart where date >= date_sub(now(),interval 1 DAY) group by title order by sum(count) desc limit 0,10";
		try {
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				MovieBean mb = new MovieBean();
				mb.setMovieSeq(rs.getInt("movieseq"));
				mb.setMovieTitle(rs.getString("title"));
				mb.setMoviePoster(rs.getString("poster"));
				list.add(mb);
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(rs);
			close(pstmt);
		}
		return list;
	}

}








