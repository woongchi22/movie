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
	public int find(MemberBean mb) {
		System.out.println("dao - find()");
		
		int findResult = 0;
		
		try {
			String sql = "SELECT * FROM member WHERE email=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, mb.getEmail());
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				if(mb.getName().equals(rs.getString("name"))) {
//					System.out.println("pass 찾기 가능");
					findResult = 1;
//					pass = rs.getString("pass");
					
				} else { // 이메일-이름 불일치
					findResult = -1;
//					throw new MemberLoginException("등록하신 이름이 아닙니다");
				}
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(rs);
			close(pstmt);
		}
		
		return findResult;
	}

	//유저 정보
	public int updateMember(MemberBean mb) {
		int updateCount=0;
		
		try {
			String sql = "UPDATE member SET name=? pass=? WHEFE=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, mb.getName());
			pstmt.setString(2, mb.getPass());
			updateCount = pstmt.executeUpdate();
		
		} catch (SQLException e) {
			e.printStackTrace();
			System.out.println("dao - Update member 오류!");
		}
		
		return updateCount;
	}

//	//유저 정보
//	public MemberBean getUserInfo(String UserInfo){
//		System.out.println("dao - getUserInfo");
//		MemberBean mb = null;
//		System.out.println(UserInfo);
//		try {
//			String sql = "SELECT * FROM member WHERE email = ?";
//			pstmt = con.prepareStatement(sql);
//			pstmt.setString(1, UserInfo);
//			rs = pstmt.executeQuery();
//			
//			if(rs.next()) {
//				mb.setEmail(rs.getString("email"));
//				mb.setName(rs.getString("name"));
//				mb.setPass(rs.getString("pass"));
//				
//			}
//		} catch (SQLException e) {
//			System.out.println("회원정보 가져오기 실패");
//		}finally {
//			close(rs);
//			close(pstmt);
//		}
//		
//		return mb;
//	}
//	
	
	// 비밀번호 변경
	public int changePass(MemberBean mb, HttpSession session) {
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
			System.out.println(changCount);
			
		} catch (SQLException e) {
			e.printStackTrace();
			System.out.println("dao - changePass 오류");
		} finally {
			close(pstmt);
		}
		
		return changCount;
	}
	
	
	
	
}


