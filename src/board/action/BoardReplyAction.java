package board.action;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import action.Action;
import board.svc.BoardReplyService;
import board.svc.BoardReviewListService;
import board.vo.ReplyBean;
import board.vo.ReviewBean;
import vo.ActionForward;

public class BoardReplyAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		request.setCharacterEncoding("UTF-8");
		System.out.println("BoardReplyAction");

		
		int idx = Integer.parseInt(request.getParameter("idx"));
		int movieSeq = Integer.parseInt(request.getParameter("movieSeq"));

		HttpSession session = request.getSession();
		String name = (String)request.getAttribute("name");
		String reply = request.getParameter("reply");
		
		System.out.println(idx+movieSeq);
		System.out.println(reply+name);
		
		ReplyBean replyBean = new ReplyBean();
		replyBean.setName(name);
		replyBean.setMovieSeq(movieSeq);
		replyBean.setIdx(idx);
		
		
		// 선택한 리뷰 내용 들고오기
		BoardReviewListService boardReviewListService = new BoardReviewListService();
		ReviewBean reviewBean = boardReviewListService.getReview(idx, movieSeq);
		request.setAttribute("reviewBean", reviewBean);

		// 댓글 리스트 불러오기
		BoardReplyService boardReplyService = new BoardReplyService();
		ArrayList<ReplyBean> replyList = boardReplyService.replyList(replyBean);
		System.out.println("!!!");
		request.setAttribute("replyList", replyList);
		
		ActionForward forword = new ActionForward();
		forword.setRedirect(false);
		forword.setPath("/board/reviewReply.jsp");
		
		
	    return forword;
	}

}
