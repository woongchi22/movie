package movie.action;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.JsonObject;
import com.google.gson.JsonParser;

import action.Action;
import api.kmdbApi;
import vo.ActionForward;

public class MovieBoxOfficeNationAction implements Action {


	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		System.out.println("MovieBoxOfficeNationAction!!!!!");

		String movieNm = request.getParameter("title");
		String openDt = request.getParameter("openDt");
		System.out.println(movieNm + openDt);
		
		kmdbApi ba = new kmdbApi();
		String getBox = ba.getBoxoffice(openDt,movieNm);
		JsonParser jsonParser = new JsonParser();
		JsonObject jsonObject = (JsonObject) jsonParser.parse(getBox);

		System.out.println("BoxOfficeNationAction");
		response.setContentType("application/json;charset=UTF-8");
		PrintWriter out = response.getWriter();
		out.println(jsonObject);
		out.flush();
		
		return null;
	}

}
