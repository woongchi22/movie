package vo;

public class ActionForward {
	private String path; // 포워딩 주소 저장
	private boolean isRedirect; // 포워딩 방식 저장할 변수
	// true -> Redirect방식, false -> Dispatch방식
	
	public String getPath() {
		return path;
	}
	public void setPath(String path) {
		this.path = path;
	}
	public boolean isRedirect() {
		return isRedirect;
	}
	public void setRedirect(boolean isRedirect) {
		this.isRedirect = isRedirect;
	}

}
