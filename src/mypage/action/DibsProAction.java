package mypage.action;

import java.io.*;

import javax.servlet.http.*;

import action.*;
import mypage.svc.*;
import mypage.vo.*;
import vo.*;

public class DibsProAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("DibsProAction!!!!");
		
		HttpSession session = request.getSession();
		String name = (String) session.getAttribute("name");
		
		int movieSeq = Integer.parseInt(request.getParameter("movieSeq"));
		String title = request.getParameter("query");
		String poster = request.getParameter("poster");
		String dibs = request.getParameter("dibs");
		System.out.println(dibs + name + movieSeq + title + poster);
		
		DibsBean db = new DibsBean();
		db.setName(name);
		db.setMovieSeq(movieSeq);
		db.setTitle(title);
		db.setPoster(poster);
		db.setDibs(dibs);
		
		boolean isInsert = false;
		
		DibsProService dibsProService = new DibsProService();
		isInsert = dibsProService.dibs(db);
		
		if(!isInsert) {
			response.setContentType("text/html;charset=UTF-8");
			PrintWriter out = response.getWriter();
			out.print("N");
			out.flush();
			
		} else {
			response.setContentType("text/html;charset=UTF-8");
			PrintWriter out = response.getWriter();
			out.print("Y");
			out.flush();
		}
		
		return null;
	}

}
