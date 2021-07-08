<%@page import="board.vo.ReviewBean"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<%
ArrayList<ReviewBean> reviewList = (ArrayList<ReviewBean>) request.getAttribute("reviewBean");
String query = request.getParameter("query"); 
int movieSeq = Integer.parseInt(request.getParameter("movieSeq"));

String name = (String)session.getAttribute("name");

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

	
// 	$("#submitBt").on("click", function() {
// 		var review = $('#rev_content').val();
		
// 		console.log(review);
// 		console.log(movieSeq);
// 		console.log(query);
		
		
// 		$.ajax("BoardReviewWrite.bo", {
// 			method:"get",
// 			dataType:"json",
// 			data:{
// 				movieSeq:movieSeq,
// 				name:name,
// 				review:review,
// 				query:query
// 			},
// 			success: function(data) {
// 				console.log("이거");
// 				console.log(data);
				
// //                 $('#review1').append('<div class=title><a href=MovieDetailPro.mo?movieId' + item2.movieId + '&movieSeq=' +

				
				
// 			}//success
			
	
// 		});//ajax
// 	})//click

	
	$.ajax("BoardReviewList.bo", {
		method:"post",
		dataType:"json",
		async: false,
		data:{
			movieSeq:movieSeq,
			query:query
		},
		success: function(data) {
			console.log(" 성겅");
			console.log(data);
			
			
			
			
		},
		error:function(){   //데이터 주고받기가 실패했을 경우 실행할 결과
			alert('실패');
		}


	});//list	
	
});//ready


</script>
<title><%=query %> 리뷰</title>
</head>
<header>
	<jsp:include page="/inc/top.jsp"/>
</header>
<body>
	<h2><%=query %> 리뷰</h2>
		<input type="button"  value="돌아가기" onclick="history.back();">

		<div id = "review"></div>
		
			<% if(name!=null){%>
<!-- 		<form action = "BoardReviewWrite.bo"  method="post" id="review_write" > -->

		<textarea id = "rev_content" class="rev_content"></textarea>
		<div id = "review1"></div>
		<input type="button" style="float:right;" value="등록" id = "submitBt">
<!-- 		</form> -->
		<% }else{%>
		<textarea name = "content" id = "rev_content" readonly="readonly" class="rev_content">댓글쓰기 권한이 없습니다. 로그인이 필요합니다</textarea>
		<%} %>
		<input type="hidden" id="name" name="name" value="<%=name%>">
		<input type="hidden" id="movieSeq" name="movieSeq" value="<%=movieSeq%>">
		<input type="hidden" id="query" name="query" value="<%=query%>">
		
		
		
		
		
		
		
</body>
</html>