package member.svc;

import static db.JdbcUtil.*;
import java.sql.*;
import java.util.*;

import member.dao.*;
import member.vo.*;

public class MemberListService {

	public ArrayList<MemberBeen> getMemberList() {
		ArrayList<MemberBeen> mbList = null;
		
		Connection con = getConnection();
		MemberDao dao = MemberDao.getInstance();
		dao.setConnection(con);
		
		mbList = dao.selectMemberList();
		
		close(con);
				
		return mbList;
	}

	public ArrayList<MemberBeen> getMemberList(String orderTarget, String orderType) {
		ArrayList<MemberBeen> mbList = null;

		Connection con = getConnection();
		MemberDao dao = MemberDao.getInstance();
		dao.setConnection(con);
		
		mbList = dao.selectMemberList(orderTarget, orderType);
		
		close(con);
		
		return mbList;
	}

}
