package board.action;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import action.Action;
import board.svc.BoardReviewService;
import board.vo.ReviewBean;
import vo.ActionForward;

public class BoardReviewListAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("BoardReviewListAction");
		response.setCharacterEncoding("UTF-8");

		int movieSeq = Integer.parseInt(request.getParameter("movieSeq"));
		String title = request.getParameter("query");

		ReviewBean rb = new ReviewBean();
		rb.setMovieSeq(movieSeq);
		rb.setTitle(title);
		
		BoardReviewService boardReviewService = new BoardReviewService();
//		String reviewList = boardReviewService.getReview(rb);
		
		
		return null;
	}

}
