package member.action;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

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
		boolean isLogin = false;
		
		String name = "";
		String result = "";
		
		MemberLoginProService memberLoginProService = new MemberLoginProService();
		name = memberLoginProService.login(mb);
		isLogin = true;
		
		if(!isLogin) {
			
			response.setContentType("text/html;charset=UTF-8");
			PrintWriter out = response.getWriter(); 
			out.println("<script>");
			out.println("alert('" + result + "')");
			out.println("history.back()");
			out.println("</script>");	
		}else {
			
			forward = new ActionForward();
			forward.setRedirect(true);
			forward.setPath("./");
			
		}
		
		
		return forward;
	}

}
