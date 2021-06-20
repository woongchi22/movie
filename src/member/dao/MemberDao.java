package member.dao;

import java.sql.*;

import member.vo.MemberBeen;

public class MemberDao {
	private MemberDao() {};
	
	private static MemberDao instance;

	public static MemberDao getInstance() {
		if(instance == null) {
			instance = new MemberDao();
		}
		return instance;
	}

	Connection con;
	
	public void setConnection(Connection con) {
		this.con = con;
	}
	
	PreparedStatement pstmt;
	ResultSet rs;

	
	
	
	//로그인
	
	public String login(MemberBeen mb) {
		System.out.println("MemberDao - login");
		String name = "";
		
		try {
			
			String sql = "SELECT pass,name FROM member WHERE email = ? ";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, mb.getEmail());
			rs = pstmt.executeQuery();

			if(rs.next()) {
				System.out.println("rs.next()");
					if(mb.getPass().equals(rs.getString("pass"))) {
						System.out.println("로그인가능");
						name = rs.getString("name");
				}else {//패스워드 불일치
					System.out.println("패스워드 불일치");
					
				}
			}else {
				System.out.println("없는 아이디입니다");

			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return name;
	}
	
	
}
