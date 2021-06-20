package action;

import javax.servlet.http.*;

import vo.*;

public interface Action {
	ActionForward excute(HttpServletRequest request, HttpServletResponse response) throws Exception;

}
