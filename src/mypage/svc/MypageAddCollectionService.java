package mypage.svc;

import mypage.dao.*;
import mypage.vo.*;
import static db.JdbcUtil.*;

import java.sql.*;
import java.util.*;
public class MypageAddCollectionService {

	public boolean addCollection(CollectionBean collectionBean) {
		System.out.println("MypageAddCollectionService");
		boolean isSuccess = false;
		Connection con = getConnection();
		MypageDao mdao = MypageDao.getInstance();
		mdao.setConnection(con);
		int isAdd = mdao.addCollection(collectionBean);
		if(isAdd>0) {
			isSuccess = true;
			commit(con);
		}else {
			rollback(con);
		}
		close(con);
		
		return isSuccess;
	}

	public ArrayList<CollectionBean> selectCollection(String name) {
		System.out.println("MypageAddCollectionService");
		ArrayList<CollectionBean> selectCollection = null;
		Connection con = getConnection();
		MypageDao mdao = MypageDao.getInstance();
		mdao.setConnection(con);
		
		selectCollection = mdao.selectCollection(name);
		
		close(con);
		
		return selectCollection;
		
		
	}

}
