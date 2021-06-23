package member.action;

import java.io.PrintWriter;

import javax.servlet.http.*;

import action.Action;
import member.svc.MemberLoginProService;
import member.vo.MemberBeen;
import vo.ActionForward;

public class MemberLoginProAction implements Action {

	@Override
	public ActionForward excute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("MemberLoginProAction");
		
		ActionForward forward = null;
		
		MemberBeen mb = new MemberBeen();
		mb.setEmail(request.getParameter("email"));
		mb.setPass(request.getParameter("pass"));
		
		int emailCheck = 0;
		String result = "";
		
		MemberLoginProService memberLoginProService = new MemberLoginProService();
		emailCheck = memberLoginProService.login(mb);
		
		if(emailCheck == 0 || emailCheck == -1) {
			
			if(emailCheck == 0) {
				result = "아이디가 틀렸습니다";
			} else if(emailCheck == -1) {
				result = "패스워드가 틀렸습니다";
			}
			
			response.setContentType("text/html;charset=UTF-8");
			PrintWriter out = response.getWriter(); 
			out.println("<script>");
			out.println("alert('" + result + "')");
			out.println("history.back()");
			out.println("</script>");
			
		} else {
			
			HttpSession session = request.getSession();
			session.setAttribute("email", mb.getEmail());
			
			forward = new ActionForward();
			forward.setRedirect(true);
			forward.setPath("./");
			
		}
		
		return forward;
	}

}
