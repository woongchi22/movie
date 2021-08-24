package board.dao;

import static db.JdbcUtil.*;

import java.sql.*;
import java.util.*;

import board.vo.ReviewBean;
import movie.vo.MovieBean;


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

	
	
	// 디테일 pro에 넘겨줌
	public String getReviewDetail(ReviewBean rb) {
		String review = "";
		
		try {
			String sql = "SELECT content FROM review WHERE name=? AND movieSeq=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, rb.getName());
			pstmt.setInt(2, rb.getMovieSeq());
			rs = pstmt.executeQuery();
			if (rs.next()) {
				review = rs.getString("content");
//				System.out.println(review);
			}

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(rs);
			close(pstmt);
		}
		
		return review;
	}

	// 리뷰 List
	public ArrayList<ReviewBean> getReview(int movieSeq) {
		ArrayList<ReviewBean> reviewList = null;
		
		try {
			String sql = "SELECT * FROM review WHERE movieSeq=? ORDER BY idx DESC ";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, movieSeq);
			rs = pstmt.executeQuery();
			
			reviewList = new ArrayList<ReviewBean>();
			
			while(rs.next()) {
				ReviewBean review = new ReviewBean();
				review.setIdx(rs.getInt("idx"));
				review.setName(rs.getString("name"));
				review.setGrade(rs.getInt("grade"));
				review.setMovieSeq(rs.getInt("movieSeq"));
				review.setTitle(rs.getString("title"));
				review.setContent(rs.getString("content"));
				review.setPoster(rs.getString("poster"));
				review.setLike_count(rs.getInt("like_count"));
				review.setDate(rs.getDate("date"));
				
				reviewList.add(review);
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
			System.out.println("ReviewdDao - getReview 에러");
		} finally {
			close(rs); // JdbcUtil.close(rs)
			close(pstmt); // JdbcUtil.close(rs)
		}
		
		return reviewList;
	}

	// 리뷰 등록
	public int reviewWrite(ReviewBean reviewBean) {
		int insertCount = 0;
		int grade = reviewBean.getGrade();
		
		try {
			String sql = "SELECT grade FROM grade WHERE name=? AND movieSeq=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, reviewBean.getName());
			pstmt.setInt(2, reviewBean.getMovieSeq());
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				grade = rs.getInt("grade");
			}
					
			sql = "INSERT INTO review VALUES(idx,?,?,?,?,?,?,0,now())";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, reviewBean.getName());
			pstmt.setInt(2, grade);
			pstmt.setInt(3, reviewBean.getMovieSeq());
			pstmt.setString(4, reviewBean.getTitle());
			pstmt.setString(5, reviewBean.getContent());
			pstmt.setString(6, reviewBean.getPoster());
			
			insertCount = pstmt.executeUpdate();
			
		} catch (SQLException e) {
			e.printStackTrace();
			System.out.println("BoardDAO - insertReview() 에러 : " + e.getMessage());
		} finally {
			close(rs);
			close(pstmt);
		}
		
		return insertCount;
	}

	// 리뷰 수정
	public int updateReview(ReviewBean reviewBean) {
		int insertCount = 0;
		
		try {
			String sql = "UPDATE review SET content=? WHERE name=? and movieSeq=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, reviewBean.getContent());
			pstmt.setString(2, reviewBean.getName());
			pstmt.setInt(3, reviewBean.getMovieSeq());
			
			insertCount = pstmt.executeUpdate();
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(pstmt);
		}

		return insertCount;
	}

	// 리뷰 삭제
	public int deleteReview(String name, int movieSeq) {
		int insertCount = 0;
		
		try {
			String sql = "DELETE FROM review WHERE name=? AND movieSeq=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, name);
			pstmt.setInt(2, movieSeq);

			insertCount = pstmt.executeUpdate();

		} catch (SQLException e) {
			e.printStackTrace();
			System.out.println("BoardDAO - deleteReview() 에러: " + e.getMessage());
		} finally {
			close(pstmt);
		}

		return insertCount;
	}
	

	public ReviewBean getReviewDetail(int idx, int movieSeq) {
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


	public int selectLike(ReviewBean rb) {
		int selectCount = 0;
		
		try {
			String sql = "SELECT * FROM reviewLike WHERE name=? AND idx=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, rb.getName());
			pstmt.setInt(2, rb.getIdx());
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				
			} else {
				sql ="INSERT INTO reviewLike VALUES(?,?,now())";
				pstmt=con.prepareStatement(sql);
				pstmt.setInt(1, rb.getIdx());
				pstmt.setString(2, rb.getName());
				
				selectCount=pstmt.executeUpdate();
			}
			
		} catch (SQLException e) {
			System.out.println("BoardDao - selectLike() 에러: " + e.getMessage());
			e.printStackTrace();
		}finally {
			close(rs);
			close(pstmt);
		}
		
		return selectCount;
	}

	public int reviewLike(ReviewBean rb) {
		int insertCount = 0;
		
		try {
			String sql = "UPDATE review SET like_count=like_count+1 WHERE idx=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, rb.getIdx());
			insertCount = pstmt.executeUpdate();
			
		} catch (SQLException e) {
			System.out.println("BoardDao - selectLike() 에러: " + e.getMessage());
			e.printStackTrace();
		}finally {
			close(pstmt);
		}
		
		return insertCount;
	}
	
	
	public int deleteLike(ReviewBean rb) {
		int selectCount = 0;
		
		try {
			String sql = "SELECT * FROM reviewLike WHERE name=? AND idx=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, rb.getName());
			pstmt.setInt(2, rb.getIdx());
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				System.out.println("2");
				sql ="DELETE FROM reviewLike WHERE idx=? AND name=?";
				pstmt=con.prepareStatement(sql);
				pstmt.setInt(1, rb.getIdx());
				pstmt.setString(2, rb.getName());
				
				selectCount=pstmt.executeUpdate();
				
			}
			
		} catch (SQLException e) {
			System.out.println("BoardDao - selectLike() 에러: " + e.getMessage());
			e.printStackTrace();
		}finally {
			close(rs);
			close(pstmt);
		}
			
		return selectCount;
	}
		
	
	public int likeCancel(ReviewBean rb) {
		int insertCount = 0;
		
		try {
			String sql = "UPDATE review SET like_count=like_count-1 WHERE idx=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, rb.getIdx());
			insertCount = pstmt.executeUpdate();
			
		} catch (SQLException e) {
			System.out.println("BoardDao - likeCancel() 에러: " + e.getMessage());
			e.printStackTrace();
		}finally {
			close(pstmt);
		}
		
		return insertCount;
	}

	// 디테일에 리뷰 3개 가져오기
	public ArrayList<ReviewBean> getReview(int movieSeq, String title) {
		ArrayList<ReviewBean> reviewList = null;
		
		try {
			String sql = "SELECT * FROM review WHERE movieSeq=? ORDER BY like_count DESC LIMIT 3 ";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, movieSeq);
			rs = pstmt.executeQuery();
			
			reviewList = new ArrayList<ReviewBean>();
			
			while(rs.next()) {
				ReviewBean review = new ReviewBean();
				review.setIdx(rs.getInt("idx"));
				review.setName(rs.getString("name"));
				review.setGrade(rs.getInt("grade"));
				review.setMovieSeq(rs.getInt("movieSeq"));
				review.setTitle(rs.getString("title"));
				review.setContent(rs.getString("content"));
				review.setLike_count(rs.getInt("like_count"));
				review.setDate(rs.getDate("date"));
				
				reviewList.add(review);
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
			System.out.println("ReviewdDao - getReview 에러");
		} finally {
			close(rs);
			close(pstmt); 
		}
		
		return reviewList;
	}

	// 내가 평가한 영화 가져오기
	public ArrayList<ReviewBean> getReview(String name) {
		ArrayList<ReviewBean> reviewList = null;
		
		try {
			String sql = "SELECT * FROM review WHERE name=? ORDER BY idx DESC";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, name);
			rs = pstmt.executeQuery();
			
			reviewList = new ArrayList<ReviewBean>();
			
			while(rs.next()) {
				ReviewBean review = new ReviewBean();
				review.setIdx(rs.getInt("idx"));
				review.setName(rs.getString("name"));
				review.setGrade(rs.getInt("grade"));
				review.setMovieSeq(rs.getInt("movieSeq"));
				review.setTitle(rs.getString("title"));
				review.setContent(rs.getString("content"));
				review.setPoster(rs.getString("poster"));
				review.setLike_count(rs.getInt("like_count"));
				review.setDate(rs.getDate("date"));
				reviewList.add(review);
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
			System.out.println("ReviewdDao - getReview 에러");
		} finally {
			close(rs);
			close(pstmt);
		}
		
		return reviewList;
	}

	
	
	
	
	
	
}
