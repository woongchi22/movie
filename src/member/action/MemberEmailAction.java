package member.action;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import action.Action;
import member.svc.DupCheckService;
import vo.ActionForward;

public class MemberEmailAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("MemberEmailAction!");
		
		String email = request.getParameter("email");
		System.out.println("입력된 email 주소는 " + email);
		DupCheckService dupCheck = new DupCheckService();
		boolean checkResult = dupCheck.dupCheck(email,"email");

		if(!checkResult) {
			response.setContentType("text/html;charset=UTF-8");
			PrintWriter out = response.getWriter();
			out.print("이메일 중복");
//			out.print("<script>");
//			out.print("alert('중복된 E-Mail입니다.')");
//			out.print("</script>");
		}else {
			response.setContentType("text/html;charset=UTF-8");
			PrintWriter out = response.getWriter();
			out.print("사용가능 이메일");
//			out.print("<script>");
//			out.print("alert('사용할 수 있는 E-Mail 입니다.')");
//			out.print("</script>");
			System.out.println(email+"asdf");
		}
		
		return null;
	}

}
