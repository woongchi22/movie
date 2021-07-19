package movie.action;

import java.io.*;
import java.util.*;

import javax.servlet.http.*;

import com.google.gson.*;

import action.*;
import api.*;
import vo.*;

public class RandomNationExploreMovieAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("RandomNationExploreMovieAction");
		
		String nations = request.getParameter("nations");
		String allGenre = "모든 장르";
		String allNations = "모든 국가";

		String genre = request.getParameter("genre");
//		System.out.println(nations);
//		System.out.println(genre);

		String ty1="애니메이션";
		String ty2="다큐멘터리";
		
		String totalCount = request.getParameter("totalCount");
//		System.out.println(totalCount);
		int tc = Integer.parseInt(totalCount);
		
		Random r = new Random();
		int startCount = r.nextInt(tc); // 랜덤
//		System.out.println(startCount);
		
		kmdbApi movie = new kmdbApi();
		String json = null;
		
		if(genre.equals(ty1) || genre.equals(ty2) ) {
			if(!allNations.equals(nations)) {
				System.out.println("같이");
				json = movie.getStartMovieType(nations,genre, startCount);
			}
			if(allNations.equals(nations)) {
				System.out.println("따로");
				json = movie.getStartMovieType(genre, startCount);
				}
			
		} else {
		
			if(!allGenre.equals(genre)) {
				System.out.println("같이");
				json = movie.getStartMovie(nations,genre, startCount);
			}
			if(allGenre.equals(genre)) {
				System.out.println("따로");
				json = movie.getStartMovie(nations, startCount);
			}

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
