package mypage.action;

import javax.servlet.http.*;

import action.*;
import mypage.vo.*;
import vo.*;

public class MypageCollectionMovieAddAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("MypageCollectionMovieAdd");
		ActionForward forward = null;
		String name = request.getParameter("name");
		String movieSeq = request.getParameter("movieSeq");
		String title = request.getParameter("title");
		String poster = request.getParameter("poster");
		CollectionBean collectionBean = new CollectionBean();
		System.out.println("-------------------액션-----------------");
		collectionBean.setName(name);
		collectionBean.setMovieSeq(movieSeq);
		collectionBean.setTitle(title);
		collectionBean.setPoster(poster);
		
		System.out.println(collectionBean.getMovieSeq());
		return forward;
	}

}
