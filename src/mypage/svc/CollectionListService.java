package mypage.svc;

import static db.JdbcUtil.getConnection;

import java.sql.*;
import java.util.*;

import mypage.dao.*;
import mypage.vo.*;

public class CollectionListService {

	public ArrayList<CollectionBean> getCollection() {
		System.out.println("CollectionListService");
		ArrayList<CollectionBean> collectionList = null;
		
		Connection con = getConnection();
		MypageDao mydao = MypageDao.getInstance();
		mydao.setConnection(con);
		
		collectionList = mydao.getCollection();
		
		return collectionList;
	}

}
