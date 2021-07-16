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
		System.out.println(genre);
		kmdbApi movie = new kmdbApi();
		String json = null;
		
		json = movie.getMovieGenre(genre);
		
		JsonParser jsonParser = new JsonParser();
		JsonObject jsonObject = (JsonObject) jsonParser.parse(json);
		
		response.setContentType("application/json;charset=UTF-8");
		PrintWriter out = response.getWriter();
		out.print(jsonObject);
		out.flush();
		return null;
	}

}
