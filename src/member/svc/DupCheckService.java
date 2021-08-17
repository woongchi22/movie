package member.svc;

import java.sql.*;

import member.dao.MemberDao;

import static db.JdbcUtil.*;
public class DupCheckService {

	public boolean dupCheck(String email, String type) {
		boolean checkResult = false;
		
		Connection con = getConnection();
		MemberDao dao = MemberDao.getInstance();
		dao.setConnection(con);
		
		checkResult = dao.dupCheck(email,type);
		
		close(con);
		
		return checkResult;
		
	}
	
	public boolean dupName(String name, String type) {
		boolean checkResult = false;
		
		Connection con = getConnection();
		MemberDao dao = MemberDao.getInstance();
		dao.setConnection(con);
		
		checkResult = dao.dupCheck(name, type);
		
		close(con);
		
		return checkResult;
	}
}
