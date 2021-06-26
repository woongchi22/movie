package member.action;

import javax.servlet.http.*;

import action.*;
import member.svc.*;
import member.vo.*;
import vo.*;

public class NewPassFromAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("NewPassFormAction!!");
		
		ActionForward forward = null;
		
		HttpSession session = request.getSession();
		int idx = Integer.parseInt(request.getParameter("idx"));
		System.out.println(idx);
		
		NewPassProService newPassProService = new NewPassProService();
		MemberBean mb = newPassProService.getMb(idx);
		
//		request.setAttribute("name", name);
		
		forward = new ActionForward();
		forward.setPath("/member/new_pass.jsp");
		
		return forward;
	}

}
