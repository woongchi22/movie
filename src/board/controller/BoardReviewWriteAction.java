package board.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import action.Action;
import board.svc.BoardReviewWriteService;
import board.vo.ReviewBean;
import vo.ActionForward;

public class BoardReviewWriteAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("BoardReviewWriteAction");
		
		String title = request.getParameter("query");
		int movieSeq = Integer.parseInt(request.getParameter("movieSeq"));
		HttpSession session = request.getSession();
		String name = (String) session.getAttribute("name");
		String review = request.getParameter("review");
		
		System.out.println(title+movieSeq+name+review);
		
		ReviewBean rb = new ReviewBean();
		rb.setContent(review);
		rb.setMovieSeq(movieSeq);
		rb.setName(name);
		rb.setTitle(title);
		
		if(review.equals("")) {
			
		}else {
			BoardReviewWriteService boardReviewWriteService = new BoardReviewWriteService();
			boolean isSuccess= boardReviewWriteService.reviewWrite(rb);
			System.out.println(rb.getContent());

			
			
		}
		
		
		return null;
	}

}
