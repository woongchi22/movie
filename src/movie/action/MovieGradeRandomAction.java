package movie.action;

import java.io.*;
import java.util.*;

import javax.servlet.http.*;

import com.google.gson.*;

import action.*;
import api.*;
import vo.*;

public class MovieGradeRandomAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		response.setCharacterEncoding("UTF-8");
		
		Random r = new Random();
		int startCount = r.nextInt(61343); // 0~61392 랜덤
		
		kmdbApi movie = new kmdbApi();
		String json = movie.getMovieGrade(startCount);
		
		JsonParser jsonParser = new JsonParser();
		JsonObject jsonObject = (JsonObject) jsonParser.parse(json);
		
		response.setContentType("application/json;charset=UTF-8");
		PrintWriter out = response.getWriter();
		out.print(jsonObject);
		out.flush();
		
		return null;
	}

}
