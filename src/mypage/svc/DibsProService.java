package mypage.svc;

import static db.JdbcUtil.close;
import static db.JdbcUtil.commit;
import static db.JdbcUtil.getConnection;
import static db.JdbcUtil.rollback;

import java.sql.*;

import mypage.dao.*;
import mypage.vo.*;

public class DibsProService {

	public boolean dibs(DibsBean db) {
		System.out.println("DibsProService!!");
		
		boolean isInsert = false;
		
		Connection con = getConnection();
		MypageDao dao = MypageDao.getInstance();
		dao.setConnection(con);
		
		int insertCount = dao.dibs(db);
		
		if(insertCount > 0) {
			isInsert = true;
			commit(con);
			
		}else {
			rollback(con);
			
		}
		close(con);
		
		return isInsert;
		
	}

}
