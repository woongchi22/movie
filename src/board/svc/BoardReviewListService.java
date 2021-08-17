package board.svc;

import java.sql.*;
import java.util.ArrayList;

import board.dao.BoardDao;
import board.vo.ReviewBean;
import static db.JdbcUtil.*;

public class BoardReviewListService {

	// 리뷰 List
	public ArrayList<ReviewBean> getReview(int movieSeq) {
		ArrayList<ReviewBean> reviewList = null;

		Connection con = getConnection();
		BoardDao bdao = BoardDao.getInstance();
		bdao.setConnection(con);
		
		reviewList = bdao.getReview(movieSeq);
		return reviewList;
	}

	// 리뷰 등록
	public boolean reviewWrite(ReviewBean reviewBean) {
		Connection con = getConnection();
		BoardDao bdao = BoardDao.getInstance();
		bdao.setConnection(con);
		boolean isWriteSuccess = false;
		
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
		boolean isUpdate = false;
		
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
		boolean isSuccess = false;
		
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
		Connection con = getConnection();
		BoardDao bdao = BoardDao.getInstance();
		bdao.setConnection(con);
		
		String comment = bdao.getReviewDetail(rb);
		
		close(con);
		
		return comment;
	}

	// 좋아요
	public boolean insertLike(ReviewBean rb) {
		boolean isSuccess = false;
		
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

	public ArrayList<ReviewBean> getReview(int movieSeq, String title) {
		ArrayList<ReviewBean> reviewList = null;

		Connection con = getConnection();
		BoardDao bdao = BoardDao.getInstance();
		bdao.setConnection(con);
		
		reviewList = bdao.getReview(movieSeq,title);
		return reviewList;
	}

	public ArrayList<ReviewBean> getReview(String name) {
		ArrayList<ReviewBean> reviewList = null;

		Connection con = getConnection();
		BoardDao bdao = BoardDao.getInstance();
		bdao.setConnection(con);
		
		reviewList = bdao.getReview(name);
		return reviewList;
	}




}
