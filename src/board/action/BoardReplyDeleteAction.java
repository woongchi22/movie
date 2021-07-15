package board.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import action.Action;
import board.svc.BoardReplyService;
import vo.ActionForward;

public class BoardReplyDeleteAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("BoardReplyDeleteAction");
		
		int idx = Integer.parseInt(request.getParameter("idx"));
		
		BoardReplyService boardReplyListService = new BoardReplyService();
		boolean isSuccess = boardReplyListService.deleteReply(idx);
		
		ActionForward forward = new ActionForward();
		forward.setRedirect(false);
		forward.setPath("BoardReviewList.bo");
		
		return null;
	}

}
