package board.controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import action.Action;
import board.action.BoardReplyAction;
import board.action.BoardReplyWriteAction;
import board.action.BoardReviewListAction;
import board.action.BoardReviewUpdateAction;
import board.action.BoardReviewWriteAction;
import vo.ActionForward;

@WebServlet("*.bo")
public class BoardController extends HttpServlet {
    protected void doProcess(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	
    	request.setCharacterEncoding("UTF-8");
    	String command = request.getServletPath();
    	System.out.println(command);
    	
    	
    	Action action= null;
    	ActionForward forward = null;
    	
    	if(command.equals("/BoardReviewList.bo")) {
    		action = new BoardReviewListAction();
    		try {
				forward=action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
    	}
    	if(command.equals("/BoardReviewWrite.bo")) {
        	action = new BoardReviewWriteAction();
        	try {
    			forward = action.execute(request, response);
    		} catch (Exception e) {
    			e.printStackTrace();
    		}
        }
    
    	  if(command.equals("/BoardReply.bo")) {
    	action = new BoardReplyAction();
    	try {
			forward = action.execute(request, response);
		} catch (Exception e) {
			e.printStackTrace();
		}
    }
    	  if(command.equals("/BoardReplyWrite.bo")) {
    		  action = new BoardReplyWriteAction();
    		  try {
				forward = action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
    	  }
    	  if(command.equals("/BoardReviewUpdate.bo")) {
    		  action = new BoardReviewUpdateAction();
    		  try {
				forward = action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
    	  }
    	
    	
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
