package board.action;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import action.Action;
import board.svc.BoardReviewListService;
import board.vo.ReviewBean;
import vo.ActionForward;

public class BoardReviewListAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		request.setCharacterEncoding("UTF-8");
		System.out.println("BoardReviewListAction");
		ActionForward forward = null;

		
		int movieSeq = Integer.parseInt(request.getParameter("movieSeq"));
		String title = (String) request.getParameter("query");
		HttpSession session = request.getSession();
		String name = (String)request.getAttribute("name");
		
		
		
		BoardReviewListService boardReviewListService = new BoardReviewListService();
		ArrayList<ReviewBean> reviewList = boardReviewListService.getReview(movieSeq);
		
		request.setAttribute("reviewList", reviewList);
	
		forward = new ActionForward();
		forward.setPath("/board/reviewView.jsp");
		
		return forward;
	}

}
