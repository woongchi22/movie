package movie.action;


import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import action.Action;
import api.kmdbApi;
import board.svc.BoardReviewListService;
import board.vo.ReviewBean;
import movie.svc.GradeStarService;
import movie.vo.MovieBean;
import vo.ActionForward;

public class MovieDetailProAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("MovieDetailProAction~~~");
		
		ActionForward forward = null;
		
		HttpSession session = request.getSession();
		String name = (String)session.getAttribute("name");
		String title = request.getParameter("query");
		int  movieSeq = Integer.parseInt(request.getParameter("movieSeq"));
		System.out.println(name+title+movieSeq);
		
		// 별점
		MovieBean mb = new MovieBean();
		mb.setName(name);
		mb.setMovieSeq(movieSeq);
		
		GradeStarService gradeStarService = new GradeStarService();
		int movieGrade = gradeStarService.selectStar(mb);
		String grade = movieGrade + "";
		
		request.setAttribute("grade", grade);
		System.out.println(grade);
		
		// 리뷰
		ReviewBean rb = new ReviewBean();
		rb.setName(name);
		rb.setMovieSeq(movieSeq);
		
		BoardReviewListService boardReviewListService = new BoardReviewListService();
		String review =  boardReviewListService.getReview(rb);
		
		request.setAttribute("review", review);
		System.out.println(review);
		
		
		forward = new ActionForward();
		forward.setPath("/movie/movie_detail.jsp");
		
	    return forward;
	    
	}

}
