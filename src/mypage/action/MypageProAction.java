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
		
		HttpSession session = request.getSession();
		String email = (String) session.getAttribute("email");
		
		MemberBean mb = new MemberBean();
		String resultMsg = "";
		
		MypageService mypageService = new MypageService();
		
		try {
			mb = mypageService.userInfo(email,session);
			
		} catch (Exception e) {
			resultMsg = e.getMessage();
		}

		ActionForward forward = null;
		
		request.setAttribute("mb", mb);
		
		if (email == null) {
			response.setContentType("text/html;charset=UTF-8");
			PrintWriter out = response.getWriter();
			out.println("<script>alert('" + resultMsg + "');history.back();</script>"); 
		} else {
			request.setAttribute("mb", mb);
			forward = new ActionForward();
			forward.setPath("/mypage/mypageForm.jsp");
		
		}
		
//		DupCheckAction dupcheckAction = new DupCheckAction();
//		
//		MemberNickAction memberNickAction = new MemberNickAction();
//		memberBean = DupCheckService.DupCheck();
//		boolean isDup = DupCheckService.dupCheck(nick,"nick");
		
		
		return forward;
	}

}
