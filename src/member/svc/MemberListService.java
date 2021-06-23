package member.svc;

import static db.JdbcUtil.*;
import java.sql.*;
import java.util.*;

import member.dao.*;
import member.vo.*;

public class MemberListService {

	public ArrayList<MemberBean> getMemberList() {
		ArrayList<MemberBean> mbList = null;
		
		Connection con = getConnection();
		MemberDao dao = MemberDao.getInstance();
		dao.setConnection(con);
		
		mbList = dao.selectMemberList();
		
		close(con);
				
		return mbList;
	}

	public ArrayList<MemberBean> getMemberList(String orderTarget, String orderType) {
		ArrayList<MemberBean> mbList = null;

		Connection con = getConnection();
		MemberDao dao = MemberDao.getInstance();
		dao.setConnection(con);
		
		mbList = dao.selectMemberList(orderTarget, orderType);
		
		close(con);
		
		return mbList;
	}

}
