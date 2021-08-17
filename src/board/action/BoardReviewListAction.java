package board.action;

import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import com.sun.javafx.collections.MappingChange.Map;

import action.Action;
import board.svc.BoardReviewListService;
import board.vo.ReviewBean;
import vo.ActionForward;

public class BoardReviewListAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		request.setCharacterEncoding("UTF-8");
		ActionForward forward = null;

		int movieSeq = Integer.parseInt(request.getParameter("movieSeq"));
		String title = (String) request.getParameter("query");
//		System.out.println(movieSeq + title);

		BoardReviewListService boardReviewListService = new BoardReviewListService();
		ArrayList<ReviewBean> reviewList = boardReviewListService.getReview(movieSeq);
		
		request.setAttribute("reviewList", reviewList);
		
		forward = new ActionForward();
		forward.setPath("/board/reviewView.jsp");
		
		return forward;
	}

}
