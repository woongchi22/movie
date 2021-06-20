package member.dao;

import java.sql.*;
import static db.JdbcUtil.*;
import com.sun.xml.internal.ws.*;
import member.vo.*;

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
	
	
	

}
