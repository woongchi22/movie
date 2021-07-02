package api;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;

public class kmdbApi {

	public String getBoxoffice(String openDt, String movieNm) throws IOException {
		System.out.println("getBoxOffice");
		
		StringBuilder urlBuilder = new StringBuilder(
				"http://api.koreafilm.or.kr/openapi-data2/wisenut/search_api/search_json.jsp?collection=kmdb_new&listCount=100&ServiceKey=605841J368J95E2I93M1");
		/* URL */
		urlBuilder.append("&" + URLEncoder.encode("releaseDts", "UTF-8") + "=" + URLEncoder.encode(openDt, "UTF-8")); /* Service Key */
		urlBuilder.append(
				"&" + URLEncoder.encode("title", "UTF-8") + "=" + URLEncoder.encode(movieNm, "UTF-8")); /* 상영년도 */
//		urlBuilder
//				.append("&" + URLEncoder.encode("val002", "UTF-8") + "=" + URLEncoder.encode("01", "UTF-8")); /* 상영 월 */
		URL url = new URL(urlBuilder.toString());
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
		
		rd.close();
		conn.disconnect();

		return sb.toString();
	}

}
