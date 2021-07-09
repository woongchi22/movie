package movie.action;

import java.io.*;

import javax.servlet.http.*;

import action.*;
import movie.svc.*;
import movie.vo.*;
import vo.*;

public class StarAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("StarAction!!");
		
		ActionForward forward = null;
		
		HttpSession session = request.getSession();
		String name = (String) session.getAttribute("name");
		int movieSeq = Integer.parseInt(request.getParameter("movieSeq"));
		int grade = Integer.parseInt(request.getParameter("grade"));
		System.out.println(movieSeq + name + grade);
		
//		StarService starService = new StarService();
//		MovieBean mb = starService.selectStar(name, movieSeq, grade);
		
		request.setAttribute("grade", grade);
		System.out.println("grade : " + grade);
		
		response.setCharacterEncoding("UTF-8");
		PrintWriter out = response.getWriter();
		
			switch (grade) {
			case 1:
				out.print("1");
				break;
	
			case 2:
				out.print("2");
				break;
				
			case 3:
				out.print("3");
				break;
				
			case 4:
				out.print("4");
				break;
				
			case 5:
				out.print("5");
				break;
			}
		
		return forward;
	}

}
