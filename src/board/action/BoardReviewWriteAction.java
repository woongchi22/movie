package board.action;

import java.io.PrintWriter;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import action.Action;
import board.svc.BoardReviewListService;
import board.vo.ReviewBean;
import vo.ActionForward;

public class BoardReviewWriteAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		request.setCharacterEncoding("UTF-8");
		System.out.println("BoardReviewWriteAction");
		ActionForward forward = null;

		
		int movieSeq = Integer.parseInt(request.getParameter("movieSeq"));
		String title = (String) request.getParameter("query");

		String review = (String) request.getParameter("review");
		HttpSession session = request.getSession();
		String name = (String) session.getAttribute("name");

		
		ReviewBean reviewBean = new ReviewBean();
		reviewBean.setContent(review);
		reviewBean.setMovieSeq(movieSeq);
		reviewBean.setTitle(title);
		reviewBean.setName(name);
		

		System.out.println(review+title+name+movieSeq);

		System.out.println("======================");
		System.out.println(reviewBean.getContent());
		
//		BoardReviewListService boardReviewListService = new BoardReviewListService();
//		boolean isSuccess = boardReviewListService.reviewWrite(reviewBean);
//		
//		
//		if(!isSuccess) {
//			response.setContentType("text/html;charset=UTF-8");
//			PrintWriter out = response.getWriter();
//			out.println("<script>"); 
//			out.println("alert('글 등록 실패!')");
//			out.println("history.back()"); 
//			out.println("</script>"); 
//		}else { 
//			request.setAttribute("reviewBean", reviewBean);
//			
//			forward = new ActionForward();
//			forward.setPath("BoardReviewList.bo");
//		}
		
		
		return forward;
	}

}
