package board.svc;

import static db.JdbcUtil.close;
import static db.JdbcUtil.commit;
import static db.JdbcUtil.getConnection;
import static db.JdbcUtil.rollback;

import java.sql.Connection;

import board.dao.BoardDao;
import board.vo.ReviewBean;

public class BoardReviewWriteService {

	public boolean reviewWrite(ReviewBean reviewBean) {
		System.out.println("BoardReviewWriteService");
		
		boolean isWrite = false;
		
		Connection con = getConnection();
		BoardDao bdao = BoardDao.getInstance();
		bdao.setConnection(con);
		
		int insertCount = bdao.reviewWrite(reviewBean);
		
		if(insertCount > 0) {
			commit(con);
		} else {
			rollback(con);
		}
		close(con);
		
		return isWrite; 
		
	}

}
