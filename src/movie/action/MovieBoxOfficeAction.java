package movie.action;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.JsonObject;
import com.google.gson.JsonParser;

import action.Action;
import api.BoxofficeApi;
import vo.ActionForward;

public class MovieBoxOfficeAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String targetDt = request.getParameter("targetDt");
//		System.out.println(targetDt+"aaaaaaaaa");
		
		BoxofficeApi ba = new BoxofficeApi();
		String getBox = ba.getBoxOffice(targetDt);
		
		JsonParser jsonParser = new JsonParser();
		JsonObject jsonObject = (JsonObject) jsonParser.parse(getBox);

		response.setContentType("application/json;charset=UTF-8");
		PrintWriter out = response.getWriter();
		out.print(jsonObject);
		
		return null;
	}

}
