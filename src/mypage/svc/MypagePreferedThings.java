package mypage.svc;

import static db.JdbcUtil.*;

import java.sql.*;
import java.util.*;

import mypage.dao.*;
import mypage.vo.*;

public class MypagePreferedThings {

	
	public ArrayList<MypageGenreBean> getMypageGenre(String name){
		Connection con = getConnection();
		MypageDao mdao = MypageDao.getInstance();
		mdao.setConnection(con);
		ArrayList<MypageGenreBean> list = mdao.selectGenre(name);
		close(con);
		return list;
	}
}
