package movie.action;

import java.io.*;
import java.util.*;

import javax.servlet.http.*;

import com.google.gson.*;

import action.*;
import movie.svc.*;
import movie.vo.*;
import vo.*;

public class RecommandGenreAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("RecommandGenreAction");
		
		ActionForward forward = null;
		
		String name = request.getParameter("name");
		System.out.println(name);
		
		MovieListService movieListService = new MovieListService();
		ArrayList<MovieBean> movieList = movieListService.getGenre(name);
		request.setAttribute("movieList", movieList);
		
		
		response.setContentType("application/json;charset=UTF-8");
		PrintWriter out = response.getWriter();
		System.out.println(movieList);
		out.print(movieList);
		
		forward = new ActionForward();
		forward.setPath("/recommand/movie_genre.jsp");
		
		return forward;
	}

}
