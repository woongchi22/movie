package mypage.dao;

import static db.JdbcUtil.close;

import java.sql.*;
import mypage.dao.*;

public class MypageDao {
	private MypageDao() {};

	private static MypageDao instance;
	
	public static MypageDao getInstance() {
		if(instance == null) {
			instance = new MypageDao();
		}
		return instance;
	}
	
	Connection con;
	
	public void setConnection(Connection con) {
		this.con = con;
	}
	
	PreparedStatement pstmt;
	ResultSet rs;
	
	
	
	
	
	
	
	
}

