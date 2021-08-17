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
		ActionForward forward = null;
		boolean isChange = false;
		
		HttpSession session = request.getSession();
		String name = (String) request.getParameter("name");
		
		NewPassProService newPassPrpService = new NewPassProService();
		
		MemberBean mb = new MemberBean();
		mb.setName(name);
		mb.setPass(request.getParameter("pass"));
		
		isChange = newPassPrpService.changPass(mb);
		
//		System.out.println(name + "맞나?");
//		System.out.println(mb.getPass() + "비번뜨남");
		
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
			forward.setPath("./MemberLoginForm.me");
		}
		
		return forward;
		
	}

}
