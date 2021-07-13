<%@page import="board.vo.ReviewBean"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="//code.jquery.com/jquery-1.11.1.min.js"></script>
<script src="//maxcdn.bootstrapcdn.com/bootstrap/3.3.0/js/bootstrap.min.js"></script>
<link href="//maxcdn.bootstrapcdn.com/bootstrap/3.3.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
<%
ArrayList<ReviewBean> reviewList = (ArrayList<ReviewBean>)request.getAttribute("reviewList");

String query = request.getParameter("query"); 
int movieSeq = Integer.parseInt(request.getParameter("movieSeq"));
String name = (String)session.getAttribute("name");
// int idx = Integer.parseInt(request.getParameter("idx"));

%>

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
				<textarea id = "rev_content" class="rev_content"></textarea>
				<input type="button"  value="등록" id = "submitBtn" class="button">
				</div>
			<% }else{%>
			<div class="textA">
				<textarea name = "content" id = "rev_content" readonly="readonly" class="rev_content">댓글쓰기 권한이 없습니다. 로그인이 필요합니다</textarea>
			</div>
			<%} %>
		
			
			<%for(ReviewBean rb : reviewList) {%>
			
			
				<div><%=rb.getContent() %></div>
				<div class="re"> <%=rb.getName() %>| <%=rb.getdDate()%><%=rb.getIdx() %></div>
				<a href="BoardReply.bo?movieSeq=<%=rb.getMovieSeq()%>&idx=<%=rb.getIdx()%>">
				<input type="button"  value="답댓글" id="ReviewReply" class="button" ></a>
				 <input type="button" value="수정" id="updateReply_<%=rb.getIdx() %>" class="button">
            	 <input type="button" value="삭제" id="deleteReply_<%=rb.getIdx() %>" class="button">
          		
          		<div id="update-message" title="댓글 수정" style="display:none">
			    <textarea id="replyUpdate" name="replyUpdate" cols="30" rows="5"></textarea>
			     댓글을 수정해주세요.
				</div>		
				
 <script type="text/javascript">
$(document).ready(function() {
	var query = $('#query').val();
	var movieSeq = $('#movieSeq').val();
	var name = $('#name').val();
	var idx = <%=rb.getIdx() %>;

	console.log(query);	
	console.log(movieSeq);	
	console.log(name);	
	console.log(idx);	

	$('#updateReply_<%=rb.getIdx() %>').click(function() {
		 $('#update-message').dialog({
			 modal: true,
             buttons: {
                 "수정": function() {
                     
                     name = $('#name').val()
                     movieSeq = $("#movieSeq").val();
                     idx = $('#idx').val();
                     reply = $('#replyUpdate').val();
                     
                     $.ajax({
                    	 url: "BoardReviewUpdate.bo?idx=<%=rb.getIdx() %>",
                    	 method: "get",
                         data: {
                             idx:idx,
                             movieSeq:movieSeq,
                             name:name,
                             reply:reply
                         },		 
                    			 
                         success: function(data) {
                        	 console.log(data);
                        	 $('#replyShow').append(reply);
                             location.reload();
                         }
                     });
                     
                     $(this).dialog('close');
                  },//수정
                  "취소": function() {
                      $(this).dialog('close');
                  }
             }
		 });
	});
	
	
	
// 	//리뷰 리스트
// 	function getReview(){
// 		$.ajax({
// 			url:"BoardReviewList.bo",
// 			type:"post",
// 			dataType:"json",
// 			daga:{
// 				query:query,
// 	 			movieSeq:movieSeq
// 			},
// 			success: function(json) {
// 				console.log("승공");
// 				console.log(json);
// 				json = json.replace(/\n/gi,"\\r\\n"); 
				
// 				var obj = JSON.parse(json);
// 				var reviewList = obj.reviewList;
				
// 				for (var i = 0; i < reviewList.length; i++) {
// 					for (var j = 0; j < reviewList[i].length; j++) {
// 	                    var review = reviewList[i][j];
// 	                    if(j === 0){
// 	                    	$('#replyList').append('<div>'+review.name+'</div>'+'<div>'+review.content+'</div>');
// // 	     					output += "<i class='fa fa-user'></i>&nbsp;&nbsp;" + review.name + "&nbsp;&nbsp;";
// 	                    }else if(j === 1){
// 	                    	$('#replyList').append('<div>'+review.name+'</div>'+'<div>'+review.content+'</div>');
// // 	     					output += "&nbsp;&nbsp;<i class='fa fa-calendar'></i>&nbsp;&nbsp;" + review.date;
// 	                    }else if(j === 2){
// 	                    	$('#replyList').append('<div>'+review.name+'</div>'+'<div>'+review.content+'</div>');
// // 	     					output += "<pre>" + review.content + "</pre></div>";
// 	                    }
				
				
// 				};
// 			};
			
// 			$("#replyList").html(output); // replyList 영역에 output 출력
//              	$(".reply_count").html(i);
// 			}
// 		});//ajax
		
// 	};
	
	
	
	
// 	$.ajax("BoardReviewList.bo", {
// 		method:"post",
// // 		dataType:"json",
// 		async:false,
// 		data:{
// 			query:query,
// 			movieSeq:movieSeq
// 		},
// 		success: function(data) {
// 			console.log("성");

// 			console.log(data);
// 		}
		
// 	}); //ajax
	
	
	$('#submitBtn').click(function() {
	var review = $('#rev_content').val();
		
	
	//리뷰 쓰기
	$.ajax("BoardReviewWrite.bo", {
		method:"post",
		datatype:"param",
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
          
          
				<%} %>
			
		
				
		
		<input type="hidden" id="name" name="name" value="<%=name%>">
		<input type="hidden" id="movieSeq" name="movieSeq" value="<%=movieSeq%>">
		<input type="hidden" id="query" name="query" value="<%=query%>">
	
		
	
		
		
</body>
</html>