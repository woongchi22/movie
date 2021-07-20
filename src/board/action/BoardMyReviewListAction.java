package board.action;

import java.util.*;

import javax.servlet.http.*;

import action.*;
import board.svc.*;
import board.vo.*;
import vo.*;

public class BoardMyReviewListAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("BoardMyReviewListAction");
		request.setCharacterEncoding("UTF-8");
		
		String name = request.getParameter("name");
		System.out.println(name);
		BoardReviewListService boardReviewListService = new BoardReviewListService();
		ArrayList<ReviewBean> reviewList = boardReviewListService.getReview(name);
		
		request.setAttribute("reviewList", reviewList);
		
		ActionForward forward = new ActionForward();
		forward = new ActionForward();
		forward.setPath("/mypage/my_review.jsp");
		
		return forward;
	}

}
