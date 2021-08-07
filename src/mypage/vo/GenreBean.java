package mypage.vo;

import java.util.*;
import java.util.Map.*;

public class GenreBean {
	private int SF;
	private int	가족;
	private int 공포;
	private int 다큐멘터리;
	private int 동성애;
	private int 드라마;
	private int	로맨스;
	private int	로맨틱코메디;
	private int	멜로드라마;
	private int	뮤직;
	private int	미스터리;
	private int	범죄;
	private int	시대극;
	private int	서부;
	private int	스릴러;
	private int	스포츠;
	private int	아동;
	private int	애니메이션;
	private int	액션;
	private int	어드벤처;
	private int	옴니버스;
	private int	재난;
	private int	전쟁;
	private int	코메디;
	private int	판타지;
	private int	하이틴;
	
	public ArrayList<String> getDESC(){
		int count = 0;
		HashMap<String, Integer> map = new HashMap<String, Integer>();
		map.put("SF", getSF());
		map.put("가족", get가족());
		map.put("공포", get공포());
		map.put("다큐멘터리", get다큐멘터리());
		map.put("동성애", get동성애());
		map.put("드라마", get드라마());
		map.put("로맨스", get로맨스());
		map.put("로맨틱코메디", get로맨틱코메디());
		map.put("멜로드라마", get멜로드라마());
		map.put("뮤직", get뮤직());
		map.put("미스터리", get미스터리());
		map.put("범죄", get범죄());
		map.put("시대극", get시대극());
		map.put("서부", get서부());
		map.put("스릴러", get스릴러());
		map.put("스포츠", get스포츠());
		map.put("아동", get아동());
		map.put("애니메이션", get애니메이션());
		map.put("액션", get액션());
		map.put("어드벤처", get어드벤처());
		map.put("옴니버스", get옴니버스());
		map.put("재난", get재난());
		map.put("전쟁", get전쟁());
		map.put("코메디", get코메디());
		map.put("판타지", get판타지());
		map.put("하이틴", get하이틴());

		List<Map.Entry<String, Integer>> list = new ArrayList<>(map.entrySet());
		
		Collections.sort(list, new Comparator<Map.Entry<String, Integer>>() {
		
			public int compare(Entry<String, Integer> o1, Entry<String, Integer> o2) {
				int Comparison = (o1.getValue() - o2.getValue()) * -1;
				
				return Comparison == 0 ? o1.getValue().compareTo(o2.getValue()) : Comparison;
			} 
		
		});
		
		ArrayList<String> resultList = new ArrayList<String>();
		for(Iterator<Map.Entry<String, Integer>> iter = list.iterator(); iter.hasNext();) {
			if(count == 3) {
				return resultList;
			}
			Map.Entry<String, Integer> entry = iter.next();
			resultList.add(entry.getKey());
			count++;
		}
		
		
		return resultList;
	}
	
	
	
	public int getSF() {
		return SF;
	}
	public void setSF(int sF) {
		SF = sF;
	}
	public int get가족() {
		return 가족;
	}
	public void set가족(int 가족) {
		this.가족 = 가족;
	}
	public int get공포() {
		return 공포;
	}
	public void set공포(int 공포) {
		this.공포 = 공포;
	}
	public int get다큐멘터리() {
		return 다큐멘터리;
	}
	public void set다큐멘터리(int 다큐멘터리) {
		this.다큐멘터리 = 다큐멘터리;
	}
	public int get동성애() {
		return 동성애;
	}
	public void set동성애(int 동성애) {
		this.동성애 = 동성애;
	}
	public int get드라마() {
		return 드라마;
	}
	public void set드라마(int 드라마) {
		this.드라마 = 드라마;
	}
	public int get로맨스() {
		return 로맨스;
	}
	public void set로맨스(int 로맨스) {
		this.로맨스 = 로맨스;
	}
	public int get로맨틱코메디() {
		return 로맨틱코메디;
	}
	public void set로맨틱코메디(int 로맨틱코메디) {
		this.로맨틱코메디 = 로맨틱코메디;
	}
	public int get멜로드라마() {
		return 멜로드라마;
	}
	public void set멜로드라마(int 멜로드라마) {
		this.멜로드라마 = 멜로드라마;
	}
	public int get뮤직() {
		return 뮤직;
	}
	public void set뮤직(int 뮤직) {
		this.뮤직 = 뮤직;
	}
	public int get미스터리() {
		return 미스터리;
	}
	public void set미스터리(int 미스터리) {
		this.미스터리 = 미스터리;
	}
	public int get범죄() {
		return 범죄;
	}
	public void set범죄(int 범죄) {
		this.범죄 = 범죄;
	}
	public int get시대극() {
		return 시대극;
	}
	public void set시대극(int 시대극) {
		this.시대극 = 시대극;
	}
	public int get서부() {
		return 서부;
	}
	public void set서부(int 서부) {
		this.서부 = 서부;
	}
	public int get스릴러() {
		return 스릴러;
	}
	public void set스릴러(int 스릴러) {
		this.스릴러 = 스릴러;
	}
	public int get스포츠() {
		return 스포츠;
	}
	public void set스포츠(int 스포츠) {
		this.스포츠 = 스포츠;
	}
	public int get아동() {
		return 아동;
	}
	public void set아동(int 아동) {
		this.아동 = 아동;
	}
	public int get애니메이션() {
		return 애니메이션;
	}
	public void set애니메이션(int 애니메이션) {
		this.애니메이션 = 애니메이션;
	}
	public int get액션() {
		return 액션;
	}
	public void set액션(int 액션) {
		this.액션 = 액션;
	}
	public int get어드벤처() {
		return 어드벤처;
	}
	public void set어드벤처(int 어드벤처) {
		this.어드벤처 = 어드벤처;
	}
	public int get옴니버스() {
		return 옴니버스;
	}
	public void set옴니버스(int 옴니버스) {
		this.옴니버스 = 옴니버스;
	}
	public int get재난() {
		return 재난;
	}
	public void set재난(int 재난) {
		this.재난 = 재난;
	}
	public int get전쟁() {
		return 전쟁;
	}
	public void set전쟁(int 전쟁) {
		this.전쟁 = 전쟁;
	}
	public int get코메디() {
		return 코메디;
	}
	public void set코메디(int 코메디) {
		this.코메디 = 코메디;
	}
	public int get판타지() {
		return 판타지;
	}
	public void set판타지(int 판타지) {
		this.판타지 = 판타지;
	}
	public int get하이틴() {
		return 하이틴;
	}
	public void set하이틴(int 하이틴) {
		this.하이틴 = 하이틴;
	}
	

	
	
	
}
