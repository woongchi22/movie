package member.svc;

import static db.JdbcUtil.close;
import static db.JdbcUtil.getConnection;

import java.sql.*;

import member.dao.*;
import member.vo.*;

public class ForgetPassProService {

	public int find(MemberBean mb) throws Exception {
		System.out.println("ForgetPassProService!!");
		
		int findResult = 0;
		
		Connection con = getConnection();
		
		MemberDao dao = MemberDao.getInstance();
		dao.setConnection(con);
		
		findResult = dao.find(mb);
		
		close(con);
		
		return findResult;
	}

}
