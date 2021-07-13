package board.action;

import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;

import action.Action;
import board.svc.BoardReviewListService;
import board.vo.ReviewBean;
import vo.ActionForward;

public class BoardReviewListAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		request.setCharacterEncoding("UTF-8");
		System.out.println("BoardReviewListAction@@@@@@@@@@");
		System.out.println("왜안떠");
		ActionForward forward = null;

		
//		
		
		int movieSeq = Integer.parseInt(request.getParameter("movieSeq"));
		String title = (String) request.getParameter("query");
		HttpSession session = request.getSession();
		String name = (String)request.getAttribute("name");
//		
		System.out.println(movieSeq+title+name);
//		
		BoardReviewListService boardReviewListService = new BoardReviewListService();
		ArrayList<ReviewBean> reviewList = boardReviewListService.getReview(movieSeq);

		request.setAttribute("reviewList", reviewList);
//		
//		String json = null;
//		for (int i = 0; i < reviewList.size(); i++) {
//			name = reviewList.get(i).getName();
//			String content = reviewList.get(i).getContent();
//			Date date = reviewList.get(i).getdDate();
//			SimpleDateFormat df = new SimpleDateFormat("YY.MM.dd");
//			
//			json += "[{\"name\":\"" + name + "\"},";
//			json += "{\"content\":\"" + content + "\"},";
//			json += "{\"date\":\"" + df.format(date) + "\"},";
//		};
//		
//		System.out.println(json);
//		request.setAttribute("json", json);
//		
//		response.setContentType("application/json;charset=UTF-8");
//
//		
		
		
//		response.setContentType("application/json;charset=UTF-8");
//		PrintWriter out = response.getWriter();
//		out.print(json);
//		out.flush();
//		
//		
//		String json = "{\"replyList\":[";
//		
//		for (int i = 0; i < reviewList.size(); i++) {
//			name = reviewList.get(i).getName();
//			String content = reviewList.get(i).getContent();
//			Date date = reviewList.get(i).getdDate();
//			SimpleDateFormat df = new SimpleDateFormat("YY-MM-dd");
//			
//			json += "[{\"name\":\"" + name + "\"},";
//			json += "{\"content\":\"" + content + "\"},";
//			json += "{\"date\":\"" + df.format(date) + "\"},";
//			
//			if (i != reviewList.size() - 1) {
//				json += ",";
//			}
//		}
//		json += "]}";
//		
//		
//			out.print(json);
		
		forward = new ActionForward();
		forward.setPath("/board/reviewView.jsp");
		
		return forward;
	}

}
