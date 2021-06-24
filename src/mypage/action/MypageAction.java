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
		HttpSession session = request.getSession();
		String name = (String) request.getAttribute("name");
		
		MemberBean mb = new MemberBean();
		String resultMsg = "";
		
		
		MypageService mypageService = new MypageService();
		try {
			mb = mypageService.userInfo(name,session);
			
		} catch (Exception e) {
			resultMsg = e.getMessage();
		}
		ActionForward forward = null;
		
//		request.setAttribute("mb", mb);
		request.setAttribute("mb", mb);
		
		
	
		session.setAttribute("name", name);
		session.setAttribute("email", email);
		
		forward = new ActionForward();
		forward.setPath("/mypage/mypage.jsp");
		
		
		
		return forward;
	}

}
