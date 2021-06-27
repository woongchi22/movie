package member.svc;

import static db.JdbcUtil.close;
import static db.JdbcUtil.commit;
import static db.JdbcUtil.getConnection;
import static db.JdbcUtil.rollback;

import java.sql.*;

import javax.servlet.http.*;

import member.dao.*;
import member.vo.*;

public class NewPassProService {

//	public MemberBean getMb(int idx) {
//		System.out.println("NewPassProService!! getMb");
//		
//		Connection con = getConnection();
//		
//		MemberDao dao = MemberDao.getInstance();
//		dao.setConnection(con);
//		
//		MemberBean mb = dao.selectMb(idx);
//		
//		close(con);
//		
//		return mb;
//		
//	}
//	
	
	public boolean changPass(MemberBean mb) {
		System.out.println("NewPassProService!!");
		
		boolean isChange = false;
		
		Connection con = getConnection();
		
		MemberDao dao = MemberDao.getInstance();
		dao.setConnection(con);
		
		int changeCount = dao.changePass(mb);
		
		if(changeCount > 0) {
			commit(con);
			isChange = true;
			
		}else {
			rollback(con);
		}
		close(con);
		
		return isChange;
		
	}


}
