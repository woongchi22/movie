package board.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import action.Action;
import board.svc.BoardReviewListService;
import board.vo.ReviewBean;
import vo.ActionForward;

public class BoardReviewUpdateAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		request.setCharacterEncoding("UTF-8");
		System.out.println("BoardReviewUpdateAction");
		
        String review = (String) request.getParameter("review");
        HttpSession session = request.getSession();
		String name = (String) request.getAttribute("name");
		int movieSeq = Integer.parseInt(request.getParameter("movieSeq"));
		System.out.println(review);

		ReviewBean reviewBean = new ReviewBean();
		reviewBean.setName(name);
		reviewBean.setMovieSeq(movieSeq);
		reviewBean.setContent(review);
		
		BoardReviewListService boardReviewListService = new BoardReviewListService();
		boolean isUpdate = boardReviewListService.isUpdate(reviewBean);
		
		ActionForward forward = new ActionForward();
		forward.setRedirect(false);
	    forward.setPath("/movie1/reviewView.jsp");
		
		return forward;
	}

}
