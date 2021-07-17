package board.action;

import java.io.*;

import javax.servlet.http.*;
import javax.websocket.*;

import action.Action;
import board.svc.*;
import board.vo.*;
import vo.ActionForward;

public class GetContentAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("GetContentAction");
		
		ActionForward forward = null;
		
		HttpSession session = request.getSession();
		String name = (String) session.getAttribute("name");
		int movieSeq = Integer.parseInt(request.getParameter("movieSeq"));
		String content = request.getParameter("review");
		
		ReviewBean rb = new ReviewBean();
		rb.setName(name);
		rb.setMovieSeq(movieSeq);
		
		BoardReviewListService boardReviewListService = new BoardReviewListService();
		String review =  boardReviewListService.getReview(rb);
		
		response.setCharacterEncoding("UTF-8");
		PrintWriter out = response.getWriter();
		out.print(review);
		
		return forward;
	}

}
