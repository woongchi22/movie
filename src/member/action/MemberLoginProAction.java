package member.action;

import java.io.PrintWriter;

import javax.servlet.http.*;

import action.Action;
import member.svc.MemberLoginProService;
import member.vo.MemberBean;
import vo.ActionForward;

public class MemberLoginProAction implements Action {

	@Override
	public ActionForward excute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("MemberLoginProAction");
		
		ActionForward forward = null;
		
		MemberBean mb = new MemberBean();
		mb.setEmail(request.getParameter("email"));
		mb.setPass(request.getParameter("pass"));
		
//		int emailCheck = 0;
		boolean isLogin = false;
		String result = "";
		String name = "";
		
		MemberLoginProService memberLoginProService = new MemberLoginProService();
//		emailCheck = memberLoginProService.login(mb);
		try {
			name = memberLoginProService.login(mb);
			isLogin = true;
		} catch (Exception e) {
			result = e.getMessage();
		}
		
		if(!isLogin) {
			
		
//		if(emailCheck == 0 || emailCheck == -1) {
//			
//			if(emailCheck == 0) {
//				result = "아이디가 틀렸습니다";
//			} else if(emailCheck == -1) {
//				result = "패스워드가 틀렸습니다";
//			}
			
			response.setContentType("text/html;charset=UTF-8");
			PrintWriter out = response.getWriter(); 
			out.println("<script>");
			out.println("alert('" + result + "')");
			out.println("history.back()");
			out.println("</script>");
			
		} else {
			
			HttpSession session = request.getSession();
//			session.setAttribute("email", mb.getEmail());
			session.setAttribute("name", name);
//			request.setAttribute("name", mb.getName());
			
			forward = new ActionForward();
			forward.setRedirect(true);
			forward.setPath("./");
			
		}
		
		return forward;
	}

}
