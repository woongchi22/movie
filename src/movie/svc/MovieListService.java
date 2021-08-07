package movie.svc;

import static db.JdbcUtil.getConnection;

import java.sql.*;
import java.util.*;

import movie.dao.*;
import movie.vo.*;

public class MovieListService {

	// 평가한 영화 가져오기
	public ArrayList<MovieBean> getMovie(String name) {
		System.out.println("MovieListService - getMovie");
		ArrayList<MovieBean> movieList = null;

		Connection con = getConnection();
		MovieDao mdao = MovieDao.getInstance();
		mdao.setConnection(con);
		
		movieList = mdao.getMovie(name);
		
		return movieList;
	}

}
