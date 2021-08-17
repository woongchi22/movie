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

	public boolean changPass(MemberBean mb) {
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
