package movie.action;

import javax.servlet.http.*;

import action.*;
import member.svc.*;
import movie.svc.*;
import vo.*;

public class MovieSearchProAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		
		MovieSearchProService movieSearchProServicce = new MovieSearchProService();
		movieSearchProServicce.searchMovie();
		
		
		return null;
	}

}
