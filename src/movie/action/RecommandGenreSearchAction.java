package movie.action;

import java.io.*;
import java.util.*;

import javax.servlet.http.*;

import com.google.gson.*;

import action.*;
import api.*;
import vo.*;

public class RecommandGenreSearchAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("RecommandGenreSearchAction!!");
		
		response.setCharacterEncoding("UTF-8");
		String genre = request.getParameter("genre");
		String genre2 = request.getParameter("genre2");
		
		kmdbApi movie = new kmdbApi();
		String json = null;
		
		if(genre != null) {
			json = movie.getGenre(genre, genre2);
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
