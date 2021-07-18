package board.svc;

import java.sql.*;
import java.util.ArrayList;

import board.dao.BoardDao;
import board.vo.ReviewBean;

import static db.JdbcUtil.*;

public class BoardReviewListService {

	// 리뷰 List
	public ArrayList<ReviewBean> getReview(int movieSeq) {
		
		System.out.println("BoardReviewListService");
		ArrayList<ReviewBean> reviewList = null;

		Connection con = getConnection();
		BoardDao bdao = BoardDao.getInstance();
		bdao.setConnection(con);
		
		reviewList = bdao.getReview(movieSeq);
		return reviewList;
	}

	// 리뷰 등록
	public boolean reviewWrite(ReviewBean reviewBean) {
		System.out.println("BoardReviewListService-reviewWrite");
		Connection con = getConnection();
		BoardDao bdao = BoardDao.getInstance();
		bdao.setConnection(con);
		boolean isWriteSuccess = false;
		System.out.println(reviewBean.getContent());
		
		int insertCount = bdao.reviewWrite(reviewBean);
		
		if(insertCount>0) {
			commit(con);
			isWriteSuccess = true;
		}else {
			rollback(con);
		}
		
		return isWriteSuccess;
	}

	// 리뷰 수정
	public boolean isUpdate(ReviewBean reviewBean) {
		System.out.println("BoardReviewListService - isUpdate");
		boolean isUpdate =false;
		
		Connection con = getConnection();
		BoardDao bdao = BoardDao.getInstance();
		bdao.setConnection(con);
		int insertCount = bdao.updateReview(reviewBean);
		
		if(insertCount>0) {
			isUpdate = true;
			commit(con);
		}else {
			rollback(con);
		}
		close(con);
		
		return isUpdate;
	}

	// 리뷰 삭제
	public boolean deleteReview(String name, int movieSeq) {
		System.out.println("BoardReviewService - deleteReview()");
		boolean isSuccess =false;
		
		Connection con = getConnection();
		BoardDao bdao = BoardDao.getInstance();
		bdao.setConnection(con);
		
		int insertCount = bdao.deleteReview(name, movieSeq);
		
		if(insertCount>0) {
			isSuccess = true;
			commit(con);
		}else {
			rollback(con);
		}
		close(con);
		
		return isSuccess;
	}

	// 디테일 pro에서 보냄
	public String getReview(ReviewBean rb) {
		System.out.println("BoardReviewListService - getReview()");
		
		Connection con = getConnection();
		BoardDao bdao = BoardDao.getInstance();
		bdao.setConnection(con);
		
		String comment = bdao.getReviewDetail(rb);
		
		close(con);
		
		return comment;
	}

	public boolean insertLike(ReviewBean rb) {
		System.out.println("BoardReviewListService - insertLike()");
		
		boolean isSuccess =false;
		
		Connection con = getConnection();
		BoardDao bdao = BoardDao.getInstance();
		bdao.setConnection(con);
		
		int insertCount = bdao.selectLike(rb);
		
		if(insertCount>0) {
			isSuccess = true;
			commit(con);
		}else {
			rollback(con);
		}
		close(con);
		
		return isSuccess;
	}

	public boolean reviewLike(ReviewBean rb) {
		System.out.println("BoardReviewListService - reviewLike()");
		
		boolean isSuccess =false;
		
		Connection con = getConnection();
		BoardDao bdao = BoardDao.getInstance();
		bdao.setConnection(con);
		
		int insertCount = bdao.reviewLike(rb);
		
		if(insertCount>0) {
			isSuccess = true;
			commit(con);
		}else {
			rollback(con);
		}
		close(con);
		
		return isSuccess;
	}

	public boolean likeCancel(ReviewBean rb) {
		System.out.println("BoardReviewListService - likeCancel()");
		
		boolean isSuccess =false;
		
		Connection con = getConnection();
		BoardDao bdao = BoardDao.getInstance();
		bdao.setConnection(con);
		
		int insertCount = bdao.likeCancel(rb);
		
		if(insertCount>0) {
			isSuccess = true;
			commit(con);
		}else {
			rollback(con);
		}
		close(con);
		
		return isSuccess;
	}

	public boolean deleteLike(ReviewBean rb) {
		System.out.println("BoardReviewListService - deleteLikes()");
		
		boolean isSuccess =false;
		
		Connection con = getConnection();
		BoardDao bdao = BoardDao.getInstance();
		bdao.setConnection(con);
		
		int insertCount = bdao.deleteLike(rb);
		
		if(insertCount>0) {
			isSuccess = true;
			commit(con);
		}else {
			rollback(con);
		}
		close(con);
		
		return isSuccess;
	}
	
//	public ReviewBean getReview(int idx, int movieSeq) {
//		System.out.println("BoardReviewListService - getReview");
//		
//		Connection con = getConnection();
//		BoardDao bdao = BoardDao.getInstance();
//		bdao.setConnection(con);
//		
//		ReviewBean reviewBean = bdao.getReviewDetail(idx, movieSeq);
//		
//		close(con);
//		
//		return reviewBean;
//		
//	}



}
