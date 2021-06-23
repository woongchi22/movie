package member.svc;

import java.sql.Connection;
import static db.JdbcUtil.*;


import member.dao.MemberDao;
import member.vo.MemberBeen;

public class MemberLoginProService {

	public int login(MemberBeen mb) {
		System.out.println("MemberLoginProService");
		
		Connection con = getConnection();
		
		MemberDao dao = MemberDao.getInstance();
		dao.setConnection(con);
		
		int emailCheck = dao.login(mb);
		
		close(con);
		
		return emailCheck;
	}

}
