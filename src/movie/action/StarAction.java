package movie.action;

import java.io.*;

import javax.servlet.http.*;

import action.*;
import board.svc.BoardReviewListService;
import movie.svc.*;
import movie.vo.*;
import vo.*;

public class StarAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ActionForward forward = null;
		
		HttpSession session = request.getSession();
		String name = (String) session.getAttribute("name");
		int movieSeq = Integer.parseInt(request.getParameter("movieSeq"));
		int grade = Integer.parseInt(request.getParameter("grade"));
//		System.out.println(movieSeq + name + grade);
		
		MovieBean mb = new MovieBean();
		mb.setName(name);
		mb.setMovieSeq(movieSeq);
		mb.setTitle(request.getParameter("title"));
		mb.setGrade(grade);
		
		GradeStarService gradeStarService = new GradeStarService();
		int movieGrade = gradeStarService.selectStar(mb);
		
		request.setAttribute("grade", movieGrade);
		
		response.setCharacterEncoding("UTF-8");
		PrintWriter out = response.getWriter();
		
		switch (movieGrade) {
		case 1:
			out.print("1");
			break;

		case 2:
			out.print("2");
			break;
			
		case 3:
			out.print("3");
			break;
			
		case 4:
			out.print("4");
			break;
			
		case 5:
			out.print("5");
			break;
		}

		return forward;
	}

}
