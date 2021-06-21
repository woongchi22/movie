package member.controller;

import java.io.IOException;

import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import action.*;
import member.action.*;
import vo.*;

@WebServlet("*.me")
public class MemberController extends HttpServlet {
	protected void doProcess(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		String command = request.getServletPath();
		System.out.println(command);
		
		Action action = null;
		ActionForward forward = null;
		
		// 회원가입
		if(command.equals("/MemberJoinForm.me")) {
			forward = new ActionForward();
			forward.setPath("/member/member_join.jsp");
		} else if(command.equals("/MemberJoinPro.me")) {
			try {
				action = new MemberJoinProAction();
				forward = action.excute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		// 로그인
		if(command.equals("/MemberLoginForm.me")) {
			forward = new ActionForward();
			forward.setPath("/member/member_login.jsp");
		} else if(command.equals("/MemberLoginPro.me")) {
			try {
				action = new MemberLoginProAction();
				forward = action.excute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		// 이메일 찾기
		if(command.equals("/ForgetEmail.me")) {
			forward = new ActionForward();
			forward.setPath("/member/forget_email.jsp");
		}
		
		


		
		
		
		
		
		
		
		if(forward != null) {
			if(forward.isRedirect()) {
				response.sendRedirect(forward.getPath());
			} else {
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
