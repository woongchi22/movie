package movie.action;

import java.io.*;

import javax.servlet.http.*;

import action.*;
import movie.svc.*;
import movie.vo.*;
import vo.*;

public class AverageStarAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("AverageStarAction!");
		
		ActionForward forward = null;
		
		int movieSeq = Integer.parseInt(request.getParameter("movieSeq"));
		
		AverageStarService averageStarService = new AverageStarService();
		float avgGrade = averageStarService.averageStar(movieSeq);
		
		
//		request.setAttribute("avgGrade", avgGrade);
		
		response.setCharacterEncoding("UTF-8");
		PrintWriter out = response.getWriter();
		out.print(avgGrade);
		
		return forward;
		
	}

}
