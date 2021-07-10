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

	public boolean ReviewWrite(ReviewBean reviewBean) {
		
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

}
