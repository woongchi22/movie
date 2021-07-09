package movie.svc;

import static db.JdbcUtil.close;
import static db.JdbcUtil.getConnection;

import java.sql.*;

import movie.dao.*;
import movie.vo.*;

public class StarService {

	public MovieBean selectStar(String name, int movieSeq, int grade) {
		System.out.println("StarService!");
		
		MovieBean mb = null;
		
		Connection con = getConnection();
		MovieDao dao = MovieDao.getInstance();
		dao.setConnection(con);
		
		mb = dao.selecStar(name, movieSeq, grade);
		
		close(con);		
		
		return mb;
	}

}
