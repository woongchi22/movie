package board.svc;

import static db.JdbcUtil.*;

import java.sql.Connection;
import java.util.ArrayList;

import board.dao.BoardDao;
import board.vo.*;

public class BoardReviewService {

	public ArrayList<ReviewBean> getReview(ReviewBean rb) {
		System.out.println("BoardReviewService");
		Connection con = getConnection();
		BoardDao bdao = BoardDao.getInstance();
		bdao.setConnection(con);
		
		ArrayList<ReviewBean> reviewList = bdao.getReview(rb);
		
		close(con);
		
		return reviewList;
	}

}
