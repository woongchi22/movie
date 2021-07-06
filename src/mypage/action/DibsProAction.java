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
		
		String name = request.getParameter("name");
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
			out.println("<script>");
			out.println("alert('찜꽁 실패');");
			out.println("history.back();");
			out.println("</script>");
		} else {
			response.setContentType("text/html;charset=UTF-8");
			PrintWriter out = response.getWriter();
			out.print("Y");
		}
		
		
		return null;
	}

}
