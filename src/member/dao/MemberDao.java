package member.dao;

import static db.JdbcUtil.close;

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

	
	// 회원가입
	
	public int insertMember(MemberBeen mb) {
		System.out.println("dao - insertMember");

		int insertCount = 0;
		
		try {
			String sql = "SELECT MAX(idx) FROM member";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			int maxNum = 0;
			if(rs.next()) {
				maxNum = rs.getInt(1) + 1;
			}
			
			sql = "INSERT INTO member VALUES(?,?,?,?,now())"; 
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, maxNum);
			pstmt.setString(2, mb.getEmail());
			pstmt.setString(3, mb.getName());
			pstmt.setString(4, mb.getPass());
			
			insertCount = pstmt.executeUpdate();
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(pstmt);
		}
		
		return insertCount;
	}
	
	
	
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
			e.printStackTrace();
		} finally {
			close(rs);
			close(pstmt);
		}
		
		return name;
	}




	
	
}
