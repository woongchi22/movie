package mypage.action;

import java.io.*;

import javax.servlet.http.*;

import action.*;
import mypage.svc.*;
import mypage.vo.*;
import vo.*;

public class MypageCollectionUpdateAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("MypageCollectionUpdateAction@@@@@@@@@@@");

		ActionForward forward = null;
		HttpSession session = request.getSession();
		String name = (String)session.getAttribute("name");
		String[] title = request.getParameterValues("title");
		String[] movieSeq = request.getParameterValues("movieSeq");
		String[] poster = request.getParameterValues("poster");
		String collection_name = request.getParameter("collection_name");
		System.out.println(collection_name);
		
		if (title == null) {
			MypageAddCollectionService mypageAddCollectionService = new MypageAddCollectionService();
			boolean isSuccess = mypageAddCollectionService.deleteCollection(collection_name);
			
			if(isSuccess) {
				response.setContentType("text/html;charset=UTF-8");
				PrintWriter out = response.getWriter();
				out.println("<script>");
				out.println("alert('삭제되었습니다')");
				out.println("window.location.href = 'MypageCollection.mp'");
				out.println("</script>");
			}
			
		} else {
			int idx = Integer.parseInt(request.getParameter("idx"));
			System.out.println(movieSeq);
			String joinTitle = String.join("&", title);
			String joinPoster = String.join(",", poster);
			String joinMovieSeq = String.join("," , movieSeq);
			
			System.out.println("joinMovieSeq : "+joinMovieSeq);
			
			for(int i = 0; i<poster.length;i++) {
				System.out.println((i+1)+"번째 포스터값 : " + poster[i]);
			}
			System.out.println(joinTitle + joinPoster + joinMovieSeq);
			CollectionBean collectionBean = new CollectionBean();
			collectionBean.setName(name);;
			collectionBean.setPoster(joinPoster);
			collectionBean.setTitle(joinTitle);
			collectionBean.setMovieSeq(joinMovieSeq);
			collectionBean.setIdx(idx);
			
			MypageAddCollectionService mypageAddCollectionService = new MypageAddCollectionService();
			boolean isSuccess = mypageAddCollectionService.updateCollection(collectionBean);
			
			if(isSuccess) {
				response.setContentType("text/html;charset=UTF-8");
				PrintWriter out = response.getWriter();
				out.println("<script>");
				out.println("alert('수정되었습니다')");
				out.println("window.location.href = 'MypageCollection.mp'");
				out.println("</script>");
			}
		}
		
		return forward;
	}

}
