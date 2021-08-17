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

public class MemberUpdateProAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		HttpSession session = request.getSession();
		String email = (String) request.getParameter("email");
		String name = (String) request.getParameter("name");
		String pass = (String) request.getParameter("pass");

		MemberBean mb = new MemberBean();
		mb.setEmail(email);
		mb.setName(name);
		mb.setPass(pass);

		ActionForward forward = null;
		
		MemberUpdateService memberUpdateService = new MemberUpdateService();
		boolean checkResult = memberUpdateService.memberUpdate(mb);
		
		if(checkResult) {
			response.setContentType("text/html;charset=UTF-8");
			PrintWriter out = response.getWriter();
			out.println("<script>");
			out.println("alert('회원정보 수정 완료')");
			out.println("</script>");
			session.setAttribute("name",mb.getName());
			session.setAttribute("email",mb.getEmail());

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
