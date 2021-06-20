package member.action;

import java.io.*;

import javax.servlet.http.*;

import action.*;
import member.svc.*;
import member.vo.*;
import vo.*;

public class MemberJoinProAction implements Action {

	@Override
	public ActionForward excute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("MemberJoinProAction");
		
		ActionForward forward = null;
		
		String email = request.getParameter("email");
		String name = request.getParameter("name");
		String pass = request.getParameter("pass");
//		System.out.println(request.getParameter("name"));
//		System.out.println(name);
		
		MemberBeen mb = new MemberBeen();
		mb.setEmail(email);
		mb.setName(name);
		mb.setPass(pass);
		
		boolean isInsert = false;
		String resultMsg = "";
		
		MemberJoinProService memberJoinProService = new MemberJoinProService();
		try {
			isInsert = memberJoinProService.insertMember(mb);
		} catch (Exception e) {
			resultMsg = e.getMessage();
		}
		
		if(!isInsert) {
			response.setContentType("text/html;charset=UTF-8");
			PrintWriter out = response.getWriter();
			out.println("<script>alert('" + resultMsg + "');history.back();</script>");
		} else {
			forward = new ActionForward();
			forward.setPath("./");
		}
		
		
		return forward;
	}

}
