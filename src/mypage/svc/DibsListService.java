package mypage.svc;

import static db.JdbcUtil.close;
import static db.JdbcUtil.commit;
import static db.JdbcUtil.getConnection;
import static db.JdbcUtil.rollback;

import java.sql.*;
import java.util.*;

import mypage.dao.*;
import mypage.vo.*;

public class DibsListService {

	// 찜꽁 리스트
	public ArrayList<DibsBean> getDibsList(String name) {
		ArrayList<DibsBean> dbList = null;
		
		Connection con = getConnection();
		MypageDao dao = MypageDao.getInstance();
		dao.setConnection(con);
		
		dbList = dao.selectDibsList(name);
		
		close(con);
		
		return dbList;
	}

	// admin 전용
	public ArrayList<DibsBean> getDibsList() {
		ArrayList<DibsBean> dbList = null;
		
		Connection con = getConnection();
		MypageDao dao = MypageDao.getInstance();
		dao.setConnection(con);
		
		dbList = dao.selectDibsList();
		
		close(con);
		
		return dbList;
		
	}


}
