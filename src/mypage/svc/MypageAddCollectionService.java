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

	public boolean updateCollection(CollectionBean collectionBean) {
		System.out.println("MypageAddCollectionService@@@@@@@@@@");
		boolean isSuccess = false;
		Connection con = getConnection();
		MypageDao mdao = MypageDao.getInstance();
		mdao.setConnection(con);
		System.out.println(collectionBean.getMovieSeq());
		int isUpdate = mdao.updateCollection(collectionBean);
		if(isUpdate>0) {
			isSuccess = true;
			commit(con);
		}else {
			rollback(con);
		}
		close(con);
		
		return isSuccess;
	}

	public boolean deleteCollection(String collection_name) {
		System.out.println("MypageAddCollectionService-deleteCollection");
		boolean isSuccess = false;
		Connection con = getConnection();
		MypageDao mdao = MypageDao.getInstance();
		mdao.setConnection(con);
		int isUpdate = mdao.deleteCollection(collection_name);
		if(isUpdate>0) {
			isSuccess = true;
			commit(con);
		}else {
			rollback(con);
		}
		close(con);
		
		return isSuccess;
	}

}
