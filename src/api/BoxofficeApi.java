package api;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;


public class BoxofficeApi {

	public String getBoxOffice(String targetDt) throws IOException {
//		System.out.println("BoxofficeApi-getBoxOffice!!!!!!!!!!!!!!");
//		System.out.println(targetDt);
		String serviceKey = "4d549b0bc63467abbc7ffe4a1169333a";
		
		StringBuilder urlBuilder = new StringBuilder("http://www.kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchWeeklyBoxOfficeList.json?key="
                + serviceKey + "&itemPerPage=10&multiMovieYn=N&weekGb=0&targetDt=" + targetDt);
		
		URL url = new URL(urlBuilder.toString());
		HttpURLConnection conn = (HttpURLConnection) url.openConnection();
		conn.setRequestMethod("GET");
		conn.setRequestProperty("content-type", "application/json");
		BufferedReader rd;
		if(conn.getResponseCode() >= 200 && conn.getResponseCode() <=300) {
			rd = new BufferedReader(new InputStreamReader(conn.getInputStream()));
		}else {
			rd = new BufferedReader(new InputStreamReader(conn.getInputStream()));
		}
		
		StringBuilder sb = new StringBuilder();
		String line;
		while((line = rd.readLine()) != null) {
			sb.append(line + "\n");
		}
		
		rd.close();
		conn.disconnect();
//		System.out.println(sb.toString());
//		System.out.println(targetDt);
		return sb.toString();
	}

}
