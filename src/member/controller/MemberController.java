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
			action = new MemberJoinProAction();
			try {
				forward = action.excute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
		
		// 로그인	
		} else if(command.equals("/MemberLoginForm.me")) { 
			forward = new ActionForward();
			forward.setPath("/member/member_login.jsp");
		} else if(command.equals("/MemberLoginPro.me")) {
			action = new MemberLoginProAction();
			try {
				forward = action.excute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
			
		// 이메일 중복 체크	
		} else if(command.equals("/dupEmail.me")) {
			action = new MemberEmailAction();
			try {
				forward = action.excute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
			
		// 비밀번호 찾기
		} else if(command.equals("/ForgetPassForm.me")) {
			forward = new ActionForward();
			forward.setPath("/member/forget_pass.jsp");
		} else if(command.equals("/ForgetPassPro.me")) {
			action = new ForgetPassProAction();
			try {
				forward = action.excute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
			
		// 관리자 회원 리스트
		} else if(command.equals("/MemberList.me")) {
			action = new MemberListAction();
			try {
				forward = action.excute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
		
		// 마이페이지
		}else if(command.equals("/Mypage.me")) { 
			forward = new ActionForward();
			forward.setPath("/mypage/mypage.jsp");
			
		// 로그아웃	
		} else if(command.equals("/MemberLogout.me")) {
			action = new MemberLogoutAction();
			try {
				forward = action.excute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
			
		// 메인	
		} else if(command.equals("/Main.me")) {
			forward = new ActionForward();
			forward.setPath("/index.jsp");
			
			
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
