package board.dao;

import static db.JdbcUtil.*;

import java.sql.*;
import java.util.*;

import board.vo.ReviewBean;



public class BoardDao {
	
	private BoardDao() {}
	
	private static BoardDao instance;
	
	public static BoardDao getInstance() {
		if(instance==null) {
			instance = new BoardDao();
		}
		return instance;
	}
	Connection con;
	
	public void setConnection(Connection con){
		this.con = con;
	}
	PreparedStatement pstmt;
	ResultSet rs;



	public int reviewWrite(ReviewBean rb) {
		System.out.println("dao-reviewWrite");
		int insertCount = 0;
//		ArrayList<ReviewBean> reviewList = new ArrayList<ReviewBean>();
		
		String sql ="INSERT INTO review VALUES(idx,?,0,?,?,?,0,now())";
		try {
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, rb.getName());
			pstmt.setInt(2, rb.getMovieSeq());
			pstmt.setString(3, rb.getTitle());
			pstmt.setString(4, rb.getContent());
			
			insertCount = pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("BoardDAO - insertReview() 에러 : " + e.getMessage());

		}finally {
			close(rs);
			close(pstmt);
		}
		
		return insertCount;
	}

	public ArrayList<ReviewBean> getReview(int movieSeq) {
		System.out.println("dao-getReview");
		ArrayList<ReviewBean> reviewList = null;
		
		try {
			String sql = "SELECT * FROM review where movieSeq=? ORDER BY idx DESC ";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, movieSeq);
			rs = pstmt.executeQuery();
			
			reviewList = new ArrayList<ReviewBean>();
			
			while(rs.next()) {
				ReviewBean review = new ReviewBean();
				review.setContent(rs.getString("content"));
				review.setGrade(rs.getInt("grade"));
				review.setLike_count(rs.getInt("like_count"));
				review.setMovieSeq(rs.getInt("movieSeq"));
				review.setName(rs.getString("name"));
				review.setTitle(rs.getString("title"));
				review.setDate(rs.getDate("date"));
				
				reviewList.add(review);
				
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
			System.out.println("ReviewdDao - getReview 에러");
		} finally {
			// PreparedStatement, ResultSet 객체 반환
			close(rs); // JdbcUtil.close(rs)
			close(pstmt); // JdbcUtil.close(rs)
		}
		
		return reviewList;
	}
	
	
	
	
	
	
}
