package movie.action;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.google.gson.JsonObject;
import com.google.gson.JsonParser;

import action.Action;
import api.kmdbApi;
//import movie.svc.MovieReviewService;
//import movie.svc.setGradeService;
import movie.vo.MovieBean;
import vo.ActionForward;

public class MovieDetailProAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("MovieDetailProAction");
		System.out.println("-----------------------------------");
		// Get the printwriter object from response to write the required json object to
		// the output stream
		HttpSession session = request.getSession();
		String name = (String)session.getAttribute("name");
		int movieSeq = Integer.parseInt(request.getParameter("movieSeq"));
		System.out.println(name + movieSeq);
		MovieBean movieBean = new MovieBean();
		movieBean.setName(name);
		movieBean.setMovieSeq(movieSeq);
//		setGradeService setGradeService = new setGradeService();
//		int getGrade = setGradeService.selectGrade(movieBean);
		ActionForward forward = new ActionForward();
//		String grade = "";

	      
//	      if((getGrade%2.0) == 0.0) {
//	         grade = (int)(getGrade/2)+"";
//	      }else {
//	         grade = getGrade/2.0 + "";
//	      }
//	      
//	      request.setAttribute("getGrade", grade);
	      
	      
	      // getReview 를 위한 구문들
//	      MovieReviewService movieReviewService = new MovieReviewService();
//	      String review = movieReviewService.getReview(movieBean);
//	      request.setAttribute("returnCmt", review);
	      forward.setRedirect(false);
	      forward.setPath("/movie/movie_detail.jsp");
	      
	      return forward;
	}

}
