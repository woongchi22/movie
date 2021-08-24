<%@page import="board.vo.ReviewBean"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<%
ArrayList<ReviewBean> reviewList = (ArrayList<ReviewBean>)request.getAttribute("reviewList");
String query = request.getParameter("query"); 
int movieSeq = Integer.parseInt(request.getParameter("movieSeq"));
String name = (String)session.getAttribute("name"); 
String grade = (String)request.getAttribute("grade");

%>

<link href="${pageContext.request.contextPath}/css/default.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath}/css/movie.css" rel="stylesheet" type="text/css">
<script src="${pageContext.request.contextPath}/js/jquery-3.5.1.js"></script>

<%-- modal --%>
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script src="${pageContext.request.contextPath}/js/jquery-ui.js"></script>


<title><%=query %> 코멘트</title>
</head>
<header>
	<jsp:include page="/inc/top.jsp"/>
</header>

<body>

	<div class="reviewAll">
	   <h2><%=query %> 코멘트</h2>
       <a class="back" href="MovieDetailPro.mo?movieSeq=<%=movieSeq %>&query=<%=query %>">돌아가기</a>
       <div class="noComment">아직 등록된 코멘트가 없습니다.</div>
       
	<%for(ReviewBean rb : reviewList) {%>
	   <%if(rb.getName() != null) { %>
	       <script type="text/javascript">
	       $('.noComment').css("display", "none");
	       </script>
	   <%} %>
		<div class="reviewList">
		    <div class="reviewName"> <%=rb.getName() %></div>
		    <div class="reviewGrade"><img class="reviewStar" src="img/star3.png"> <%=rb.getGrade() %>점</div>
		    <hr>
		    <div class="reviewContent"><%=rb.getContent() %></div>
		    <hr>
		    <div class="reList">
			    <div class="likeImg"></div>
			    <div class="reviewLc"><%=rb.getLike_count() %></div>
			    <div>
<%-- 			      <a href="BoardReply.bo?movieSeq=<%=rb.getMovieSeq()%>&idx=<%=rb.getIdx()%>"> --%>
<%-- 	                      <input type="button" value="댓글달기" id="ReviewReply_<%=rb.getIdx() %>" class="replyBtn" ></a> --%>
			      <input class="likeBtn" type="button" id="like_<%=rb.getIdx() %>" value="좋아요">    
			    </div>
		    </div>
		</div>
			
<script type="text/javascript">

$(document).ready(function() {
	var name = $('#name').val();
	var idx = <%=rb.getIdx() %>
// 	console.log(name);
// 	console.log(idx);
		
	$('#like_<%=rb.getIdx() %>').click(function() {
		
		if(name != 'null'){
		
			$.ajax('BoardReviewLike.bo',{
				method:"get",
				data:{
					name:name,
					idx:idx
				},
				success: function(data) {
					location.reload();
				}
				
			});
			
		} else {
			alert('로그인이 필요합니다.');
				
		}
		
	});
	
	
});



</script>	
	<%} %>	
	</div>		
		<input type="hidden" id="name" name="name" value="<%=name%>">
		<input type="hidden" id="movieSeq" name="movieSeq" value="<%=movieSeq%>">
		<input type="hidden" id="query" name="query" value="<%=query%>">
		<input type="hidden" id="grade" name="grade" value="<%=grade %>">
	
		
		
</body>
</html>