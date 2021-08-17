package member.action;

import java.util.*;

import javax.servlet.http.*;

import action.*;
import member.svc.*;
import member.vo.*;
import vo.*;

public class MemberListAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ActionForward forward = null;
		
		String orderTarget = request.getParameter("orderTarget");
		String orderType = request.getParameter("orderType");
		
		MemberListService memberListService = new MemberListService();
		
		ArrayList<MemberBean> mbList = memberListService.getMemberList();
		if(orderTarget == null) {
			mbList = memberListService.getMemberList();
		} else {
			mbList = memberListService.getMemberList(orderTarget, orderType);
		}
		
		request.setAttribute("mbList", mbList);
		
		forward = new ActionForward();
		forward.setPath("/member/admin_member_list.jsp");
		
		return forward;
	}

}
