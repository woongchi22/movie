package board.dao;

import static db.JdbcUtil.*;

import java.sql.*;
import java.util.*;

import board.vo.ReplyBean;
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



	public int reviewWrite(ReviewBean reviewBean) {
		System.out.println("dao-reviewWrite");
		int insertCount = 0;
//		ArrayList<ReviewBean> reviewList = new ArrayList<ReviewBean>();
		System.out.println(reviewBean.getContent());
		String sql ="INSERT INTO review VALUES(idx,?,0,?,?,?,0,now())";
		try {
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, reviewBean.getName());
			pstmt.setInt(2, reviewBean.getMovieSeq());
			pstmt.setString(3, reviewBean.getTitle());
			pstmt.setString(4, reviewBean.getContent());
			
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
				review.setIdx(rs.getInt("idx"));
				review.setContent(rs.getString("content"));
				review.setGrade(rs.getInt("grade"));
				review.setLike_count(rs.getInt("like_count"));
				review.setMovieSeq(rs.getInt("movieSeq"));
				review.setName(rs.getString("name"));
				review.setTitle(rs.getString("title"));
				review.setDate(rs.getDate("date"));
				
				reviewList.add(review);
//				System.out.println(reviewList);
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

	//리뷰 댓글
	public int insertReply(ReplyBean replyBean, int idx) {
		
		System.out.println("dao-insertReply");
		int insertCount = 0;
		System.out.println(replyBean.getContent());
		
		String sql ="INSERT INTO reply VALUES(idx,?,?,?,0,now())";
		try {
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, replyBean.getName());
			pstmt.setInt(2, replyBean.getMovieSeq());
			pstmt.setString(3, replyBean.getContent());
			
			insertCount = pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("BoardDao - insertReply() 에러 : " + e.getMessage());

		}finally {
			close(rs);
			close(pstmt);
		}
		
		return insertCount;
	}

	public ReviewBean getReviewDetail(int idx, int movieSeq) {
		System.out.println("BoardDAO-getReviewDetail");
		System.out.println(idx);
		
		ReviewBean reviewBean = new ReviewBean();
		
		
		
		try {
			String sql = "SELECT * FROM review WHERE idx=? AND movieSeq=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, idx);
			pstmt.setInt(2, movieSeq);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				reviewBean.setIdx(rs.getInt("idx"));
				reviewBean.setGrade(rs.getInt("grade"));
				reviewBean.setMovieSeq(rs.getInt("movieSeq"));
				reviewBean.setTitle(rs.getString("title"));
				reviewBean.setContent(rs.getString("content"));
				reviewBean.setName(rs.getString("name"));
				reviewBean.setDate(rs.getDate("date"));

			}
			
		} catch (SQLException e) {
			e.printStackTrace();
			System.out.println("BoardDAO - getReviewDetail() 에러 : " + e.getMessage());
		} finally {
			close(rs);
			close(pstmt);
		}
		
		return reviewBean;
	}

	public ArrayList<ReplyBean> getReplyList(ReplyBean replyBean) {
		System.out.println("BoardDAO-getListReply");
		
		ArrayList<ReplyBean> replyList = new ArrayList<ReplyBean>();
		
		try {
			String sql = "SELECT * FROM reply where movieSeq=? ORDER BY date DESC";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, replyBean.getMovieSeq());
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				ReplyBean reply = new ReplyBean();
				reply.setIdx(rs.getInt("idx"));
				reply.setName(rs.getString("name"));
				reply.setMovieSeq(rs.getInt("movieSeq"));
				reply.setContent(rs.getString("content"));
				reply.setRe_ref(rs.getInt("re_ref"));
				reply.setDate(rs.getDate("date"));
				
				replyList.add(reply);
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
			System.out.println("BoardDao - getListReply() 에러: " + e.getMessage());
		} finally {
			close(rs);
			close(pstmt);
		}
		
		return replyList;
	}

	public int updateReview(ReviewBean reviewBean) {
		System.out.println("BoardDAO-updateReview");
		int insertCount = 0;

		try {

			String sql = "update review set content = ? where name =? and movieSeq = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, reviewBean.getContent());
			pstmt.setString(2, reviewBean.getName());
			pstmt.setInt(3, reviewBean.getMovieSeq());

			insertCount = pstmt.executeUpdate();

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(rs);
			close(pstmt);
		}

		return insertCount;
	}
	
	
	
	
	
	
}
