package movie.svc;

import static db.JdbcUtil.close;
import static db.JdbcUtil.commit;
import static db.JdbcUtil.getConnection;
import static db.JdbcUtil.rollback;

import java.sql.*;

import movie.dao.*;
import movie.vo.*;
import mypage.dao.*;

public class GradeStarService {

	public boolean gradeStar(MovieBean mb) {
		System.out.println("GradeStarService!");
		
		boolean isInsert = false;
		
		Connection con = getConnection();
		MovieDao dao = MovieDao.getInstance();
		dao.setConnection(con);
		
		int insertCount = dao.gradeInsert(mb);
		
		if(insertCount > 0 || insertCount == -1) {
			isInsert = true;
			commit(con);
			
		}else {
			rollback(con);
			
		}
		close(con);
		
		return isInsert;
		
	}

	public int selectStar(MovieBean mb) {
		System.out.println("GradeStarService - selectGrade()");
		
		int movieGrade = 0;
		
		Connection con = getConnection();
		MovieDao dao = MovieDao.getInstance();
		dao.setConnection(con);
		
		movieGrade = dao.selectStar(mb);
		
		if(movieGrade > 0) {
			commit(con);
		}else {
			rollback(con);
			
		}
		close(con);
		
		return movieGrade;
	}

}
