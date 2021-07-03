package movie.action;

import java.io.*;

import javax.servlet.http.*;

import com.google.gson.*;

import action.*;
import api.*;
import vo.*;

public class DirectorSearchProAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("DirectorSearchProAction!!");
		
		response.setCharacterEncoding("UTF-8");
		String director = request.getParameter("query");
		
		kmdbApi movie = new kmdbApi();
		String json = null;
		
		if(director != null) {
			json = movie.getDirector(director);
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
