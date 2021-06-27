package member.action;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


import action.Action;
import member.svc.DupCheckService;
import vo.ActionForward;

public class MemberNameAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("MemberNameAction");
		
		String name = request.getParameter("name");
		
		System.out.println(name + "가져왔따 ㅋ");
		
		DupCheckService dupCheckService = new DupCheckService();
		boolean checkResult = dupCheckService.dupName(name, "name");
		
		if(!checkResult) {
			response.setContentType("text/html;charset=UTF-8");
			PrintWriter out = response.getWriter();
			out.print("<script>");
			out.print("alert('중복된 E-Mail입니다.')");
			out.print("</script>");
		}else {
			response.setContentType("text/html;charset=UTF-8");
			PrintWriter out = response.getWriter();
			out.print("<script>");
			out.print("alert('사용할 수 있는 E-Mail 입니다.')");
			out.print("</script>");
		}
		
		
		
		return null;
	}

}
