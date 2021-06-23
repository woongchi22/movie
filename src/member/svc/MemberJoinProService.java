package member.svc;

import java.sql.*;
import static db.JdbcUtil.*;
import member.dao.*;
import member.vo.*;

public class MemberJoinProService {

	public boolean insertMember(MemberBean mb) {
		System.out.println("MemberJoinProService");
		
		boolean isInsert = false;
		
		Connection con = getConnection();
		
		MemberDao dao = MemberDao.getInstance();
		dao.setConnection(con);
		
		int insertCount = dao.insertMember(mb);
		
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
