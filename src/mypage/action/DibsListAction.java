package mypage.action;

import java.util.*;

import javax.servlet.http.*;

import action.*;
import mypage.svc.*;
import mypage.vo.*;
import vo.*;

public class DibsListAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ActionForward forward = null;
		
		HttpSession session = request.getSession();
		String name = (String) session.getAttribute("name");
		
		DibsListService dibsListService = new DibsListService();
		ArrayList<DibsBean> dbList = dibsListService.getDibsList(name);
		
		request.setAttribute("dbList", dbList);
		
		forward = new ActionForward();
		forward.setPath("/mypage/dibs.jsp");
		
		return forward;
	}

}
