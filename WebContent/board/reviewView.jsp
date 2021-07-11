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
// int idx = Integer.parseInt(request.getParameter("idx"));

%>
<link href="${pageContext.request.contextPath}/css/default.css" rel="stylesheet" type="text/css">
<script src="${pageContext.request.contextPath}/js/jquery-3.5.1.js"></script>
<script type="text/javascript">
$(document).ready(function() {
	var query = $('#query').val();
	var movieSeq = $('#movieSeq').val();
	var name = $('#name').val();
	
	console.log(query);	
	console.log(movieSeq);	
	console.log(name);	
	
	$('#submitBtn').click(function() {
	var review = $('#rev_content').val();
		
	
	//리뷰 쓰기
	$.ajax("BoardReviewWrite.bo", {
		method:"post",
		async: false,
		data:{
			query:query,
			movieSeq:movieSeq,
			review:review
		},
		success: function(data) {
            location.reload();

		}
		
	}); //ajax
	}); //click
	
	
	
});//ready


</script>
<title><%=query %> 리뷰</title>
</head>
<header>
	<jsp:include page="/inc/top.jsp"/>
</header>
<body>
	<h2><%=query %> 리뷰</h2>
		<input type="button" value="돌아가기" class = "button" onclick="history.back();">

		
		
			<% if(name!=null){%>
				<div class="textA">
				<textarea id = "rev_content" class="rev_content"></textarea>
				<input type="button"  value="등록" id = "submitBtn" class="button">
				</div>
			<% }else{%>
			<div class="textA">
				<textarea name = "content" id = "rev_content" readonly="readonly" class="rev_content">댓글쓰기 권한이 없습니다. 로그인이 필요합니다</textarea>
			</div>
			<%} %>
		
			<%for(ReviewBean rb : reviewList) {%>
				<div>
				<div><%=rb.getContent() %></div>
				<div class="re"> <%=rb.getName() %>| <%=rb.getdDate()%></div>
				<a href="BoardReply.bo?movieSeq=<%=rb.getMovieSeq()%>&idx=<%=rb.getIdx()%>">
				<input type="button"  value="답댓글" id = "ReviewReply" class="button" ></a>
				 <input type="button" value="수정" id="updateReply_<%=rb.getIdx() %>" class="button">
            	 <input type="button" value="삭제" id="deleteReply_<%=rb.getIdx() %>" class="button">
          
          <script type="text/javascript">
					$('#updateReply_<%=rb.getIdx() %>').click(function() {
			                    	  
			                    	  
			                      }
						
					});
				
				</script>
          
				<%} %>
				</div>
		
				
		
		<input type="hidden" id="name" name="name" value="<%=name%>">
		<input type="hidden" id="movieSeq" name="movieSeq" value="<%=movieSeq%>">
		<input type="hidden" id="query" name="query" value="<%=query%>">
	
		
	
		
		
</body>
</html>