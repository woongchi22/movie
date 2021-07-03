package api;

import java.io.*;
import java.net.*;

public class kmdbApi {
	
	public String getBoxoffice(String openDt, String movieNm) throws IOException {
		System.out.println("kmdbApi-getBoxOffice");
//		StringBuilder urlBuilder = new StringBuilder(
//				"http://api.koreafilm.or.kr/openapi-data2/wisenut/search_api/search_json.jsp?collection=kmdb_new2&listCount=100&ServiceKey=319276GM630XRTRNIWN8");
		
		StringBuilder urlBuilder = new StringBuilder(
				"http://api.koreafilm.or.kr/openapi-data2/wisenut/search_api/search_json2.jsp?collection=kmdb_new2&listCount=100&title="
						+ movieNm + "&repRlsDate=" + openDt + "&ServiceKey=319276GM630XRTRNIWN8");
		
		
		
		/* URL */
//		urlBuilder.append("&" + URLEncoder.encode("releaseDts", "UTF-8") + "=" + URLEncoder.encode(openDt, "UTF-8")); // 개봉일
//		urlBuilder.append("&" + URLEncoder.encode("title", "UTF-8") + "=" + URLEncoder.encode(movieNm, "UTF-8")); // 영화명
//		urlBuilder.append("&" + URLEncoder.encode("val002", "UTF-8") + "=" + URLEncoder.encode("01", "UTF-8")); /* 상영 월 */
		
		URL url = new URL(urlBuilder.toString());
		System.out.println(url);
		
		System.out.println("==========");
		HttpURLConnection conn = (HttpURLConnection) url.openConnection();
		conn.setRequestMethod("GET");
		conn.setRequestProperty("Content-type", "application/json");
		System.out.println("Response code: " + conn.getResponseCode());

		BufferedReader rd;
		if (conn.getResponseCode() >= 200 && conn.getResponseCode() <= 300) {
			rd = new BufferedReader(new InputStreamReader(conn.getInputStream()));
		} else {
			rd = new BufferedReader(new InputStreamReader(conn.getErrorStream()));
		}
		StringBuilder sb = new StringBuilder();
		String line;
		while ((line = rd.readLine()) != null) {
			sb.append(line + "\n");
		}
		
		System.out.println("----------------");
		System.out.println(sb.toString());
		rd.close();
		conn.disconnect();

		return sb.toString();
	}
  
	// 영화 검색
	public String getMovie(String title) throws IOException { 
		System.out.println("kmdb - getMovie");
		
//		/*URL*/ 
		StringBuilder urlBuilder = new StringBuilder(
				"http://api.koreafilm.or.kr/openapi-data2/wisenut/search_api/search_json2.jsp?collection=kmdb_new2&listCount=100&title=" + title + "&ServiceKey=319276GM630XRTRNIWN8");
//		StringBuilder urlBuilder = new StringBuilder("http://api.koreafilm.or.kr/openapi-data2/wisenut/search_api/search_json2.jsp?collection=kmdb_new2&nation=대한민국");

		URL url = new URL(urlBuilder.toString());
		HttpURLConnection con = (HttpURLConnection) url.openConnection();
		con.setRequestMethod("GET");
		con.setRequestProperty("Content-type", "application/json");
		System.out.println("Response code: " + con.getResponseCode());
		
		BufferedReader rd;
		if(con.getResponseCode() >= 200 && con.getResponseCode() <=300) {
			rd = new BufferedReader(new InputStreamReader(con.getInputStream()));
		} else {
			rd = new BufferedReader(new InputStreamReader(con.getErrorStream())); 
		}
		
		StringBuilder sb = new StringBuilder();
		String line;
		while ((line = rd.readLine()) != null) {
			sb.append(line + "\n");
		}
		
		rd.close(); 
		con.disconnect(); 
		System.out.println(sb.toString());
		
		return sb.toString();
		
	}

	public String getMovieDetail(String query, String movieSeq) throws IOException {
		System.out.println("kmdb - getMovieDetail");
		
		StringBuilder urlBuilder = new StringBuilder(
				"http://api.koreafilm.or.kr/openapi-data2/wisenut/search_api/search_json2.jsp?collection=kmdb_new2&listCount=100&ServiceKey=319276GM630XRTRNIWN8");
		
		urlBuilder.append("&" + URLEncoder.encode("title","UTF-8") + "=" + URLEncoder.encode(query,"UTF-8"));
		urlBuilder.append("&" + URLEncoder.encode("movieSeq","UTF-8") + "=" + movieSeq);
		
//		/*상영년도*/ 
//		urlBuilder.append("&" + URLEncoder.encode("val001","UTF-8") + "=" + URLEncoder.encode("2018", "UTF-8")); 
//		/*상영 월*/ 
//		urlBuilder.append("&" + URLEncoder.encode("val002","UTF-8") + "=" + URLEncoder.encode("01", "UTF-8"));

		URL url = new URL(urlBuilder.toString());
		HttpURLConnection con = (HttpURLConnection) url.openConnection();
		con.setRequestMethod("GET");
		con.setRequestProperty("Content-type", "application/json");
		System.out.println("Response code: " + con.getResponseCode());
		
		BufferedReader rd;
		if(con.getResponseCode() >= 200 && con.getResponseCode() <=300) {
			rd = new BufferedReader(new InputStreamReader(con.getInputStream()));
		} else {
			rd = new BufferedReader(new InputStreamReader(con.getErrorStream())); 
		}
		
		StringBuilder sb = new StringBuilder();
		String line;
		while ((line = rd.readLine()) != null) {
			sb.append(line + "\n");
		}
    
		rd.close(); 
		con.disconnect(); 
		System.out.println(sb.toString());
		
		return sb.toString();
		
	}

	// 감독 검색
	public String getDirector(String director) throws IOException {
		System.out.println("kmdb - getDirector");
		
		StringBuilder urlBuilder = new StringBuilder(
				"http://api.koreafilm.or.kr/openapi-data2/wisenut/search_api/search_json2.jsp?collection=kmdb_new2&listCount=100&director=" + director + "&ServiceKey=319276GM630XRTRNIWN8");

		URL url = new URL(urlBuilder.toString());
		HttpURLConnection con = (HttpURLConnection) url.openConnection();
		con.setRequestMethod("GET");
		con.setRequestProperty("Content-type", "application/json");
		System.out.println("Response code: " + con.getResponseCode());
		
		BufferedReader rd;
		if(con.getResponseCode() >= 200 && con.getResponseCode() <=300) {
			rd = new BufferedReader(new InputStreamReader(con.getInputStream()));
		} else {
			rd = new BufferedReader(new InputStreamReader(con.getErrorStream())); 
		}
		
		StringBuilder sb = new StringBuilder();
		String line;
		while ((line = rd.readLine()) != null) {
			sb.append(line + "\n");
		}
		
		rd.close(); 
		con.disconnect(); 
		System.out.println(sb.toString());
		
		return sb.toString();
		
	}

	// 배우 검색
	public String getActor(String actor) throws IOException {
		System.out.println("kmdb - getActor");
		
		StringBuilder urlBuilder = new StringBuilder(
				"http://api.koreafilm.or.kr/openapi-data2/wisenut/search_api/search_json2.jsp?collection=kmdb_new2&listCount=100&actor=" + actor + "&ServiceKey=319276GM630XRTRNIWN8");

		URL url = new URL(urlBuilder.toString());
		HttpURLConnection con = (HttpURLConnection) url.openConnection();
		con.setRequestMethod("GET");
		con.setRequestProperty("Content-type", "application/json");
		System.out.println("Response code: " + con.getResponseCode());
		
		BufferedReader rd;
		if(con.getResponseCode() >= 200 && con.getResponseCode() <=300) {
			rd = new BufferedReader(new InputStreamReader(con.getInputStream()));
		} else {
			rd = new BufferedReader(new InputStreamReader(con.getErrorStream())); 
		}
		
		StringBuilder sb = new StringBuilder();
		String line;
		while ((line = rd.readLine()) != null) {
			sb.append(line + "\n");
		}
		
		rd.close(); 
		con.disconnect(); 
		System.out.println(sb.toString());
		
		return sb.toString();
		
	}

	// 키워드 검색
	public String getKeyword(String keyword) throws IOException {
		System.out.println("kmdb - getKeyword");
		
		StringBuilder urlBuilder = new StringBuilder(
				"http://api.koreafilm.or.kr/openapi-data2/wisenut/search_api/search_json2.jsp?collection=kmdb_new2&listCount=100&keyword=" + keyword + "&ServiceKey=319276GM630XRTRNIWN8");

		URL url = new URL(urlBuilder.toString());
		HttpURLConnection con = (HttpURLConnection) url.openConnection();
		con.setRequestMethod("GET");
		con.setRequestProperty("Content-type", "application/json");
		System.out.println("Response code: " + con.getResponseCode());
		
		BufferedReader rd;
		if(con.getResponseCode() >= 200 && con.getResponseCode() <=300) {
			rd = new BufferedReader(new InputStreamReader(con.getInputStream()));
		} else {
			rd = new BufferedReader(new InputStreamReader(con.getErrorStream())); 
		}
		
		StringBuilder sb = new StringBuilder();
		String line;
		while ((line = rd.readLine()) != null) {
			sb.append(line + "\n");
		}
		
		rd.close(); 
		con.disconnect(); 
		System.out.println(sb.toString());
		
		return sb.toString();
	}
	
}

