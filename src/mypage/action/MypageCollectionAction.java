package mypage.action;

import java.util.*;

import javax.servlet.http.*;

import action.*;
import mypage.svc.*;
import mypage.vo.*;
import vo.*;

public class MypageCollectionAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("MypageCollectionAction");
		ActionForward forward = null;
		HttpSession session = request.getSession();
		String name = (String)session.getAttribute("name");
		
		MypageAddCollectionService service = new MypageAddCollectionService();
		ArrayList<CollectionBean> collection = service.selectCollection(name);
		request.setAttribute("collection", collection);
		System.out.println(collection);
		forward = new ActionForward();
		forward.setPath("/mypage/collection.jsp");
		
		
		return forward;
	}

}
