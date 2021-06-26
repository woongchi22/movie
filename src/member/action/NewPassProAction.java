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
		
		int idx = Integer.parseInt(request.getParameter("idx"));
		
		NewPassProService newPassPrpService = new NewPassProService();
		
		MemberBean mb = new MemberBean();
		mb.setIdx(idx);
		mb.setName(request.getParameter("name"));
		mb.setPass(request.getParameter("pass"));
		
		isChange = newPassPrpService.changPass(mb);
		
		System.out.println(idx + "맞나?");
		System.out.println(mb.getName() + "맞나?");
		System.out.println(mb.getPass() + "비번뜨남");
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
