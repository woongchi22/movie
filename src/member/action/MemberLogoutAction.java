package member.action;

import java.io.*;

import javax.servlet.http.*;

import action.*;
import vo.*;

public class MemberLogoutAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ActionForward forward = null;
		
		HttpSession session = request.getSession();
		session.invalidate();
		
		response.setContentType("text/html;charset=UTF-8");
		PrintWriter out = response.getWriter();
		
		out.println("<script>");
		out.println("alert('로그아웃 되었습니다.')");
		out.println("location.href='./'");
		out.println("</script>");
		
		return forward;
	}

}
