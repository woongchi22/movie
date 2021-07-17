package movie.action;

import java.io.*;

import javax.servlet.http.*;

import com.google.gson.*;

import action.*;
import api.*;
import vo.*;

public class ExploreMovieAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("ExploreMovieAction");
		request.setCharacterEncoding("UTF-8");
		
		String genre = request.getParameter("genre");
		String nations = request.getParameter("nations");
		String genre1 = "모든 장르";
		String nations1 = "모든 국가";
		

		kmdbApi movie = new kmdbApi();
		String json = null;
		System.out.println(genre);
		
		if(!nations1.equals(nations)) {
			System.out.println("같이");
			json = movie.getMovie(nations,genre);
		}
		else if(nations1.equals(nations)) {
			System.out.println("따로");
			json = movie.getMovie(genre);
			}
		
//		json = movie.getMovieGenre(genre);
		JsonParser jsonParser = new JsonParser();
		JsonObject jsonObject = (JsonObject) jsonParser.parse(json);
		
		response.setContentType("application/json;charset=UTF-8");
		PrintWriter out = response.getWriter();
		out.print(jsonObject);
		out.flush();
		return null;
	}

}
