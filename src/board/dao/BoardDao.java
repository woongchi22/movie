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

	public ArrayList<ReviewBean> getReview(ReviewBean rb) {
		System.out.println("dao-getReview");
		ArrayList<ReviewBean> list = null;
		
		String sql = "select * from review where movieSeq=? ORDER BY idx DESC ";
		try {
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1,rb.getMovieSeq());
			rs = pstmt.executeQuery();
			list = new ArrayList<ReviewBean>();
			while(rs.next()) {
				ReviewBean rb2 = new ReviewBean();
				rb2.setIdx(rs.getInt("idx"));
				rb2.setName(rs.getString("name"));
				rb2.setMovieSeq(rs.getInt("movieSeq"));
				rb2.setTitle(rs.getString("title"));
				rb2.setContent(rs.getString("content"));
				rb2.setGrade(rs.getInt("grade"));
				rb2.setLike_count(rs.getInt("like_count"));
				
				list.add(rb2);
			}
		} catch (SQLException e) {
			System.out.println("BoardDAO - selectReviewListCount 에러 : " + e.getMessage());

		} finally {
			close(rs);
			close(pstmt);
		}
		
		
		return list;
	}

	public int reviewWrite(ReviewBean rb) {
		System.out.println("dao-reviewWrite");
		int insertCount = 0;
//		ArrayList<ReviewBean> reviewList = new ArrayList<ReviewBean>();
		
		String sql ="INSERT INTO review VALUES(idx,?,null,?,?,?,null,now())";
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
	
	
	
	
	
	
}
