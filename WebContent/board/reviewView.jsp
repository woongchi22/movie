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
String reviewUpdate = (String) request.getParameter("reviewUpdate");

%>

<script src="//code.jquery.com/jquery-1.11.1.min.js"></script>
<!-- <script src="//maxcdn.bootstrapcdn.com/bootstrap/3.3.0/js/bootstrap.min.js"></script> -->
<!-- <link href="//maxcdn.bootstrapcdn.com/bootstrap/3.3.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css"> -->
<link href="${pageContext.request.contextPath}/css/default.css" rel="stylesheet" type="text/css">
<script src="${pageContext.request.contextPath}/js/jquery-3.5.1.js"></script>
<script src="${pageContext.request.contextPath}/js/jquery-ui.js"></script>




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
				<form action="BoardReviewWrite.bo?movieSeq=<%=movieSeq%>&query=<%=query%>"method="post" id="review_write">
				<textarea id = "rev_content" class="rev_content" name="rev_content"></textarea>
				<input type="submit"  value="등록" id = "submitBtn" class="button">
				</form>
				</div>
			<% }else{%>
			<div class="textA">
				<textarea name = "content" id = "rev_content" readonly="readonly" class="rev_content">댓글쓰기 권한이 없습니다. 로그인이 필요합니다</textarea>
			</div>
			<%} %>
		
			
			<%for(ReviewBean rb : reviewList) {%>
			
			
				<div><%=rb.getContent() %></div>
				<div class="re"> <%=rb.getName() %>| <%=rb.getdDate()%></div>
				<a href="BoardReply.bo?movieSeq=<%=rb.getMovieSeq()%>&idx=<%=rb.getIdx()%>">
				<input type="button"  value="답댓글" id="ReviewReply_<%=rb.getIdx() %>" class="button" ></a>
				 <input type="button" value="수정" id="updateReview_<%=rb.getIdx() %>" class="button">
            	 <input type="button" value="삭제" id="deleteReview_<%=rb.getIdx() %>" class="button">
          		
          		<div id="update-message_<%=rb.getIdx() %>" title="리뷰 수정" style="display:none">
			    <textarea id="reviewUpdate_<%=rb.getIdx() %>" name="reviewUpdate" cols="30" rows="5"></textarea>
			     리뷰를 수정해주세요.
				</div>		
				
				<div id = "delete-message_<%=rb.getIdx() %>" title="리뷰 삭제" style="display:none">
				리뷰를 삭제하시겠습니까?
				</div>
				
				
 <script type="text/javascript">
$(document).ready(function() {
	var query = $('#query').val();
	var movieSeq = $('#movieSeq').val();
	var name = $('#name').val();
	var idx = <%=rb.getIdx() %>;
	var review = $('#reviewUpdate_<%=rb.getIdx() %>').val();
	
	
	//리뷰삭제
	$('#deleteReview_<%=rb.getIdx() %>').click(function() {
		 $('#delete-message_<%=rb.getIdx() %>').dialog({
			 modal: true,
			 async : false,
             buttons: {
               "확인": function() {
                   
                   idx = $('#idx').val();
                   console.log(idx);
                   
                   $.ajax({
                  	 url: "BoardReviewDelete.bo?idx=<%=rb.getIdx()%>",
                  	 method: "get",
                     data: {
                           idx:idx
                       },		 
                  			 
                       success: function(data) {
                           location.reload();
                       },error:function(request,status,error){
                      	    alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);}

                   })
                   
                   $(this).dialog('close');
                },//확인
                
                "취소": function() {
                    $(this).dialog('close');
                }
           }
		 });
	});
	
	//리뷰수정
	$('#updateReview_<%=rb.getIdx() %>').click(function() {
		 $('#update-message_<%=rb.getIdx() %>').dialog({
			 modal: true,
			 async : false,
             buttons: {
                 "수정": function() {
                     
                     name = $('#name').val()
                     movieSeq = $("#movieSeq").val();
                     idx = $('#idx').val();
                     review = $('#reviewUpdate_<%=rb.getIdx() %>').val();
                     console.log('수정된리뷰'+review);
                     
                     $.ajax({
                    	 url: "BoardReviewUpdate.bo?idx=<%=rb.getIdx()%>",
                    	 method: "get",
                         data: {
                             idx:idx,
                             movieSeq:movieSeq,
                             name:name,
                             review:review
                         },		 
                    			 
                         success: function(data) {
                        	 console.log(review);
                             location.reload();
                         },error:function(request,status,error){
                        	    alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);}

                     })
                     
                     $(this).dialog('close');
                  },//수정
                  "취소": function() {
                      $(this).dialog('close');
                  }
             }
		 });
	});
	
	
//혹시 몰라서 놔둠ㅋ	
// 	$('#submitBtn').off("click").click(function() {
// 		console.log("뜨남");
// 	 review = $('#rev_content').val();
// 		//리뷰 쓰기
// 		$.ajax("BoardReviewWrite.bo", {
// 			method:"post",
// 			async : false,
// 			datatype:"param",
// 			data:{
// 				query:query,
// 				movieSeq:movieSeq,
// 				review:review
// 			},
// 			success: function(data) {
// 			}
			
// 		}); //ajax
// 	}); //click
	
	

	
});//ready
 
</script>       
				<%} %>
		<input type="hidden" id="name" name="name" value="<%=name%>">
		<input type="hidden" id="movieSeq" name="movieSeq" value="<%=movieSeq%>">
		<input type="hidden" id="query" name="query" value="<%=query%>">
	
		
		
</body>
</html>