package member.svc;

import static db.JdbcUtil.*;
import java.sql.Connection;
import member.dao.MemberDao;
import member.vo.MemberBean;

public class MemberUpdateService {

	public boolean memberUpdate(MemberBean mb) {
		boolean isUpdate =false;
		
		System.out.println("MemberUpdate");
		Connection con = getConnection();
		MemberDao dao = MemberDao.getInstance();
		dao.setConnection(con);
		
		int updateCount = dao.updateMember(mb);
		System.out.println("sve : " + updateCount);  //????????????????????????
		
		if(updateCount>0) {
			isUpdate = true;
			commit(con);
		}else {
			rollback(con);
		}
		close(con);
		
		return isUpdate;
	}

}
