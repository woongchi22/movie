package movie.dao;

import java.sql.*;

public class MovieDao {
private MovieDao() {};
	
	private static MovieDao instance;

	public static MovieDao getInstance() {
		if(instance == null) {
			instance = new MovieDao();
		}
		return instance;
	}

	Connection con;
	
	public void setConnection(Connection con) {
		this.con = con;
	}
	
	PreparedStatement pstmt;
	ResultSet rs;

	
	
	
	public int movieSearch() {
		
		
		return 0;
	}

}
