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
String grade = request.getParameter("grade"); 

%>

<link href="${pageContext.request.contextPath}/css/default.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath}/css/movie.css" rel="stylesheet" type="text/css">
<script src="${pageContext.request.contextPath}/js/jquery-3.5.1.js"></script>

<%-- modal --%>
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script src="${pageContext.request.contextPath}/js/jquery-ui.js"></script>


<title><%=query %> 리뷰</title>
</head>
<header>
	<jsp:include page="/inc/top.jsp"/>
</header>
<body>
	<h2><%=query %> 리뷰</h2>
		<input type="button" value="돌아가기" class = "button" onclick="history.back();">

			


			<% if(name != null){%>
				<div class="textA">
					<form action="BoardReviewWrite.bo?movieSeq=<%=movieSeq%>&query=<%=query%>"method="post" id="review_write">
					<textarea id = "rev_content" class="rev_content" name="rev_content"></textarea>
					<input type="submit" value="등록" id="submitBtn" class="button">
					</form>
				</div>
			<% }else{%>
				<div class="textA">
					<textarea name = "content" id = "rev_content" readonly="readonly" class="rev_content">댓글쓰기 권한이 없습니다. 로그인이 필요합니다</textarea>
				</div>
			<% } %>

		
			<div style="padding: 5% 5%;">
			<%for(ReviewBean rb : reviewList) {%>
			

				<div style="margin: 10% ;border: solid 1px gray;">
				<div style=" border-bottom: solid 0.3px #454545; " > <%=rb.getName() %></div>
				<div style="margin: 10px 0;"><%=rb.getContent() %></div>
<%-- 				<div><<a href="BoardReply.bo?movieSeq=<%=rb.getMovieSeq()%>&idx=<%=rb.getIdx()%>"> --%>
<%-- 				<input type="button"  value="답댓글" id="ReviewReply_<%=rb.getIdx() %>" class="button" ></a></div> --%>
				<div style="border-top: solid 0.3px #454545;" ><a href="">좋아요</a></div>
				<%if(name.equals(rb.getName())){%>

				 <input type="button" value="수정" id="updateReview_<%=rb.getIdx() %>" class="button">
            	 <input type="button" value="삭제" id="deleteReview_<%=rb.getIdx() %>" class="button">
          		<%} %>
				</div>
				
				
				
				
          		<div id="update-message_<%=rb.getIdx() %>" title="리뷰 수정" style="display:none">
				    <textarea id="reviewUpdate_<%=rb.getIdx() %>" name="reviewUpdate" cols="25" rows="5"></textarea>
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
					</div>	
		<input type="hidden" id="name" name="name" value="<%=name%>">
		<input type="hidden" id="movieSeq" name="movieSeq" value="<%=movieSeq%>">
		<input type="hidden" id="query" name="query" value="<%=query%>">
		<input type="hidden" id="grade" name="grade" value="<%=grade %>">
	
		
		
</body>
</html>