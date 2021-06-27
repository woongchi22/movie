package member.dao;

import static db.JdbcUtil.close;

import java.sql.*;
import java.util.*;

import javax.servlet.http.*;

import member.exception.*;
import member.vo.MemberBean;

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
	public int insertMember(MemberBean mb) {
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
			System.out.println(insertCount);
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(pstmt);
		}
		
		return insertCount;
	}
	
	
	//로그인
	public String login(MemberBean mb) throws Exception {
		System.out.println("MemberDao - login");
		String name = "";
		
		try {
			
			String sql = "SELECT pass,name FROM member WHERE email = ? ";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, mb.getEmail());
			rs = pstmt.executeQuery();

			if(rs.next()) {
				
				if(mb.getPass().equals(rs.getString("pass"))) {
					System.out.println("로그인 가능");
					name = rs.getString("name");
					
		 		}else {//패스워드 불일치
		 			throw new MemberLoginException("패스워드가 일치하지 않습니다");
				}
			}else {
				throw new MemberLoginException("없는 이메일 입니다");
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
			System.out.println("dao - login() 오류");
		} finally {
			close(rs);
			close(pstmt);
		}
		
		return name;
	}


	// 관리자 회원 리스트
	public ArrayList<MemberBean> selectMemberList() {
		System.out.println("dao - selectMemberList()");
		
		ArrayList<MemberBean> mbList = null;
		
		try {
			String sql = "SELECT * FROM member";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			mbList = new ArrayList<MemberBean>();
			while(rs.next()) {
				MemberBean mb = new MemberBean();
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
	public ArrayList<MemberBean> selectMemberList(String orderTarget, String orderType) {
		System.out.println("dao - selectMemberList(파라미터)");
		
		ArrayList<MemberBean> mbList = null;
		
		try {
			String sql = "SELECT * FROM member ORDER BY" + orderTarget + " " + orderType;
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			mbList = new ArrayList<MemberBean>();
			while(rs.next()) {
				System.out.println(rs.getInt("idx"));
				MemberBean mb = new MemberBean();
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

	// 비밀번호 찾기
	public String find(MemberBean mb) throws Exception {
		System.out.println("dao - find()");
		
		String name = null;
		
		try {
			String sql = "SELECT pass,name FROM member WHERE email=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, mb.getEmail());
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				if(mb.getName().equals(rs.getString("name"))) {
					System.out.println("pass 찾기 가능");
					name = rs.getString("name");
					
				} else { // 이메일-이름 불일치
					throw new MemberLoginException("등록하신 이름이 아닙니다");
				}
			} else {
				throw new MemberLoginException("등록하신 이메일이 아닙니다");
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(rs);
			close(pstmt);
		}
		
		return name;
	}

	//회원 정보 수정
	public int updateMember(MemberBean mb) {
		System.out.println("dao - updateMember");
		int update=0;
		
		try {
			String sql = "SELECT * from member WHERE email=?";
			String email = mb.getEmail();
			String name = mb.getName();
			String pass = mb.getPass();
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, email);
			
			rs = pstmt.executeQuery();
			if(rs.next()) {
				sql = "UPDATE member SET name=?,pass=? WHERE email=? ";
				pstmt=con.prepareStatement(sql);
				pstmt.setString(1, name);
				pstmt.setString(2, pass);
				pstmt.setString(3, email);
				update=pstmt.executeUpdate();
				System.out.println(update);
			}
			
			
		} catch (SQLException e) {
			e.printStackTrace();
			System.out.println("dao - Update member 오류!");
		}
		
		return update;
	}

	
	// 비밀번호 변경
	public int changePass(MemberBean mb) {
		System.out.println("dao - changePass()");
		
		int changCount = 0;
		
		try {
			String sql = "UPDATE member SET pass=? WHERE name=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, mb.getPass());
			pstmt.setString(2, mb.getName());
			
			System.out.println(mb.getPass());
			System.out.println(mb.getName());
			
			changCount = pstmt.executeUpdate();
			
		} catch (SQLException e) {
			e.printStackTrace();
			System.out.println("dao - changePass 오류");
		} finally {
			close(pstmt);
		}
		
		return changCount;
	}

	
	
	
	
	
}


