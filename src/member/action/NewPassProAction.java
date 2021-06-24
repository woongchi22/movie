package member.action;

import java.io.*;

import javax.servlet.http.*;

import action.*;
import member.svc.*;
import member.vo.*;
import vo.*;

public class NewPassProAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("NewPassProAction!!");
		
		ActionForward forward = null;
		
		boolean isChange = false;
		
		
		MemberBean mb = new MemberBean();
		mb.setPass(request.getParameter("pass"));
//		mb.setEmail(request.getParameter("email"));
		mb.setName(request.getParameter("name"));
		
		HttpSession session = request.getSession();
		session.setAttribute("name", mb.getName());
		
		NewPassProService newPassPrpService = new NewPassProService();
		isChange = newPassPrpService.changPass(mb, session);
		
		System.out.println(mb.getName());
		System.out.println(isChange);
		
		if(!isChange) {
			response.setContentType("text/html;charset=UTF-8");
			PrintWriter out = response.getWriter();
			out.println("<script>");
			out.println("alert('비밀번호 변경 실패')");
			out.println("history.back()");
			out.println("</script>");
			
		} else {
			forward = new ActionForward();
			forward.setRedirect(true);
			forward.setPath("./");
		}
		
		return forward;
	}

}
