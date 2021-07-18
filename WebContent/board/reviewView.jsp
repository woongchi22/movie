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
				    <div style="border-top: solid 0.3px #454545;" ><a href="">좋아요</a></div>
<%-- 				<%if(name.equals(rb.getName())){%> --%>

<%-- 				 <input type="button" value="수정" id="updateReview_<%=rb.getIdx() %>" class="button"> --%>
<%--             	 <input type="button" value="삭제" id="deleteReview_<%=rb.getIdx() %>" class="button"> --%>
<%--           		<%} %> --%>
				</div>
			<%} %>	
			</div>  
				
				
<%--           		<div id="update-message_<%=rb.getIdx() %>" title="리뷰 수정" style="display:none"> --%>
<%-- 				    <textarea id="reviewUpdate_<%=rb.getIdx() %>" name="reviewUpdate" cols="25" rows="5"></textarea> --%>
<!-- 				     리뷰를 수정해주세요. -->
<!-- 				</div>		 -->
				
<%-- 				<div id = "delete-message_<%=rb.getIdx() %>" title="리뷰 삭제" style="display:none"> --%>
<!-- 				    리뷰를 삭제하시겠습니까? -->
<!-- 				</div> -->
		
				
<script type="text/javascript">


	
 
</script>       
				
					
		<input type="hidden" id="name" name="name" value="<%=name%>">
		<input type="hidden" id="movieSeq" name="movieSeq" value="<%=movieSeq%>">
		<input type="hidden" id="query" name="query" value="<%=query%>">
		<input type="hidden" id="grade" name="grade" value="<%=grade %>">
	
		
		
</body>
</html>