package mypage.action;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import action.Action;
import member.vo.MemberBean;
import mypage.svc.MypageService;
import vo.ActionForward;

public class MypageProAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("mypageProAction~~~");
		
		return null;
	}

}
