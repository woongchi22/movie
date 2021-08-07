package movie.action;

import java.io.*;

import javax.servlet.http.*;

import action.*;
import board.svc.BoardReviewListService;
import movie.svc.*;
import movie.vo.*;
import vo.*;

public class GradeStarAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("GradeStarAction!!!");
		
		ActionForward forward = null;
		
		HttpSession session = request.getSession();
		String name = (String) session.getAttribute("name");
		int movieSeq = Integer.parseInt(request.getParameter("movieSeq"));
		String title = request.getParameter("query");
		int grade = Integer.parseInt(request.getParameter("grade"));
		String nation = request.getParameter("nation");
		String director = request.getParameter("director");
		String genre = request.getParameter("genre");
		int runtime = Integer.parseInt(request.getParameter("runtime"));
		
		System.out.println(name + movieSeq + title + grade + nation+director+genre+runtime);
		
		MovieBean mb = new MovieBean();
		mb.setName(name);
		mb.setMovieSeq(movieSeq);
		mb.setTitle(title);
		mb.setGrade(grade);
		mb.setNation(nation);
		mb.setDirector(director);
		mb.setGenre(genre);
		mb.setRuntime(runtime);
		
		GradeStarService gradeStarService = new GradeStarService();
		gradeStarService.gradeStar(mb);
		
		request.setAttribute("grade", mb.getGrade());
		
		response.setCharacterEncoding("UTF-8");
		PrintWriter out = response.getWriter();
		out.print(mb.getGrade());
		

		return forward;
		
	}

}
