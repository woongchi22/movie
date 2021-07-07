package movie.action;


import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


import action.Action;
import api.kmdbApi;
import vo.ActionForward;

public class MovieDetailProAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("MovieDetailProAction~~~");
		request.setCharacterEncoding("UTF-8");
		String query = request.getParameter("query");
		int  movieSeq = Integer.parseInt(request.getParameter("movieSeq"));
		System.out.println(query+movieSeq);
		
		ActionForward forward = new ActionForward();
		forward.setRedirect(false);
		forward.setPath("/movie/movie_detail.jsp");
	    return forward;
	    
	}

}
