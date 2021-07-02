package movie.svc;

import java.sql.Connection;
import java.util.ArrayList;


import static db.JdbcUtil.*;

import movie.dao.MovieDao;
import movie.vo.MovieBean;
import mypage.action.Mypage;

public class MovieGetService {

//	public ArrayList<MovieBean> getMovie(String nick, Mypage type) {
//		Connection con = getConnection();
//		MovieDao md = MovieDao.getInstance();
//		md.setConnection(con);
//		ArrayList<MovieBean> list = md.getMovie(nick,type);
//		
//		close(con);
//		
//		return list;
//	}

	public ArrayList<MovieBean> getMovie() {
		Connection con = getConnection();
		MovieDao md = MovieDao.getInstance();
		md.setConnection(con);
		ArrayList<MovieBean> list = md.getMovieByChart();
		
		close(con);
		return list;
	}
}
