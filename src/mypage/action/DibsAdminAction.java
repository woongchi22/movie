package mypage.action;

import java.util.*;

import javax.servlet.http.*;

import action.*;
import mypage.svc.*;
import mypage.vo.*;
import vo.*;

public class DibsAdminAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("DibsAdminAction!!");
		
		ActionForward forward = null;
		
		DibsListService dibsListService = new DibsListService();
		ArrayList<DibsBean> dbList = dibsListService.getDibsList();
		
		request.setAttribute("dbList", dbList);
		
		forward = new ActionForward();
		forward.setPath("/mypage/dibsAdmin.jsp");
		
		return forward;
	}

}
