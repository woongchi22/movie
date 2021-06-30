package movie.svc;

import static db.JdbcUtil.close;
import static db.JdbcUtil.commit;
import static db.JdbcUtil.getConnection;
import static db.JdbcUtil.rollback;

import java.sql.*;

import member.dao.*;
import movie.dao.*;

public class MovieSearchProService {

	public void searchMovie() {
		
		
		
		Connection con = getConnection();
		
		MovieDao movieDao = MovieDao.getInstance();
		movieDao.setConnection(con);
		
		int insertCount = movieDao.movieSearch();
		
		if(insertCount > 0) {
			commit(con);
			
		}else {
			rollback(con);
			
		}
		close(con);
		
	}

}
