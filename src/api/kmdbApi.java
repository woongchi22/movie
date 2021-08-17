package api;

import java.io.*;
import java.net.*;

public class kmdbApi {
	
	// 박스오피스
	public String getBoxoffice(String openDt, String movieNm) throws IOException {
		StringBuilder urlBuilder = new StringBuilder(
				"http://api.koreafilm.or.kr/openapi-data2/wisenut/search_api/search_json2.jsp?collection=kmdb_new2&listCount=50&releaseDts="
						+ openDt + "&title=" + movieNm + "&ServiceKey=319276GM630XRTRNIWN8");
		
		URL url = new URL(urlBuilder.toString());
		
		HttpURLConnection conn = (HttpURLConnection) url.openConnection();
		conn.setRequestMethod("GET");
		conn.setRequestProperty("Content-type", "application/json");

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
		
//		System.out.println(sb.toString());
		rd.close();
		conn.disconnect();

		return sb.toString();
	}

	// 영화 상세보기
	public String getMovieDetail(String query, String movieSeq) throws IOException {
		StringBuilder urlBuilder = new StringBuilder(
				"http://api.koreafilm.or.kr/openapi-data2/wisenut/search_api/search_json2.jsp?collection=kmdb_new2&listCount=100&title="
						+query+"&movieSeq="+movieSeq+"&ServiceKey=319276GM630XRTRNIWN8");

		URL url = new URL(urlBuilder.toString());
		HttpURLConnection con = (HttpURLConnection) url.openConnection();
		con.setRequestMethod("GET");
		con.setRequestProperty("Content-type", "application/json");
		
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
//		System.out.println(sb.toString());
		
		return sb.toString();
	}
	
	// 제목 검색(한국, 외국)
	public String getTitle(String title) throws IOException {
		StringBuilder urlBuilder = new StringBuilder(
				"http://api.koreafilm.or.kr/openapi-data2/wisenut/search_api/search_json2.jsp?collection=kmdb_new2&listCount=100&title="
						+ title + "&ServiceKey=319276GM630XRTRNIWN8");

		URL url = new URL(urlBuilder.toString());
		HttpURLConnection con = (HttpURLConnection) url.openConnection();
		con.setRequestMethod("GET");
		con.setRequestProperty("Content-type", "application/json");
		
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
//		System.out.println(sb.toString());
		
		return sb.toString();
	}

	// 감독 검색
	public String getDirector(String director) throws IOException {
		StringBuilder urlBuilder = new StringBuilder(
				"http://api.koreafilm.or.kr/openapi-data2/wisenut/search_api/search_json2.jsp?collection=kmdb_new2&listCount=100&director="
						+ director + "&ServiceKey=319276GM630XRTRNIWN8");

		URL url = new URL(urlBuilder.toString());
		HttpURLConnection con = (HttpURLConnection) url.openConnection();
		con.setRequestMethod("GET");
		con.setRequestProperty("Content-type", "application/json");
		
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
//		System.out.println(sb.toString());
		
		return sb.toString();
	}

	// 배우 검색
	public String getActor(String actor) throws IOException {
		StringBuilder urlBuilder = new StringBuilder(
				"http://api.koreafilm.or.kr/openapi-data2/wisenut/search_api/search_json2.jsp?collection=kmdb_new2&listCount=100&actor="
						+ actor + "&ServiceKey=319276GM630XRTRNIWN8");

		URL url = new URL(urlBuilder.toString());
		HttpURLConnection con = (HttpURLConnection) url.openConnection();
		con.setRequestMethod("GET");
		con.setRequestProperty("Content-type", "application/json");
		
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
//		System.out.println(sb.toString());
		
		return sb.toString();
	}

	// 키워드 검색
	public String getKeyword(String keyword) throws IOException {
		StringBuilder urlBuilder = new StringBuilder(
				"http://api.koreafilm.or.kr/openapi-data2/wisenut/search_api/search_json2.jsp?collection=kmdb_new2&listCount=100&keyword="
						+ keyword + "&ServiceKey=319276GM630XRTRNIWN8");

		URL url = new URL(urlBuilder.toString());
		HttpURLConnection con = (HttpURLConnection) url.openConnection();
		con.setRequestMethod("GET");
		con.setRequestProperty("Content-type", "application/json");
		
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
//		System.out.println(sb.toString());
		
		return sb.toString();
	}

	// 평가할 영화 랜덤 가져오기
	public String getMovieGrade(int startCount) throws IOException {
		StringBuilder urlBuilder = new StringBuilder(
				"http://api.koreafilm.or.kr/openapi-data2/wisenut/search_api/search_json2.jsp?collection=kmdb_new2&listCount=100&startCount="
						+ startCount + "&createDts=1980&ServiceKey=319276GM630XRTRNIWN8");

		URL url = new URL(urlBuilder.toString());
		HttpURLConnection con = (HttpURLConnection) url.openConnection();
		con.setRequestMethod("GET");
		con.setRequestProperty("Content-type", "application/json");
		
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
//		System.out.println(sb.toString());
		
		return sb.toString();
	}

	
	public String getMovieGenre(String genre) throws IOException {
		StringBuilder urlBuilder = new StringBuilder(
				"http://api.koreafilm.or.kr/openapi-data2/wisenut/search_api/search_json2.jsp?collection=kmdb_new2&listCount=1&genre="
						+ genre + "&createDts=1980&ServiceKey=319276GM630XRTRNIWN8");

		URL url = new URL(urlBuilder.toString());
		HttpURLConnection con = (HttpURLConnection) url.openConnection();
		con.setRequestMethod("GET");
		con.setRequestProperty("Content-type", "application/json");
		
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
//		System.out.println(sb.toString());
		
		return sb.toString();
	}

	
	public String getMovie(String nations, String genre) throws IOException {
		StringBuilder urlBuilder = new StringBuilder(
				"http://api.koreafilm.or.kr/openapi-data2/wisenut/search_api/search_json2.jsp?collection=kmdb_new2&listCount=1&nation="
						+ nations +"&genre="+genre+ "&createDts=1980&ServiceKey=319276GM630XRTRNIWN8");

		URL url = new URL(urlBuilder.toString());
		HttpURLConnection con = (HttpURLConnection) url.openConnection();
		con.setRequestMethod("GET");
		con.setRequestProperty("Content-type", "application/json");
		
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
//		System.out.println(sb.toString());
		
		return sb.toString();
	}


	public String getMovie(String nations) throws IOException {
		StringBuilder urlBuilder = new StringBuilder(
				"http://api.koreafilm.or.kr/openapi-data2/wisenut/search_api/search_json2.jsp?collection=kmdb_new2&listCount=1&nation="
						+ nations + "&createDts=1980&ServiceKey=319276GM630XRTRNIWN8");

		URL url = new URL(urlBuilder.toString());
		HttpURLConnection con = (HttpURLConnection) url.openConnection();
		con.setRequestMethod("GET");
		con.setRequestProperty("Content-type", "application/json");
		
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
//		System.out.println(sb.toString());
		
		return sb.toString();
	}

	//애니메이션,다큐
	public String getMovieType(String nations, String genre)throws IOException  {
		StringBuilder urlBuilder = new StringBuilder(
				"http://api.koreafilm.or.kr/openapi-data2/wisenut/search_api/search_json2.jsp?collection=kmdb_new2&listCount=1&nation="
						+ nations +"&type="+genre+ "&createDts=1980&ServiceKey=319276GM630XRTRNIWN8");

		URL url = new URL(urlBuilder.toString());
		HttpURLConnection con = (HttpURLConnection) url.openConnection();
		con.setRequestMethod("GET");
		con.setRequestProperty("Content-type", "application/json");
		
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
//		System.out.println(sb.toString());
		
		return sb.toString();
	}

	//애니메이션,다큐
	public String getMovieType(String genre) throws IOException {
		StringBuilder urlBuilder = new StringBuilder(
				"http://api.koreafilm.or.kr/openapi-data2/wisenut/search_api/search_json2.jsp?collection=kmdb_new2&listCount=1&type="
						+ genre + "&createDts=1980&ServiceKey=319276GM630XRTRNIWN8");

		URL url = new URL(urlBuilder.toString());
		HttpURLConnection con = (HttpURLConnection) url.openConnection();
		con.setRequestMethod("GET");
		con.setRequestProperty("Content-type", "application/json");
		
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
//		System.out.println(sb.toString());
		
		return sb.toString();
	}

	// 랜덤 탐색(국가)
	public String getStartMovie(String nations, int startCount) throws IOException{
		StringBuilder urlBuilder = new StringBuilder(
				"http://api.koreafilm.or.kr/openapi-data2/wisenut/search_api/search_json2.jsp?collection=kmdb_new2&listCount=100&nation="
						+ nations + "&createDts=1980&startCount=" + startCount + "&ServiceKey=319276GM630XRTRNIWN8");

		URL url = new URL(urlBuilder.toString());
		HttpURLConnection con = (HttpURLConnection) url.openConnection();
		con.setRequestMethod("GET");
		con.setRequestProperty("Content-type", "application/json");
		
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
//		System.out.println(sb.toString());
		
		return sb.toString();
	}

	// 랜덤탐색 (장르, 국가)
	public String getStartMovie(String nations, String genre, int startCount) throws IOException {
		StringBuilder urlBuilder = new StringBuilder(
				"http://api.koreafilm.or.kr/openapi-data2/wisenut/search_api/search_json2.jsp?collection=kmdb_new2&listCount=100&nation="
						+ nations + "&genre=" + genre + "&createDts=1980&startCount=" + startCount + "&ServiceKey=319276GM630XRTRNIWN8");

		URL url = new URL(urlBuilder.toString());
		HttpURLConnection con = (HttpURLConnection) url.openConnection();
		con.setRequestMethod("GET");
		con.setRequestProperty("Content-type", "application/json");
		
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
//		System.out.println(sb.toString());
		
		return sb.toString();
	}

	// 랜덤탐색 (애니/다큐)
	public String getStartMovieType(String genre, int startCount) throws IOException{
		StringBuilder urlBuilder = new StringBuilder(
				"http://api.koreafilm.or.kr/openapi-data2/wisenut/search_api/search_json2.jsp?collection=kmdb_new2&listCount=100&type="
						+ genre + "&createDts=1980&startCount=" + startCount + "&ServiceKey=319276GM630XRTRNIWN8");

		URL url = new URL(urlBuilder.toString());
		HttpURLConnection con = (HttpURLConnection) url.openConnection();
		con.setRequestMethod("GET");
		con.setRequestProperty("Content-type", "application/json");
		
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
//		System.out.println(sb.toString());
		
		return sb.toString();
	}

	// 랜덤탐색 (애니/다큐, 국가)
	public String getStartMovieType(String nations, String genre, int startCount) throws IOException{
		StringBuilder urlBuilder = new StringBuilder(
				"http://api.koreafilm.or.kr/openapi-data2/wisenut/search_api/search_json2.jsp?collection=kmdb_new2&listCount=100&type="
						+ genre + "&nation=" + nations + "&createDts=1980&startCount=" + startCount + "&ServiceKey=319276GM630XRTRNIWN8");

		URL url = new URL(urlBuilder.toString());
		HttpURLConnection con = (HttpURLConnection) url.openConnection();
		con.setRequestMethod("GET");
		con.setRequestProperty("Content-type", "application/json");
		
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
//		System.out.println(sb.toString());
		
		return sb.toString();
	}

	// 랜덤탐색 (장르)
	public String getStartMovieGenre(String genre, int startCount) throws IOException {
		StringBuilder urlBuilder = new StringBuilder(
				"http://api.koreafilm.or.kr/openapi-data2/wisenut/search_api/search_json2.jsp?collection=kmdb_new2&listCount=100&genre="
						+ genre + "&createDts=1980&startCount=" + startCount + "&ServiceKey=319276GM630XRTRNIWN8");

		URL url = new URL(urlBuilder.toString());
		HttpURLConnection con = (HttpURLConnection) url.openConnection();
		con.setRequestMethod("GET");
		con.setRequestProperty("Content-type", "application/json");
		
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
//		System.out.println(sb.toString());
		
		return sb.toString();
	}
	
	// 선호하는 영화 장르
	public String getGenre(String genre, String genre2) throws IOException {
		StringBuilder urlBuilder = new StringBuilder(
				"http://api.koreafilm.or.kr/openapi-data2/wisenut/search_api/search_json2.jsp?collection=kmdb_new2&listCount=100&genre="
						+ genre + "%20" + genre2 + "&createDts=2000&ServiceKey=319276GM630XRTRNIWN8");

		URL url = new URL(urlBuilder.toString());
		HttpURLConnection con = (HttpURLConnection) url.openConnection();
		con.setRequestMethod("GET");
		con.setRequestProperty("Content-type", "application/json");
		
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
//		System.out.println(sb.toString());
		
		return sb.toString();
	}

	// 선호하는 영화 장르 랜덤 
	public String getGenre(String genre, String genre2, int startCount) throws IOException {
		StringBuilder urlBuilder = new StringBuilder(
				"http://api.koreafilm.or.kr/openapi-data2/wisenut/search_api/search_json2.jsp?collection=kmdb_new2&listCount=100&genre="
						+ genre + "%20" + genre2 + "&createDts=2000&startCount=" + startCount + "&ServiceKey=319276GM630XRTRNIWN8");

		URL url = new URL(urlBuilder.toString());
		HttpURLConnection con = (HttpURLConnection) url.openConnection();
		con.setRequestMethod("GET");
		con.setRequestProperty("Content-type", "application/json");
		
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
//		System.out.println(sb.toString());
		
		return sb.toString();
	}

	// 선호하는 나라 영화
	public String getNation(String nation) throws IOException {
		StringBuilder urlBuilder = new StringBuilder(
				"http://api.koreafilm.or.kr/openapi-data2/wisenut/search_api/search_json2.jsp?collection=kmdb_new2&listCount=100&nation="
						+ nation + "&createDts=2010&ServiceKey=319276GM630XRTRNIWN8");

		URL url = new URL(urlBuilder.toString());
		HttpURLConnection con = (HttpURLConnection) url.openConnection();
		con.setRequestMethod("GET");
		con.setRequestProperty("Content-type", "application/json");
		
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
//		System.out.println(sb.toString());
		
		return sb.toString();
	}


	// 선호하는 나라 영화 랜덤
	public String getNation(String nation, int startCount) throws IOException {
		StringBuilder urlBuilder = new StringBuilder(
				"http://api.koreafilm.or.kr/openapi-data2/wisenut/search_api/search_json2.jsp?collection=kmdb_new2&listCount=100&nation="
						+ nation + "&createDts=2010&startCount=" + startCount + "&ServiceKey=319276GM630XRTRNIWN8");

		URL url = new URL(urlBuilder.toString());
		HttpURLConnection con = (HttpURLConnection) url.openConnection();
		con.setRequestMethod("GET");
		con.setRequestProperty("Content-type", "application/json");
		
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
//		System.out.println(sb.toString());
		
		return sb.toString();
	}


	
	
}

