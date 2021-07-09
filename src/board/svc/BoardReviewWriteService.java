package board.svc;

import static db.JdbcUtil.*;

import java.sql.Connection;
import java.util.ArrayList;

import board.dao.BoardDao;
import board.vo.ReviewBean;

public class BoardReviewWriteService {

	public boolean reviewWrite(ReviewBean rb) {
		System.out.println("BoardReviewWriteService");
		Connection con = getConnection();
		BoardDao bdao = BoardDao.getInstance();
		bdao.setConnection(con);
		boolean isSuccess = false;
		ArrayList<ReviewBean> reviewBean = new ArrayList<ReviewBean>();
		int insertCount = bdao.reviewWrite(rb);
		
		if(insertCount > 0) {
			commit(con);
			isSuccess = true;
		} else {
			rollback(con);
		}
		
		close(con);
		
		return isSuccess;
	}

}
