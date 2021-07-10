package movie.dao;

import static db.JdbcUtil.close;

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

			} else {
				sql = "INSERT INTO grade VALUES(idx,?,?,?,?)";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, mb.getName());
				pstmt.setInt(2, mb.getMovieSeq());
				pstmt.setString(3, mb.getTitle());
				pstmt.setInt(4, mb.getGrade());
				
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

}








