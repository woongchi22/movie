package movie.dao;

import static db.JdbcUtil.*;
import java.sql.*;
import java.util.ArrayList;

import movie.vo.MovieBean;

public class MovieDao {
	
	private static MovieDao instance;
	private MovieDao() {};

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
	
	
	// 별점 등록
	public int gradeInsert(MovieBean mb) {
		System.out.println("mDao - gradeInsert()");
		
		int insertCount = 0;
		
		try {
			String sql = "SELECT grade FROM grade WHERE name=? and movieSeq=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, mb.getName());
			pstmt.setInt(2, mb.getMovieSeq());
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				sql = "UPDATE grade SET grade=? WHERE name=? and movieSeq=?";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, mb.getGrade());
				pstmt.setString(2, mb.getName());
				pstmt.setInt(3, mb.getMovieSeq());
				insertCount = -1;
				pstmt.executeUpdate();
				
				sql = "UPDATE review SET grade=? WHERE name=? and movieSeq=?";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, mb.getGrade());
				pstmt.setString(2, mb.getName());
				pstmt.setInt(3, mb.getMovieSeq());
				int updateCount = pstmt.executeUpdate();
				
				if(updateCount > 0) {
					commit(con);	
				}

			} else {
				sql = "INSERT INTO grade VALUES(idx,?,?,?,?,?,?,?,?,?)";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, mb.getName());
				pstmt.setInt(2, mb.getMovieSeq());
				pstmt.setString(3, mb.getTitle());
				pstmt.setInt(4, mb.getGrade());
				pstmt.setString(5, mb.getNation());
				pstmt.setString(6, mb.getDirector());
				pstmt.setString(7, mb.getGenre());
				pstmt.setInt(8, mb.getRuntime());
				pstmt.setString(9, mb.getPoster());
				
				insertCount = pstmt.executeUpdate();
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(rs);
			close(pstmt);
		}
		
		return insertCount;
	}

	// 별점 조회
	public int selectStar(MovieBean mb) {
		
		int movieGrade = 0;
		
		try {
			String sql = "SELECT * FROM grade WHERE name=? and movieSeq=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, mb.getName());
			pstmt.setInt(2, mb.getMovieSeq());
			rs = pstmt.executeQuery();
			
			if (rs.next()) {
				movieGrade = rs.getInt("grade");
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(rs);
			close(pstmt);
		}
		
		return movieGrade;
	}

	// 별점 삭제
	public int deleteStar(String name, int movieSeq) {
		System.out.println("mDao - deleteStar()");
		
		int deleteCount = 0;
		
		try {
			String sql = "DELETE FROM grade WHERE name=? AND movieSeq=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, name);
			pstmt.setInt(2, movieSeq);
			deleteCount = pstmt.executeUpdate();
			
			sql = "DELETE FROM review WHERE name=? AND movieSeq=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, name);
			pstmt.setInt(2, movieSeq);
			int deleteReview = pstmt.executeUpdate();
			
			if(deleteReview > 0) {
				commit(con);	
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(pstmt);
		}
		
		return deleteCount;
	}

	// 평균 별점
	public float averageStar(int movieSeq) {
		System.out.println("mDao - averageStar()");
		
		float avgGrade = 0.0f;
		
		try {
			String sql = "SELECT ROUND((SUM(grade) / COUNT(grade)), 1) AS 'avgGrade' FROM grade WHERE movieSeq=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, movieSeq);
			rs = pstmt.executeQuery();
			
			if (rs.next()) {
				avgGrade = rs.getFloat("avgGrade");
				System.out.println("평균별점: " + avgGrade);
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			close(rs);
			close(pstmt);
		}
		
		return avgGrade;
	}

	// 평가한 영화 가져오기
	public ArrayList<MovieBean> getMovie(String name) {
		System.out.println("mdao-getMovie");
		
		ArrayList<MovieBean> movieList = null;
		
		try {
			String sql = "SELECT * FROM grade WHERE name=? ORDER BY idx DESC";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, name);
			rs = pstmt.executeQuery();
			
			movieList = new ArrayList<MovieBean>();
			
			while(rs.next()) {
				MovieBean movie = new MovieBean();
				movie.setIdx(rs.getInt("idx"));
				movie.setName(rs.getString("name"));
				movie.setMovieSeq(rs.getInt("movieSeq"));
				movie.setTitle(rs.getString("title"));
				movie.setGrade(rs.getInt("grade"));
				movie.setNation(rs.getString("nation"));
				movie.setDirector(rs.getString("director"));
				movie.setGenre(rs.getString("genre"));
				movie.setRuntime(rs.getInt("runtime"));
				movie.setPoster(rs.getString("poster"));
				movieList.add(movie);
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
			System.out.println("movieDAO - getMovie 에러");
			
		} finally {
			close(rs);
			close(pstmt);
		}
		
		return movieList;
	}

}








