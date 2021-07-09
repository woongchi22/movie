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

	public MovieBean selecStar(String name, int movieSeq, int grade) {
		System.out.println("mDao - selecStar()");
		
		MovieBean mb = null;
		
		try {
			String sql = "SELECT * FROM grade WHERE name=? and movieSeq=? and grade=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, name);
			pstmt.setInt(2, movieSeq);
			pstmt.setInt(3, grade);
			rs = pstmt.executeQuery();
			
//			mb.getGrade();
			
//			if (rs.next()) {
//				MovieBean mb2 = new MovieBean();
//				mb2.setGrade(rs.getInt("grade"));
//				
//			} else {
//				return null;
//			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(rs);
			close(pstmt);
		}
		
		return mb;
	}

}








