package movie.svc;

import static db.JdbcUtil.close;
import static db.JdbcUtil.commit;
import static db.JdbcUtil.getConnection;
import static db.JdbcUtil.rollback;

import java.sql.*;

import movie.dao.*;

public class DeleteStarService {

	public boolean deleteStar(String name, int movieSeq) {
		boolean isDelete = false;
		
		Connection con = getConnection();
		MovieDao dao = MovieDao.getInstance();
		dao.setConnection(con);
		
		int deleteCount = dao.deleteStar(name, movieSeq);
		
		if(deleteCount > 0) {
			isDelete = true;
			commit(con);
			
		}else {
			rollback(con);
			
		}
		close(con);
		
		return isDelete;
	}


}
