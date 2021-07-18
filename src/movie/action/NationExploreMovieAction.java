package movie.action;

import java.io.*;

import javax.servlet.http.*;

import com.google.gson.*;

import action.*;
import api.*;
import vo.*;

public class NationExploreMovieAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("NationExploreMovieAction");
		request.setCharacterEncoding("UTF-8");
		
		String nations = request.getParameter("nations");
		String genre1 = "모든 장르";
		String nations1 = "모든 국가";

		String genre = request.getParameter("genre");
		System.out.println(nations);
		System.out.println(genre);

		String ty1="애니메이션";
		String ty2="다큐멘터리";
		
		kmdbApi movie = new kmdbApi();
		String json = null;
		
		if(genre.equals(ty1) || genre.equals(ty2) ) {
			if(!nations1.equals(nations)) {
				System.out.println("같이");
				json = movie.getMovieType(nations,genre);
			}
			if(nations1.equals(nations)) {
				System.out.println("따로");
				json = movie.getMovieType(genre);
				}
			
		}else {
		
		if(!genre1.equals(genre)) {
			System.out.println("같이");
			json = movie.getMovie(nations,genre);
		}
		else if(genre1.equals(genre)) {
			System.out.println("따로");
			json = movie.getMovie(nations);
			}

		}
//		json = movie.getMovieNation(nations);
		JsonParser jsonParser = new JsonParser();
		JsonObject jsonObject = (JsonObject) jsonParser.parse(json);
		
		response.setContentType("application/json;charset=UTF-8");
		PrintWriter out = response.getWriter();
		out.print(jsonObject);
		out.flush();
		return null;
	}

}
