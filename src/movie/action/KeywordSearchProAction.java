package movie.action;

import java.io.*;

import javax.servlet.http.*;

import com.google.gson.*;

import action.*;
import api.*;
import vo.*;

public class KeywordSearchProAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("KeywordSearchProAction!!");
		
		response.setCharacterEncoding("UTF-8");
		String keyword = request.getParameter("query");
		
		kmdbApi movie = new kmdbApi();
		String json = null;
		
		if(keyword != null) {
			json = movie.getKeyword(keyword);
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
