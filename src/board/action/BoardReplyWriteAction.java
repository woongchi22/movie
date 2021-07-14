package board.action;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import action.Action;
import board.svc.BoardReplyService;
import board.vo.ReplyBean;
import vo.ActionForward;

public class BoardReplyWriteAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		request.setCharacterEncoding("UTF-8");
		System.out.println("BoardReplyWriteAction");
		ActionForward forward = null;
		
		int movieSeq = Integer.parseInt(request.getParameter("movieSeq"));
		String content = (String) request.getParameter("content");
		int idx = Integer.parseInt(request.getParameter("idx"));
		HttpSession session = request.getSession();
		String name = (String) session.getAttribute("name");
		
		ReplyBean replyBean = new ReplyBean();
		replyBean.setIdx(idx);
		replyBean.setName(name);
		replyBean.setMovieSeq(movieSeq);
		replyBean.setContent(content);
		
		System.out.println("======================");
		System.out.println(content+idx+name+movieSeq);
		System.out.println(replyBean.getContent());
		
		BoardReplyService boardReplyService = new BoardReplyService();
		boolean isSuccess = boardReplyService.insertReply(replyBean, idx);
		
		if(!isSuccess) {
			response.setContentType("text/html;charset=UTF-8");
			PrintWriter out = response.getWriter();
			out.println("<script>"); 
			out.println("alert('글 등록 실패!')");
			out.println("history.back()"); 
			out.println("</script>"); 
		}else { 
			request.setAttribute("replyBean", replyBean);
		}
			
		
	    return forward;
	}

}
