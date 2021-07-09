package board.action;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import action.Action;
import board.svc.BoardReviewService;
import board.vo.ReviewBean;
import vo.ActionForward;

public class BoardReviewAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("BoardReviewAction");
		int movieSeq = Integer.parseInt(request.getParameter("movieSeq"));
		HttpSession session = request.getSession();
		String name = (String) session.getAttribute("name");
		System.out.println(movieSeq);
		
		ReviewBean rb = new ReviewBean();
		rb.setMovieSeq(movieSeq);
		rb.setName(name);
		
		
		BoardReviewService boardReviewService = new BoardReviewService();
		ArrayList<ReviewBean> reviewList =boardReviewService.getReview(rb);
		request.setAttribute("reviewList",reviewList);
		ActionForward forward = new ActionForward();
		
		forward.setRedirect(false);
		forward.setPath("/board/reviewView.jsp");
		
		return forward;
	}

}
