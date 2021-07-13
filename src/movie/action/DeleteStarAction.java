package movie.action;

import java.io.*;

import javax.servlet.http.*;

import action.*;
import movie.svc.*;
import vo.*;

public class DeleteStarAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("DeleteStarAction!");
		
		ActionForward forward = null;
		
		String name = request.getParameter("name");
		String title = request.getParameter("query");
		int movieSeq = Integer.parseInt(request.getParameter("movieSeq"));
		System.out.println(name+title+movieSeq);
		
		DeleteStarService deleteStarService = new DeleteStarService();
		boolean isDelete = deleteStarService.deleteStar(name, movieSeq);
		
		if(!isDelete) {
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
