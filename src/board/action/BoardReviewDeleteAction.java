package board.action;

import java.io.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import action.Action;
import board.svc.BoardReviewListService;
import vo.ActionForward;

public class BoardReviewDeleteAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("BoardReviewDeleteAction");
		
		ActionForward forward = null;
		
		String name = request.getParameter("name");
		String title = request.getParameter("query");
		int movieSeq = Integer.parseInt(request.getParameter("movieSeq"));
		
		
		BoardReviewListService boardReviewListService = new BoardReviewListService();
		boolean isSuccess = boardReviewListService.deleteReview(name, movieSeq);
		
		if(!isSuccess) {
			response.setContentType("text/html;charset=UTF-8"); // 문서 타입 설정
			PrintWriter out = response.getWriter();
			out.println("<script>"); // 자바스크립트 시작
			out.println("alert('삭제 실패!')"); // 오류메세지 출력
			out.println("history.back()"); // 이전 페이지로
			out.println("</script>"); // 자바스크립트 끝
			
		} else {
			forward = new ActionForward();
			forward.setRedirect(true);
			forward.setPath("MovieDetailPro.mo?movieSeq=" + movieSeq + "&query=" + title);
		}
		
		
		return forward;
	}

}
