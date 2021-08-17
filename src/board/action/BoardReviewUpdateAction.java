package board.action;

import java.io.*;

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
		ActionForward forward = null;
		
        String review = (String) request.getParameter("review");
		int movieSeq = Integer.parseInt(request.getParameter("movieSeq"));
		String name = request.getParameter("name");
		int grade = Integer.parseInt(request.getParameter("grade"));
//		System.out.println(grade+review+name+movieSeq);

		ReviewBean reviewBean = new ReviewBean();
		reviewBean.setMovieSeq(movieSeq);
		reviewBean.setContent(review);
		reviewBean.setName(name);
		reviewBean.setGrade(grade);
		
		BoardReviewListService boardReviewListService = new BoardReviewListService();
		boolean isUpdate = boardReviewListService.isUpdate(reviewBean);
		
		if(!isUpdate) {
			response.setContentType("text/html;charset=UTF-8"); // 문서 타입 설정
			PrintWriter out = response.getWriter();
			out.println("<script>"); // 자바스크립트 시작
			out.println("alert('수정 실패!')"); // 오류메세지 출력
//			out.println("history.back()"); // 이전 페이지로
			out.println("</script>"); // 자바스크립트 끝
			
		} else {
			request.setAttribute("review", reviewBean.getContent());
			
			response.setCharacterEncoding("UTF-8");
			PrintWriter out = response.getWriter();
			out.print(reviewBean.getContent());
		}
		
		return forward;
	}

}
