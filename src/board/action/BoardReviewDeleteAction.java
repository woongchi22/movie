package board.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import action.Action;
import board.svc.BoardReviewListService;
import vo.ActionForward;

public class BoardReviewDeleteAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("BoardReviewDeleteAction");
		
		int idx = Integer.parseInt(request.getParameter("idx"));
		
		BoardReviewListService boardReviewListService = new BoardReviewListService();
		boolean isSuccess = boardReviewListService.deleteReview(idx);
		
		ActionForward forward = new ActionForward();
		forward.setRedirect(false);
		forward.setPath("BoardReviewList.bo");
		
		return null;
	}

}
