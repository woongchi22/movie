package movie.action;

import java.io.*;
import java.util.*;

import javax.servlet.http.*;

import com.google.gson.*;

import action.*;
import api.*;
import vo.*;

public class RecommandNationRandomSearchAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("RecommandNationRandomSearchAction!!");
		
		response.setCharacterEncoding("UTF-8");
		String nation = request.getParameter("nation");
		String totalCount = request.getParameter("totalCount");
		int tc = Integer.parseInt(totalCount);
		
		Random r = new Random();
		int startCount = r.nextInt(tc); // 랜덤 
		
		kmdbApi movie = new kmdbApi();
		String json = null;
		
		if(nation != null) {
			json = movie.getNation(nation, startCount);
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
