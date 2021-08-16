package mypage.action;

import java.io.*;
import java.util.*;

import javax.servlet.http.*;

import org.json.simple.*;

import action.*;
import mypage.svc.*;
import mypage.vo.*;
import vo.*;

public class CollectionListAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("CollectionListAction");
		
		ActionForward forward = null;
		
		String name = request.getParameter("name");
		System.out.println(name);
		
		CollectionListService collectionListService = new CollectionListService();
		ArrayList<CollectionBean> collectionList = collectionListService.getCollection();
		
		JSONArray jsonArray = new JSONArray();
		JSONObject json = null;
		
		for(int i=0; i<collectionList.size(); i++) {
			json = new JSONObject();
			
			CollectionBean cb = (CollectionBean) collectionList.get(i);
			json.put("idx", cb.getIdx());
			json.put("name", cb.getName());
			json.put("collection_name", cb.getCollection_name());
			json.put("movieSeq", cb.getMovieSeq());
			json.put("title", cb.getTitle());
			json.put("poster", cb.getPoster());
			jsonArray.add(json);
		}
		
		response.setContentType("application/json;charset=UTF-8");
		PrintWriter out = response.getWriter();
		System.out.println(jsonArray);
		out.print(jsonArray.toString());
		out.flush();
		out.close();
		
		return forward;
	}

}
