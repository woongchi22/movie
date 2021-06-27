package mypage.svc;

import java.sql.Connection;

import javax.servlet.http.HttpSession;

import static db.JdbcUtil.*;


import member.vo.MemberBean;
import mypage.dao.MypageDao;

public class MypageService {

	public MemberBean userInfo(String email) {
		System.out.println("MypageService~~");

		MemberBean mb = new MemberBean();
		
		Connection con = getConnection();
		MypageDao dao = MypageDao.getInstance();
		dao.setConnection(con);
		
		mb = dao.getUserInfo(email);
		
		System.out.println("Service - name :  " + email);
		System.out.println("Service - dao에서 갖고 온 이메일!" + mb.getEmail());
		
		close(con);
		
		return mb;
	}

}
