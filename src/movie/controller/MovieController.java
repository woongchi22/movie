package movie.controller;

import java.io.IOException;

import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import action.Action;
import member.action.*;
import movie.action.*;
import vo.*;

@WebServlet("*.mo")
public class MovieController extends HttpServlet {
	protected void doProcess(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		request.setCharacterEncoding("UTF-8");
		String command = request.getServletPath();
		
		Action action = null;
		ActionForward forward = null;
		System.out.println(command);
		
		
		// 검색 버튼 
		if(command.equals("/MovieSearch.mo")) {
			forward = new ActionForward();
			forward.setPath("/movie/movie_search.jsp");
			
		
		// 영화 검색(한국,외국)	
		} else if(command.equals("/SearchMoviePro.mo")) {
			action = new SearchMovieProAction();
			try {
				forward = action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
			
		// 감독 검색	
		} else if(command.equals("/DirectorSearchPro.mo")) {
			action = new DirectorSearchProAction();
			try {
				forward = action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
			
		// 배우 검색	
		} else if(command.equals("/ActorSearchPro.mo")) {
			action = new ActorSearchProAction();
			try {
				forward = action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
			
		// 키워드 검색	
		} else if(command.equals("/KeywordSearchPro.mo")) {
			action = new KeywordSearchProAction();
			try {
				forward = action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
			
		// 박스오피스	
		} else if(command.equals("/BoxOffice.mo")) {
			action = new MovieBoxOfficeAction();
			try {
				action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
			
		} else if(command.equals("/BoxOfficeNation.mo")) {
			action = new MovieBoxOfficeNationAction();
			try {
				action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
			
		// 영화 상세 정보	
		} else if(command.equals("/MovieDetailPro.mo")) {
			action = new MovieDetailProAction();
			try {
				forward = action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
			
		} else if(command.equals("/MovieDetail.mo")) {
					action = new MovieDetailAction();
					try {
						forward = action.execute(request, response);
					} catch (Exception e) {
						e.printStackTrace();
					}
		}
					
		
		
//		if(command.equals("/MovieGetChart.mo")) {
//			action = new getMovieByChartAction();
//			try {
//				action.execute(request, response);
//			} catch (Exception e) {
//				e.printStackTrace();
//			}
//		}
		
		
		
	
	
		if(forward != null) {
			if(forward.isRedirect()) {
				response.sendRedirect(forward.getPath());
			}else {
				RequestDispatcher dispatcher = request.getRequestDispatcher(forward.getPath());
				dispatcher.forward(request, response);
			}
		}
		
	}
	
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doProcess(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doProcess(request, response);
	}

}
