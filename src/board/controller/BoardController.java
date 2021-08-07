package board.controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import action.Action;
import board.action.*;
import vo.ActionForward;

@WebServlet("*.bo")
public class BoardController extends HttpServlet {
    protected void doProcess(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	
    	request.setCharacterEncoding("UTF-8");
    	String command = request.getServletPath();
    	System.out.println(command);
    	
    	
    	Action action= null;
    	ActionForward forward = null;
    	
    	// 리뷰 List
    	if(command.equals("/BoardReviewList.bo")) {
    		action = new BoardReviewListAction();
    		try {
				forward=action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
    		
    	// 리뷰 등록	
    	} else if(command.equals("/BoardReviewWrite.bo")) {
        	action = new BoardReviewWriteAction();
        	try {
    			forward = action.execute(request, response);
    		} catch (Exception e) {
    			e.printStackTrace();
    		}
        
        // 리뷰 수정	
        } else if(command.equals("/BoardReviewUpdate.bo")) {
			action = new BoardReviewUpdateAction();
			try {
				forward = action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
    	
		// 리뷰 삭제 
    	} else if (command.equals("/BoardReviewDelete.bo")) {
			action = new BoardReviewDeleteAction();
			try {
				forward = action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
			
		// 코멘트 가져오기	
    	} else if(command.equals("/GetContent.bo")) {
    		action = new GetContentAction();
    		try {
    			forward = action.execute(request, response);
    		} catch (Exception e) {
    			e.printStackTrace();
    		}
    		
    	// 리뷰 좋아요
    	} else if(command.equals("/BoardReviewLike.bo")) {
    		action = new BoardReviewLikeAction();
    		try {
				forward = action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
    	
    	// 마이페이지 리스트
    	} else if(command.equals("/BoardMyReviewList.bo")) {
    		action = new BoardMyReviewListAction();
    		try {
				forward = action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
    	}
    	
    	
    	
//    	if(command.equals("/BoardReply.bo")) {
//	    	action = new BoardReplyAction();
//	    	try {
//				forward = action.execute(request, response);
//			} catch (Exception e) {
//				e.printStackTrace();
//			}
//    	}
//    	  if(command.equals("/BoardReplyWrite.bo")) {
//    		  action = new BoardReplyWriteAction();
//    		  try {
//				forward = action.execute(request, response);
//			} catch (Exception e) {
//				e.printStackTrace();
//			}
//    	  }
//    	  if(command.equals("/BoardReplyUpdate.bo")) {
//	  		  action = new BoardReplyUpdateAction();
//	  		  try {
//				  forward = action.execute(request, response);
//				} catch (Exception e) {
//					e.printStackTrace();
//				}
//	  	  }
//    	  if (command.equals("/BoardReplyDelete.bo")) {
//			action = new BoardReplyDeleteAction();
//			try {
//				forward = action.execute(request, response);
//			} catch (Exception e) {
//				e.printStackTrace();
//			}
//    	} 
			
    	  
    	  
    	  
    	  
    	  
    	  
    	  
    	  
    	  
    	
    if(forward !=null ) {
    	if(forward.isRedirect()){
    		response.sendRedirect(forward.getPath());
    	}else {
    		RequestDispatcher dispatcher = request.getRequestDispatcher(forward.getPath());
    		dispatcher.forward(request, response);
    	}
    }
    
  
    
    
    }
    
    
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doProcess(request, response);
	
	}
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doProcess(request, response);
	}

}
