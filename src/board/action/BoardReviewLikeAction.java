package board.action;

import java.io.*;

import javax.servlet.http.*;


import action.*;
import board.svc.*;
import board.vo.*;
import vo.*;

public class BoardReviewLikeAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("BoardReviewLikeAction");
		request.setCharacterEncoding("UTF-8");
		
		int idx = Integer.parseInt(request.getParameter("idx"));
		HttpSession session = request.getSession();
		String name = request.getParameter("name");
		
		ActionForward forward = new ActionForward();
		ReviewBean rb = new ReviewBean();
		rb.setName(name);
		rb.setIdx(idx);
		
		BoardReviewListService boardReviewListService = new BoardReviewListService();
		boolean isInsert = boardReviewListService.insertLike(rb);
		
		if(!isInsert) {
			BoardReviewListService boardReviewListService1 = new BoardReviewListService();
			boolean isInsert2 = boardReviewListService1.deleteLike(rb);
			
			BoardReviewListService boardReviewService2 = new BoardReviewListService();
			boolean isSuccess = boardReviewService2.likeCancel(rb);
			
			forward.setRedirect(false);
			forward.setPath("/BoardReviewList.bo");
			
		}else {
			BoardReviewListService boardReviewService = new BoardReviewListService();
			boolean isSuccess = boardReviewService.reviewLike(rb);
			
			forward.setRedirect(false);
			forward.setPath("/BoardReviewList.bo");
		}
		
		return forward;
	}

}
