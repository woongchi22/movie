package member.svc;

import static db.JdbcUtil.close;
import static db.JdbcUtil.getConnection;

import java.sql.*;

import member.dao.*;
import member.vo.*;

public class ForgetPassProService {

	public String find(MemberBean mb) throws Exception {
		System.out.println("ForgetPassProService!!");
		
		Connection con = getConnection();
		
		MemberDao dao = MemberDao.getInstance();
		dao.setConnection(con);
		
		String name = dao.find(mb);
		
		close(con);
		
		return name;
	}

}
