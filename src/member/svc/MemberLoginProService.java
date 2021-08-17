package member.svc;

import java.sql.Connection;
import static db.JdbcUtil.*;


import member.dao.MemberDao;
import member.vo.MemberBean;

public class MemberLoginProService {

	public String login(MemberBean mb) throws Exception {
		
		Connection con = getConnection();
		MemberDao dao = MemberDao.getInstance();
		dao.setConnection(con);
		
		String name = dao.login(mb);
		
		close(con);
		
		return name;
	}

}
