package movie.svc;

import static db.JdbcUtil.close;
import static db.JdbcUtil.commit;
import static db.JdbcUtil.getConnection;
import static db.JdbcUtil.rollback;

import java.sql.*;

import movie.dao.*;

public class AverageStarService {

	public float averageStar(int movieSeq) {
		System.out.println("AverageStarService!!!");
		
		float avgGrade = 0.0f;
		
		Connection con = getConnection();
		MovieDao dao = MovieDao.getInstance();
		dao.setConnection(con);
		
		avgGrade = dao.averageStar(movieSeq);
		
		if(avgGrade > 0) {
			commit(con);
		}else {
			rollback(con);
			
		}
		close(con);
		
		return avgGrade;
		
	}

}
