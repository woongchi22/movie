package movie.action;

import java.io.*;

import javax.servlet.http.*;

import com.google.gson.*;

import action.*;
import api.*;
import vo.*;


public class MovieDetailAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("MovieDetailAction");
		
		response.setCharacterEncoding("UTF-8");
		String movieSeq = request.getParameter("movieSeq");
		String query = request.getParameter("query");
		
		kmdbApi movie = new kmdbApi();
		String json = null;
		
		if(query != null && movieSeq != null) {
			
			while(movieSeq.length() != 5) {
				movieSeq = "0" + movieSeq;
			}
			json = movie.getMovieDetail(query, movieSeq);
		}
		
		JsonParser jsonParser = new JsonParser();
		JsonObject jsonObject = (JsonObject) jsonParser.parse(json);
		
		response.setContentType("application/json;charset=UTF-8");
		PrintWriter out = response.getWriter();
		out.print(jsonObject);
		out.flush();

		
		return null;
	}

}
