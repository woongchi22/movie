package member.dao;

import static db.JdbcUtil.close;

import java.sql.*;
import java.util.*;

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


	
	//이메일 중복 체크
	public boolean dupCheck(String params, String type) {
		boolean checkResult = true;
		System.out.println(params);
		System.out.println(type);
		
		try {
			String sql = "SELECT " + type + " FROM member where " + type + "=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, params);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				checkResult = false;
			}
		} catch (SQLException e) {
			e.printStackTrace();
			System.out.println("MemberDAO - dupCheck() 오류!");

		}finally{
			close(rs);
			close(pstmt);
		}
		
		return checkResult;
	}

	
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
	public int login(MemberBeen mb) {
		System.out.println("MemberDao - login");
		int emailCheck = 0;
		
		try {
			
			String sql = "SELECT pass,name FROM member WHERE email = ? ";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, mb.getEmail());
			rs = pstmt.executeQuery();

			if(rs.next()) {
				
				if(mb.getPass().equals(rs.getString("pass"))) {
					System.out.println("로그인 가능");
					emailCheck = 1;
					
		 		}else {//패스워드 불일치
		 			System.out.println("패스워드 불일치");
		 			emailCheck = -1;
				}
			}else {
				System.out.println("없는 아이디입니다");
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
			System.out.println("dao - login() 오류");
		} finally {
			close(rs);
			close(pstmt);
		}
		
		return emailCheck;
	}


	// 관리자 회원 리스트
	public ArrayList<MemberBeen> selectMemberList() {
		System.out.println("dao - selectMemberList()");
		
		ArrayList<MemberBeen> mbList = null;
		
		try {
			String sql = "SELECT * FROM member";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			mbList = new ArrayList<MemberBeen>();
			while(rs.next()) {
				MemberBeen mb = new MemberBeen();
				mb.setIdx(rs.getInt("idx"));
				mb.setEmail(rs.getString("email"));
				mb.setName(rs.getString("name"));
				mb.setPass(rs.getString("pass"));
				mb.setDate(rs.getDate("date"));
				
				mbList.add(mb);
				
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(rs);
			close(pstmt);
		}
		
		return mbList;
	}

	// 파라미터 있을 경우
	public ArrayList<MemberBeen> selectMemberList(String orderTarget, String orderType) {
		System.out.println("dao - selectMemberList(파라미터)");
		
		ArrayList<MemberBeen> mbList = null;
		
		try {
			String sql = "SELECT * FROM member ORDER BY" + orderTarget + " " + orderType;
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			mbList = new ArrayList<MemberBeen>();
			while(rs.next()) {
				System.out.println(rs.getInt("idx"));
				MemberBeen mb = new MemberBeen();
				mb.setIdx(rs.getInt("idx"));
				mb.setEmail(rs.getString("email"));
				mb.setName(rs.getString("name"));
				mb.setPass(rs.getString("pass"));
				mb.setDate(rs.getDate("date"));
				
				mbList.add(mb);
				
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(rs);
			close(pstmt);
		}
		
		return mbList;
	}
	
	
	
	

	
}


