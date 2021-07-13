package board.svc;

import java.sql.*;
import java.util.ArrayList;

import board.dao.BoardDao;
import board.vo.ReviewBean;

import static db.JdbcUtil.*;
public class BoardReviewListService {

	public ArrayList<ReviewBean> getReview(int movieSeq) {
		
		System.out.println("BoardReviewListService");
		ArrayList<ReviewBean> reviewList = null;

		
		Connection con = getConnection();
		BoardDao bdao = BoardDao.getInstance();
		bdao.setConnection(con);
		
		reviewList = bdao.getReview(movieSeq);
		return reviewList;
	}

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

	public ReviewBean getReview(int idx, int movieSeq) {
		System.out.println("BoardReviewListService - getReview");
		
		Connection con = getConnection();
		BoardDao bdao = BoardDao.getInstance();
		bdao.setConnection(con);
		
		ReviewBean reviewBean = bdao.getReviewDetail(idx, movieSeq);
		
		close(con);
		
		return reviewBean;
		
	}

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

	public boolean deleteReview(int idx) {
		System.out.println("BoardReviewService - deleteReview()");
		boolean isSuccess =false;
		
		Connection con = getConnection();
		BoardDao bdao = BoardDao.getInstance();
		bdao.setConnection(con);
		int insertCount = bdao.deleteReview(idx);
		
		if(insertCount>0) {
			isSuccess = true;
			commit(con);
		}else {
			rollback(con);
		}
		close(con);
		
		return isSuccess;
	}

}
