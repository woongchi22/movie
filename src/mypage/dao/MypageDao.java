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
import mypage.vo.*;

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
	
	PreparedStatement pstmt;
	ResultSet rs;
	
	
	
	public MemberBean getUserInfo(String email) {
		System.out.println("MypageDAO - getMypageInfo 도착");
		System.out.println(email);

		MemberBean mb = new MemberBean();
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			String sql = "SELECT * FROM member where name=?";

			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, email);
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

	// 찜뽕 등록,삭제
	public int dibs(DibsBean db) {
		System.out.println("mypage dao - dibs()");
		
		int insertCount = 0;
		
		try {
			String sql = "SELECT * FROM dibs WHERE name=? and movieSeq=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, db.getName());
			pstmt.setInt(2, db.getMovieSeq());
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				sql = "DELETE FROM dibs WHERE name=? and movieSeq=?";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, db.getName());
				pstmt.setInt(2, db.getMovieSeq());
				
				insertCount = pstmt.executeUpdate();
				
			} else {
				sql = "INSERT INTO dibs VALUES(?,?,?,?,?,'Y')";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, db.getIdx());
				pstmt.setString(2, db.getName());
				pstmt.setInt(3, db.getMovieSeq());
				pstmt.setString(4, db.getTitle());
				pstmt.setString(5, db.getPoster());
				
				insertCount = pstmt.executeUpdate();
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(rs);
			close(pstmt);
		}
		
		return insertCount;
		 
	}

	// 찜뽕 리스트 조회
	public ArrayList<DibsBean> selectDibsList(String name) {
		System.out.println("mypage dao - selectDibsList()");
		
		ArrayList<DibsBean> dbList = null;
		
		try {
			String sql = "SELECT * FROM dibs WHERE name=? and dibs='Y'";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, name);
			rs = pstmt.executeQuery();
			
			dbList = new ArrayList<DibsBean>();
			while(rs.next()) {
				DibsBean db = new DibsBean();
				db.setIdx(rs.getInt(1));
				db.setName(rs.getString(2));
				db.setMovieSeq(rs.getInt(3));
				db.setTitle(rs.getString(4));
				db.setPoster(rs.getString(5));
				db.setDibs(rs.getString(6));
				
				dbList.add(db);
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(rs);
			close(pstmt);
		}
		
		return dbList;
	}

	// 찜뽕 조회
	public DibsBean selectDibs(String name, int movieSeq) {
		System.out.println("mypage dao - selectDibs()");
		
		DibsBean db = null;
		
		try {
			String sql = "SELECT * FROM dibs WHERE name=? and movieSeq=? and dibs='Y'";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, name);
			pstmt.setInt(2, movieSeq);
			rs = pstmt.executeQuery();
			
			db = new DibsBean();

			if (rs.next()) {
				DibsBean db2 = new DibsBean();
				db2.setDibs(rs.getString("dibs"));
				db2.setPoster(rs.getString("poster"));
				
			} else {
				return null;
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(rs);
			close(pstmt);
		}
		
		return db;
	}

	// admin 전용
	public ArrayList<DibsBean> selectDibsList() {
		System.out.println("mypage dao - admin - selectDibs()");
		
		ArrayList<DibsBean> dbList = null;
		
		try {
			String sql = "SELECT * FROM dibs ORDER BY name";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			dbList = new ArrayList<DibsBean>();

			while(rs.next()) {
				DibsBean db = new DibsBean();
				db.setIdx(rs.getInt(1));
				db.setName(rs.getString(2));
				db.setMovieSeq(rs.getInt(3));
				db.setTitle(rs.getString(4));
				db.setPoster(rs.getString(5));
				db.setDibs(rs.getString(6));
				
				dbList.add(db);
			}	
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(rs);
			close(pstmt);
		}
		
		return dbList;
	}

	
	
	
	
	
}

