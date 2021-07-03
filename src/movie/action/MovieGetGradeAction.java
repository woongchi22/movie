package movie.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import action.Action;
import movie.vo.MovieBean;
import vo.ActionForward;

public class MovieGetGradeAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("MovieGetGradeAction");
		response.setCharacterEncoding("UTF-8");
		HttpSession session = request.getSession();
		String name = (String) request.getAttribute("name");
		int movieSeq = Integer.parseInt(request.getParameter("movieSeq"));
		System.out.println(name+movieSeq);
		MovieBean movieBean = new MovieBean();
		movieBean.setName(name);
		movieBean.setMovieSeq(movieSeq);
//		setGradeService setGradeService = new setGradeService();
//		int getGrade = setGradeService.selectGrade(MovieBean);
//		ActionForward forward = new ActionForward();
//		String grade = "";
		
		
		
		return null;
	}

}
