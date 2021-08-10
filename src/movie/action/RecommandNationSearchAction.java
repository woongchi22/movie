package movie.action;

import java.io.*;

import javax.servlet.http.*;

import com.google.gson.*;

import action.*;
import api.*;
import vo.*;

public class RecommandNationSearchAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("RecommandNationSearchAction!!");
		
		response.setCharacterEncoding("UTF-8");
		String nation = request.getParameter("nation");
		
		kmdbApi movie = new kmdbApi();
		String json = null;
		
		if(nation != null) {
			json = movie.getNation(nation);
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
