package mypage.svc;

import static db.JdbcUtil.close;
import static db.JdbcUtil.getConnection;

import java.sql.*;

import mypage.dao.*;
import mypage.vo.*;

public class DibsService {

	public DibsBean selectDibs(String name, int movieSeq) {
		System.out.println("selectDibs");
		
		DibsBean db = null;
		
		Connection con = getConnection();
		MypageDao dao = MypageDao.getInstance();
		dao.setConnection(con);
		
		db = dao.selectDibs(name, movieSeq);
		
		close(con);		
		
		return db;
	}

}
