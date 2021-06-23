package member.svc;

import java.sql.Connection;
import static db.JdbcUtil.*;


import member.dao.MemberDao;
import member.vo.MemberBeen;

public class MemberLoginProService {

	public String login(MemberBeen mb) throws Exception {
		System.out.println("MemberLoginProService");
		
		Connection con = getConnection();
		
		MemberDao dao = MemberDao.getInstance();
		dao.setConnection(con);
		
		String name = dao.login(mb);
		
		close(con);
		
		return name;
	}

}
