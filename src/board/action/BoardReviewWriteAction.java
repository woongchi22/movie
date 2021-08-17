package board.action;

import java.io.PrintWriter;

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
		request.setCharacterEncoding("UTF-8");
		ActionForward forward = null;
		
		int movieSeq = Integer.parseInt(request.getParameter("movieSeq"));
		String title = (String) request.getParameter("query");
		String review = (String) request.getParameter("review");
		HttpSession session = request.getSession();
		String name = (String) session.getAttribute("name");
		int grade = Integer.parseInt(request.getParameter("grade"));
		String poster = request.getParameter("poster");
		
//		System.out.println(movieSeq + title + review + name + grade + "이거 안나옴?" + poster);
		
		ReviewBean reviewBean = new ReviewBean();
		reviewBean.setContent(review);
		reviewBean.setMovieSeq(movieSeq);
		reviewBean.setTitle(title);
		reviewBean.setName(name);
		reviewBean.setGrade(grade);
		reviewBean.setPoster(poster);
		
		BoardReviewWriteService boardReviewWriteService = new BoardReviewWriteService();
		boolean isWrite = boardReviewWriteService.reviewWrite(reviewBean);

		if(!isWrite) {
			response.setContentType("text/html;charset=UTF-8"); // 문서 타입 설정
			PrintWriter out = response.getWriter();
			out.println("<script>"); // 자바스크립트 시작
			out.println("alert('작성 실패!')"); // 오류메세지 출력
			out.println("history.back()"); // 이전 페이지로
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
