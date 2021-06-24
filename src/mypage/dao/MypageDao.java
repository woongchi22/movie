package mypage.dao;

import java.sql.*;

import member.dao.*;

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

