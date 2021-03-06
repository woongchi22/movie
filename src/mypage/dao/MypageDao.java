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
//				System.out.println(mb.getEmail());
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
				sql = "INSERT INTO dibs VALUES(idx,?,?,?,?,'Y')";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, db.getName());
				pstmt.setInt(2, db.getMovieSeq());
				pstmt.setString(3, db.getTitle());
				pstmt.setString(4, db.getPoster());
				
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
		DibsBean db = null;
		
		try {
			String sql = "SELECT * FROM dibs WHERE name=? and movieSeq=? and dibs='Y'";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, name);
			pstmt.setInt(2, movieSeq);
			rs = pstmt.executeQuery();
			
			db = new DibsBean();

			if (rs.next()) {
				
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
		ArrayList<DibsBean> dbList = null;
		
		try {
			String sql = "SELECT * FROM dibs ORDER BY title, movieSeq, name";
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

	public int addCollection(CollectionBean collectionBean) {
		System.out.println("mypage dao - addCollection");
		int isSuccess = 0;
		try {
			String sql = "insert into collection values(idx,?,?,?,?,?)";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, collectionBean.getName());
			pstmt.setString(2, collectionBean.getCollection_name());
			pstmt.setString(3, collectionBean.getMovieSeq());
			pstmt.setString(4, collectionBean.getTitle());
			pstmt.setString(5, collectionBean.getPoster());
			System.out.println(collectionBean.getName());
			System.out.println(collectionBean.getCollection_name());
			System.out.println(collectionBean.getMovieSeq());
			System.out.println(collectionBean.getTitle());
			System.out.println(collectionBean.getPoster());
			
			isSuccess = pstmt.executeUpdate();
			
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(pstmt);
		}
		return isSuccess;
	}

	public ArrayList<CollectionBean> selectCollection(String name) {
		System.out.println("mypage dao - selectCollection");
		ArrayList<CollectionBean> list = new ArrayList<CollectionBean>();
		try {
			String sql = "SELECT * FROM collection where name =? ORDER BY idx DESC";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, name);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				CollectionBean cb = new CollectionBean();
				cb.setCollection_name(rs.getString("collection_name"));
				cb.setMovieSeq(rs.getString("movieSeq"));
				cb.setTitle(rs.getString("title"));
				cb.setPoster(rs.getString("poster"));
				cb.setIdx(rs.getInt("idx"));
				list.add(cb);
				System.out.println(rs.getString("movieSeq"));
			}
			
			
			
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			close(rs);
			close(pstmt);
		}
		
		
		
		
		return list;
	}

	public int updateCollection(CollectionBean collectionBean) {
		System.out.println("mypage dao - updateCollection");
		int isSuccess = 0;
		PreparedStatement pstmt = null;
		  try {
			  
			String sql = "UPDATE collection set movieSeq=?,title=?,poster=? where idx = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, collectionBean.getMovieSeq());
			pstmt.setString(2, collectionBean.getTitle());
			pstmt.setString(3, collectionBean.getPoster());
			pstmt.setInt(4, collectionBean.getIdx());
			System.out.println(collectionBean.getMovieSeq());
			isSuccess = pstmt.executeUpdate();
			
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(pstmt);
		}
		  
		  
		
		return isSuccess;
	}

	public int deleteCollection(String collection_name) {
		System.out.println("mypage dao - deleteCollection");
		int isSuccess = 0;
		
		try {
			String sql = "DELETE FROM collection WHERE collection_name = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, collection_name);
			System.out.println(collection_name);
			isSuccess = pstmt.executeUpdate();
			
			
			
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			close(pstmt);
		}
		  
		return isSuccess;
	}

	public ArrayList<CollectionBean> getCollection() {
		System.out.println("mydao - getCollection()");
		ArrayList<CollectionBean> collectionList = null;
		
		try {
			String sql = "SELECT * FROM collection";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			collectionList = new ArrayList<CollectionBean>();
			
			while(rs.next()) {
				CollectionBean collection = new CollectionBean();
				collection.setIdx(rs.getInt(1));
				collection.setName(rs.getString(2));
				collection.setCollection_name(rs.getString(3));
				collection.setMovieSeq(rs.getString(4));
				collection.setTitle(rs.getString(5));
				collection.setPoster(rs.getString(6));
				collectionList.add(collection);
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
			System.out.println("mydao- getCollection 에러");
		} finally {
			close(rs);
			close(pstmt);
		}
		
		return collectionList;
	}

	
	
	
	
	
}

