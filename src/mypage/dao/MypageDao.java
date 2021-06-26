package mypage.dao;

import static db.JdbcUtil.close;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.servlet.http.HttpSession;

import member.vo.MemberBean;
import mypage.dao.*;

public class MypageDao {
	
	private static MypageDao instance;
	private MypageDao() {};
	
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
//	
//	PreparedStatement pstmt = null;
//	ResultSet rs = null;
	
	// 내 정보 조회
//	//유저 정보
//		public MemberBean getUserInfo(String name){
//			System.out.println("dao - getUserInfo~~~~");
//			System.out.println("@@@@@"+name+"@@@@@@@");
//			
//			
//			PreparedStatement pstmt = null;
//			ResultSet rs = null;
//			
//			MemberBean mb = new MemberBean();
//			try {
//				String sql = "SELECT * FROM member where name=?";
//				
//				pstmt = con.prepareStatement(sql);
//				pstmt.setString(1, name);
//				rs = pstmt.executeQuery();
//				
//				if(rs.next()) {
//					System.out.println(rs.getString("email"));
//					System.out.println(rs.getString("name"));
//					
//					mb.setIdx(rs.getInt("idx"));
//					mb.setEmail(rs.getString("email"));
//					mb.setName(rs.getString("name"));
//					mb.setPass(rs.getString("pass"));
//					mb.setDate(rs.getDate("date"));
//					System.out.println(mb.getEmail());
//				}
//			} catch (SQLException e) {
//				e.printStackTrace();
//				System.out.println("회원정보 가져오기 실패");
//			}finally {
//				close(rs);
//				close(pstmt);
//			}
//			
//			return mb ;
//		}
	public MemberBean getUserInfo(String name) {
		System.out.println("MypageDAO - getMypageInfo 도착");
		System.out.println(name);

		MemberBean mb = new MemberBean();
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			String sql = "SELECT * FROM member where name=?";

			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, name);
			rs = pstmt.executeQuery();

			if (rs.next()) {
				mb = new MemberBean();
				mb.setIdx(rs.getInt("idx"));
				mb.setEmail(rs.getString("email"));
				mb.setName(rs.getString("name"));
				mb.setPass(rs.getString("pass"));
				mb.setDate(rs.getDate("date"));
				System.out.println(mb.getEmail());
			}

		} catch (SQLException e) {
			System.out.println("MemberDAO - getMypageInfo() 에러! " + e.getMessage());
		} finally {
			close(rs);
			close(pstmt);
		}

		return mb;

	}

	
	
	
	
	
}

