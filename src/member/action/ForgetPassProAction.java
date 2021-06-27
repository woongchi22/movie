package member.action;

import java.io.*;

import javax.servlet.http.*;

import action.*;
import member.svc.*;
import member.vo.*;
import vo.*;

public class ForgetPassProAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("ForgetPassProAction");
		
		ActionForward forward = null;
		
		MemberBean mb = new MemberBean();
		mb.setEmail(request.getParameter("email"));
		mb.setName(request.getParameter("name"));
		
		boolean isFind = false;
		String result = "";
		String name = "";
		
		ForgetPassProService forgetPassProService = new ForgetPassProService();
		
		try {
			name = forgetPassProService.find(mb);
			isFind = true;
		} catch (Exception e) {
			result = e.getMessage();
		}
		
		if(!isFind) {
			response.setContentType("text/html;charset=UTF-8");
			PrintWriter out = response.getWriter(); 
			out.println("<script>");
			out.println("alert('" + result + "')");
			out.println("history.back()");
			out.println("</script>");
			
		} else {
			HttpSession session = request.getSession();
			session.setAttribute("name", name);
			System.out.println(name);
			
			
			forward = new ActionForward();
			forward.setRedirect(true);
			forward.setPath("./NewPassForm.me");
		}
		
		return forward;
	}

}
