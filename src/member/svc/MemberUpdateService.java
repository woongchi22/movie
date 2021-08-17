package member.svc;

import static db.JdbcUtil.*;
import java.sql.Connection;
import member.dao.MemberDao;
import member.vo.MemberBean;

public class MemberUpdateService {

	public boolean memberUpdate(MemberBean mb) {
		boolean checkResult =false;
		
		Connection con = getConnection();
		MemberDao dao = MemberDao.getInstance();
		dao.setConnection(con);
		
		int update = dao.updateMember(mb);
		
		if(update>0) {
			checkResult = true;
			commit(con);
		}else {
			rollback(con);
		}
		close(con);
		
		return checkResult;
	}

}
