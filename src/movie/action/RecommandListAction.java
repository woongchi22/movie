package movie.action;

import java.io.*;
import java.util.*;

import javax.servlet.http.*;

import org.json.simple.*;

import com.google.gson.*;

import action.*;
import movie.svc.*;
import movie.vo.*;
import vo.*;

public class RecommandListAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("RecommandListAction");
		
		ActionForward forward = null;
		
		String name = request.getParameter("name");
		System.out.println(name);
		
		MovieListService movieListService = new MovieListService();
		ArrayList<MovieBean> movieList = movieListService.getMovie(name);
//		request.setAttribute("movieList", movieList);
		
		JSONArray jsonArray = new JSONArray();
		JSONObject json = null;
		
		for(int i=0; i<movieList.size(); i++) {
			json = new JSONObject();
			
			MovieBean mb = (MovieBean) movieList.get(i);
			json.put("idx", mb.getIdx());
			json.put("name", mb.getName());
			json.put("movieSeq", mb.getMovieSeq());
			json.put("title", mb.getTitle());
			json.put("grade", mb.getGrade());
			json.put("nation", mb.getNation());
			json.put("director", mb.getDirector());
			json.put("genre", mb.getGenre());
			json.put("runtime", mb.getRuntime());
			json.put("poster", mb.getPoster());
			jsonArray.add(json);
		}
		
		response.setContentType("application/json;charset=UTF-8");
		PrintWriter out = response.getWriter();
		System.out.println(jsonArray);
		out.print(jsonArray.toString());
		out.flush();
		out.close();
		
		return forward;
	}

}
