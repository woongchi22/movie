package movie.action;

import java.io.*;
import java.util.*;

import javax.servlet.http.*;

import com.google.gson.*;

import action.*;
import api.*;
import vo.*;

public class RandomExploreMovieAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("RandomExploreMovieAction");
		
		String genre = request.getParameter("genre");
		String nations = request.getParameter("nations");
		String genre1 = "모든 장르";
		String nations1 = "모든 국가";
		String ty1="애니메이션";
		String ty2="다큐멘터리";
		
		String totalCount = request.getParameter("totalCount");
		int tc = Integer.parseInt(totalCount);
		
		Random r = new Random();
		int startCount = r.nextInt(tc); // 랜덤 

		kmdbApi movie = new kmdbApi();
		String json = null;
		
		if(genre.equals(ty1) || genre.equals(ty2) ) {
			if(!nations1.equals(nations)) {
				System.out.println("같이");
				json = movie.getStartMovieType(nations,genre, startCount);
			}
			if(nations1.equals(nations)) {
				System.out.println("따로");
				json = movie.getStartMovieType(genre, startCount);
				}
		} else {
			if(!nations1.equals(nations)) {
				System.out.println("같이");
				json = movie.getStartMovie(nations,genre, startCount);
			}
			if(nations1.equals(nations)) {
				System.out.println("따로");
				json = movie.getStartMovieGenre(genre, startCount);
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
