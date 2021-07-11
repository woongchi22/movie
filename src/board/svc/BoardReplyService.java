package board.svc;


import board.dao.BoardDao;
import board.vo.ReplyBean;

import static db.JdbcUtil.*;

import java.sql.Connection;
import java.util.ArrayList;
public class BoardReplyService {

	public boolean insertReply(ReplyBean replyBean, int idx) {
		System.out.println("BoardReplyService - insertReply()");

		boolean isSuccess = false;

		Connection con = getConnection();
		BoardDao bdao = BoardDao.getInstance();
		bdao.setConnection(con);
		
		int insertCount = bdao.insertReply(replyBean, idx);
		
		if(insertCount > 0) {
			commit(con);
			isSuccess = true;
		} else {
			rollback(con);
		}
		
		close(con);
		
		return isSuccess;	
		}

	public ArrayList<ReplyBean> replyList(ReplyBean replyBean) {
		System.out.println("BoardReplyService - replyList()");
		
		Connection con = getConnection();
		BoardDao bdao = BoardDao.getInstance();
		bdao.setConnection(con);
		
		
		
		ArrayList<ReplyBean> replyList = bdao.getReplyList(replyBean);
		
		close(con);
		
		return replyList;
	}

}
