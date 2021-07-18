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
	<h2><%=query %> 코멘트</h2>
		<a href="MovieDetailPro.mo?movieSeq=<%=movieSeq %>&query=<%=query %>">돌아가기</a>

			<div style="padding: 5% 5%;">
			<%for(ReviewBean rb : reviewList) {%>
			
				<div style="margin: 10% ; border: solid 1px gray;">
				    <div style=" border-bottom: solid 0.3px #454545; " > <%=rb.getName() %></div>
				    <div> <%=rb.getGrade() %></div>
				    <div style="margin: 10px 0;"><%=rb.getContent() %></div>
				    <div><a href="BoardReply.bo?movieSeq=<%=rb.getMovieSeq()%>&idx=<%=rb.getIdx()%>">
				    <input type="button"  value="답댓글" id="ReviewReply_<%=rb.getIdx() %>" class="button" ></a></div>
				    <div class="likeImg"></div><div style="color: gray; font-weight: bold;"><%=rb.getLike_count() %></div>
				    <div style="border-top: solid 0.3px #454545;"><input type="button" id = "like_<%=rb.getIdx() %>" value="좋아요"></div>
<%-- 				    <div style="border-top: solid 0.3px #454545;" id = "like" ><a href="BoardReviewLike.bo?idx=<%=rb.getIdx()%>&name=<%=name%>">좋아요</a></div> --%>
				</div>
			
			</div>  
<script type="text/javascript">
$(document).ready(function() {
	var name = $('#name').val();
	var idx = <%=rb.getIdx() %>
	
	console.log(name);
	console.log(idx);
		
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
			}else{
				alert('로그인이 필요합니다.');
					
			}
		})//click
});




</script>	
			<%} %>			
		<input type="hidden" id="name" name="name" value="<%=name%>">
		<input type="hidden" id="movieSeq" name="movieSeq" value="<%=movieSeq%>">
		<input type="hidden" id="query" name="query" value="<%=query%>">
		<input type="hidden" id="grade" name="grade" value="<%=grade %>">
	
		
		
</body>
</html>