package mypage.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import action.Action;
import member.vo.MemberBean;
import mypage.svc.MypageService;
import vo.ActionForward;

public class MypageAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("MypageAction");	
		
		String email = (String) request.getParameter("email");
		
		MemberBean mb = new MemberBean();
		
		MypageService mypageService = new MypageService();
			mb = mypageService.userInfo(email);
			
		ActionForward forward = null;
		
		
		forward = new ActionForward();
		forward.setPath("/mypage/mypage.jsp");
		
		
		
		return forward;
	}

}
