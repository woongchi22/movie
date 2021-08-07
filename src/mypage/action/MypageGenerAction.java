package mypage.action;

import java.util.*;

import javax.servlet.http.*;

import action.*;
import mypage.svc.*;
import mypage.vo.*;
import vo.*;

public class MypageGenerAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String name = request.getParameter("name");
		StringBuffer sbGener = new StringBuffer("SF/가족/공포/다큐멘터리/동성애/드라마/로맨스/로맨틱코메디/멜로드라마/뮤직/미스터리/범죄/시대극(사극)/서부/스릴러/스포츠/아동/애니메이션/액션/어드벤처/옴니버스/재난/전쟁/코메디/판타지/하이틴");
		String[] category = sbGener.toString().split("/");
		MypagePreferedThings mms = new MypagePreferedThings();
		ArrayList<MypageGenreBean> list = mms.getMypageGenre(name);
		
		GenreBean genre = new GenreBean();
		
		
		return null;
	}

}
