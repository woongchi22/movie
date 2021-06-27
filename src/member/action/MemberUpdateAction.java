package member.action;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.websocket.Session;

import action.Action;
import member.svc.MemberUpdateService;
import member.vo.MemberBean;
import vo.ActionForward;

public class MemberUpdateAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("MemberUpdateAction");
		HttpSession session = request.getSession();
		String email = (String) request.getParameter("email");
		String name = (String) request.getParameter("name");
		String pass = (String) request.getParameter("pass");

		System.out.println(email+"ssssssssssss");
		System.out.println(name);
		System.out.println(pass);
		
		MemberBean mb = new MemberBean();
		mb.setEmail(email);
		mb.setName(name);
		mb.setPass(pass);

		ActionForward forward = null;
//		boolean isUpdate = false;
		
		MemberUpdateService memberUpdateService = new MemberUpdateService();
		boolean checkResult = memberUpdateService.memberUpdate(mb);
		
		
		
		
		if(checkResult) {
			response.setContentType("text/html;charset=UTF-8");
			session.setAttribute("name",mb.getName());
			session.setAttribute("email",mb.getEmail());
			PrintWriter out = response.getWriter();
			out.println("<script>");
			out.println("alert('회원정보 수정 완료')");
			out.println("</script>");
			forward = new ActionForward();
			forward.setRedirect(true);
			forward.setPath("./");
		} else {
			response.setContentType("text/html;charset=UTF-8");
			PrintWriter out = response.getWriter();
			out.println("<script>");
			out.println("alert('회원정보 수정 실패')");
			out.println("history.back()");
			out.println("</script>");
		}
		
		return forward;
	}

}
