<%@page import="board.vo.ReplyBean"%>
<%@page import="board.vo.ReviewBean"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<%
// ArrayList<ReviewBean> reviewList = (ArrayList<ReviewBean>)request.getAttribute("reviewList");
ReviewBean reviewBean = (ReviewBean) request.getAttribute("reviewBean");
ArrayList<ReplyBean> replyList = (ArrayList<ReplyBean>)request.getAttribute("replyList");

int idx = Integer.parseInt(request.getParameter("idx"));
int movieSeq = Integer.parseInt(request.getParameter("movieSeq"));
String name = (String) session.getAttribute("name");

// String query = request.getParameter("query"); 
// int movieSeq = Integer.parseInt(request.getParameter("movieSeq"));
// String name = (String)session.getAttribute("name");

%>
<script src="${pageContext.request.contextPath}/js/jquery-3.5.1.js"></script>
<script type="text/javascript">
$(document).ready(function() {
	var movieSeq = $('#movieSeq').val();
	var idx = $('#idx').val();
	
	// 답댓글
	$('#submitBtn').click(function() {
		var content = $('#rev_content').val();
		var content = $('#rev_content').val();
		console.log(content);
		
		$.ajax("BoardReplyWrite.bo", {
			method:"post",
			async: false,
			data:{
				content:content,
				idx:idx,
				movieSeq:movieSeq
			},
			success: function(data) {
				console.log("성공");
				console.log(data);
	            location.reload();

			}
			
			
			
		});
		
	});//click
});//ready


</script>
<link href="${pageContext.request.contextPath}/css/default.css" rel="stylesheet" type="text/css">
<title></title>
	<h2>답댓글</h2>
</head>
<header>
	<jsp:include page="/inc/top.jsp"/>
</header>
<body>
	<div>
		<div><%=reviewBean.getContent() %></div>
		<div class ="re"><%=reviewBean.getName() %> | <%=reviewBean.getdDate() %></div>
		
	</div>
	<div class="textA">
		<textarea id = "rev_content" class="rev_content"></textarea>
		<input type = button value="등록" id = "submitBtn" class= "button" >
		<input type = button value="취소" class= "button" onClick="history.go(-1)">
	
	</div>
	<%for(int i = 0; i < replyList.size(); i++) {%>
				<div>
				<div><%=replyList.get(i).getContent() %></div>
				<div class="re"> <%=replyList.get(i).getName() %>| <%=replyList.get(i).getDate()%></div>
				<a href="BoardReply.bo?movieSeq=<%=replyList.get(i).getMovieSeq()%>&idx=<%=replyList.get(i).getIdx()%>">
				<input type="button"  value="답댓글" id = "ReviewReply" class="button" ></a>
				
				</div>
			<%} %>
	
	
	<input type="hidden" id="name" name="name" value="<%=name%>">
	<input type="hidden" id="movieSeq" name="movieSeq" value="<%=movieSeq%>">
	<input type="hidden" id=idx name="idx" value="<%=idx%>">
	
	
	
	
</body>
</html>