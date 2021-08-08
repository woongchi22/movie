package mypage.action;

import java.io.*;

import javax.servlet.http.*;

import action.*;
import mypage.svc.*;
import mypage.vo.*;
import vo.*;

public class MypageCollectionCreateAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("MypageCollectionCreateAction");
		ActionForward forward = null;
		HttpSession session = request.getSession();
		String name = (String)session.getAttribute("name");
		String[] title = request.getParameterValues("title");
		String[] movieSeq = request.getParameterValues("movieSeq");
		String[] poster = request.getParameterValues("poster");
		String subject = request.getParameter("subject");
		String content = request.getParameter("content");
		String joinTitle = String.join(",", title);
		String joinPoster = String.join(",", poster);
		String joinMovieSeq = String.join("," , movieSeq);
		
		System.out.println(name);
		System.out.println(subject);
		System.out.println(content);
		
		int[] intArr = null;
		if( movieSeq != null ){
		intArr = new int[ movieSeq.length ];
		for( int i=0;i <movieSeq.length; i++ ) {
			intArr[i] = Integer.parseInt( movieSeq[i] );
			}
		}
		
		CollectionBean collectionBean = new CollectionBean();
		collectionBean.setCollection_name(subject);
		collectionBean.setContent(content);
		collectionBean.setName(name);
		collectionBean.setPoster(joinPoster);
		collectionBean.setTitle(joinTitle);
		collectionBean.setMovieSeq(joinMovieSeq);
		
		MypageAddCollectionService mypageAddCollectionService = new MypageAddCollectionService();
		boolean isSuccess = mypageAddCollectionService.addCollection(collectionBean);
		
		if(isSuccess) {
			response.setContentType("text/html;charset=UTF-8");
			PrintWriter out = response.getWriter();
			out.println("<script>");
			out.println("alert('등록되었습니다')");
			out.println("window.location.href = 'MypageCollection.mp'");
			out.println("</script>");
		}
		
		return forward;
	}

}
