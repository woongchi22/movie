package board.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import action.Action;
import board.svc.BoardReplyService;
import board.vo.ReviewBean;
import vo.ActionForward;

public class BoardReplyUpdateAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		request.setCharacterEncoding("UTF-8");
		System.out.println("BoardRevplyUpdateAction");
		
        String review = (String) request.getParameter("review");
		int movieSeq = Integer.parseInt(request.getParameter("movieSeq"));
		int idx = Integer.parseInt(request.getParameter("idx"));
//		System.out.println("================");
//		System.out.println(review+idx);

		ReviewBean replyBean = new ReviewBean();
		replyBean.setMovieSeq(movieSeq);
		replyBean.setContent(review);
		replyBean.setIdx(idx);
		
		BoardReplyService boardReplyService = new BoardReplyService();
		boolean isUpdate = boardReplyService.isUpdate(replyBean);
		
	
		ActionForward forward = new ActionForward();
		forward.setRedirect(false);
	    forward.setPath("/board/reviewView.jsp");
		
		return forward;
	}

}
