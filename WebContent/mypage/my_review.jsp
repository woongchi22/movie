<%@page import="board.vo.ReviewBean"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<%
ArrayList<ReviewBean> reviewList = (ArrayList<ReviewBean>)request.getAttribute("reviewList");
String name = (String)session.getAttribute("name"); 
%>
<head>
<meta charset="UTF-8">
<link href="${pageContext.request.contextPath}/css/default.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath}/css/movie.css" rel="stylesheet" type="text/css">
<script src="${pageContext.request.contextPath}/js/jquery-3.5.1.js"></script>

<%-- modal --%>
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script src="${pageContext.request.contextPath}/js/jquery-ui.js"></script>



<title>My Review</title>
</head>
<header>
    <jsp:include page="/inc/top.jsp"/>
</header>
<body>
<div class="sidebar">
	<ul>
		<li class="active"><a href="#" data-nav-section="about">개인정보수정</a></li>
		<li><a href="BoardMyReviewList.bo?name=<%=name %>" data-nav-section="review">내가 쓴 리뷰</a></li>
	</ul>
</div>

<%for(ReviewBean rb : reviewList){%>	
<div class="myReviewList">
	 <div class="reviewTitle"><%=rb.getTitle() %></div>
	 <div class="reviewGrade"><img class="reviewStar" src="img/star3.png"> <%=rb.getGrade() %>점</div>
	 <hr>
	 <div class="reviewContent"><%=rb.getContent() %></div>

	 <hr>
	 <div class="button">
	 	<a href="MovieDetailPro.mo?movieSeq=<%=rb.getMovieSeq()%>&query=<%=rb.getTitle()%>">
		 <input type="button" id="" class="updateBtn" value="수정"></a>
		 <input type="button" id="deleteBtn_<%=rb.getIdx() %>" class="deleteBtn" value="삭제">
	 </div>
	 <div id="dialog-delete" style="display:none">코멘트를 삭제하시겠습니까?</div>
</div>

<script type="text/javascript">
$(document).ready(function() {
	//리뷰 삭제
	$('#deleteBtn_<%=rb.getIdx()%>').click(function() {
		name = $('#name_<%=rb.getMovieSeq()%>').val();
		movieSeq =$('#movieSeq_<%=rb.getMovieSeq()%>').val();
	 	console.log(name);
	 	console.log(query);
	 	console.log(movieSeq);
		  $('#dialog-delete').dialog({
	        	title: "삭제",
	             modal: true,
	             buttons: {
	                 "확인": function() {
	                     $.ajax({
	                         url: "BoardReviewDelete.bo",
	                         method: "get",
	                         async: false,
	                         data: {
	                        	 name:name,
	                             movieSeq:movieSeq
	                         },
	                         success: function(data) {
// 	                             $('#commentBtn').css("display", "");
// 	                             $('#commentBox').css("display", "none");
	                         }
	                     });
	                     $(this).dialog('close');
	                 },
	                 "취소": function() {
	                     $(this).dialog('close');
	                 }
	             }
	    
	        });
		
	})
});


</script>
<input type="hidden" id="name_<%=rb.getMovieSeq()%>" name="name" value="<%=rb.getName()%>">
<input type ="hidden" id="query" name="query" value="<%=rb.getTitle()%>">
<input type ="hidden" id="movieSeq_<%=rb.getMovieSeq()%>" name="movieSeq" value="<%=rb.getMovieSeq()%>">
<%} %>

</body>
</html>