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
		
		String result = "";
//		boolean isFind = false;
		
		ForgetPassProService forgetPassProService = new ForgetPassProService();
		int findResult = forgetPassProService.find(mb);
		
		if(findResult == 0 || findResult == -1) {
			if(findResult == 0) {
				result = "등록하신 이메일이 아닙니다";
			} else if(findResult == -1) {
				result = "등록하신 이름이 아닙니다";
			}
			
			response.setContentType("text/html;charset=UTF-8");
			PrintWriter out = response.getWriter();
			out.println("<script>");
			out.println("alert('" + result + "')");
			out.println("history.back()");
			out.println("</script>");
			
			
		} else {
			HttpSession session = request.getSession();
			session.setAttribute("pass", mb.getPass());
//			session.setAttribute("name", mb.getName());
			
			forward = new ActionForward();
			forward.setRedirect(true);
			forward.setPath("./NewPassForm.me");
		}
		
//		try {
//			pass = forgetPassProService.find(mb);
//			name = 
//			isFind = true;
//		} catch (Exception e) {
//			result = e.getMessage();
//		}
//		
//		if(!isFind) {
//			response.setContentType("text/html;charset=UTF-8");
//			PrintWriter out = response.getWriter(); 
//			out.println("<script>");
//			out.println("alert('" + result + "')");
//			out.println("history.back()");
//			out.println("</script>");
//			
		
		
		return forward;
	}

}
