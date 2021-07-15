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
		int movieSeq = Integer.parseInt(request.getParameter("movieSeq"));
		int idx = Integer.parseInt(request.getParameter("idx"));
		System.out.println("================");
		System.out.println(review+idx+movieSeq);

		ReviewBean reviewBean = new ReviewBean();
		reviewBean.setMovieSeq(movieSeq);
		reviewBean.setContent(review);
		reviewBean.setIdx(idx);
		
		BoardReviewListService boardReviewListService = new BoardReviewListService();
		boolean isUpdate = boardReviewListService.isUpdate(reviewBean);
		
	
		ActionForward forward = new ActionForward();
		forward.setRedirect(false);
	    forward.setPath("/board/reviewView.jsp");
		
		return forward;
	}

}
