package mypage.action;

import java.io.*;
import java.util.*;

import javax.servlet.http.*;

import action.*;
import mypage.svc.*;
import mypage.vo.*;
import vo.*;

public class DibsAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("DibsAction!!!");
		
		ActionForward forward = null;
		
		HttpSession session = request.getSession();
		String name = (String) session.getAttribute("name");
		int movieSeq = Integer.parseInt(request.getParameter("movieSeq"));
		
		DibsService dibsService = new DibsService();
		DibsBean db = dibsService.selectDibs(name, movieSeq);
		
		request.setAttribute("db", db);
		System.out.println(db);
		
		if(db == null) {
			response.setCharacterEncoding("UTF-8");
			PrintWriter out = response.getWriter();
			out.print("N");
			
		} else {
			response.setCharacterEncoding("UTF-8");
			PrintWriter out = response.getWriter();
			out.print("Y");
		}
		
		return forward;
		
	}

}
