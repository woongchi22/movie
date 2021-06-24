package member.action;

import java.io.PrintWriter;

import javax.servlet.http.*;

import action.Action;
import member.svc.MemberLoginProService;
import member.vo.MemberBean;
import vo.ActionForward;

public class MemberLoginProAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("MemberLoginProAction");
		
		ActionForward forward = null;
		
		MemberBean mb = new MemberBean();
		mb.setEmail(request.getParameter("email"));
		mb.setPass(request.getParameter("pass"));
		
		boolean isLogin = false;
		String result = "";
		String name = "";
		
		MemberLoginProService memberLoginProService = new MemberLoginProService();
		try {
			name = memberLoginProService.login(mb);
			isLogin = true;
		} catch (Exception e) {
			result = e.getMessage();
		}
		
		if(!isLogin) {
			
			response.setContentType("text/html;charset=UTF-8");
			PrintWriter out = response.getWriter(); 
			out.println("<script>");
			out.println("alert('" + result + "')");
			out.println("history.back()");
			out.println("</script>");
			
		} else {
			
			HttpSession session = request.getSession();
			session.setAttribute("name", name);
			
			forward = new ActionForward();
			forward.setRedirect(true);
			forward.setPath("./");
			
		}
		
		return forward;
	}

}
