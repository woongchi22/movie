<%@page import="board.vo.ReplyBean"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<%
ReplyBean replyBean = (ReplyBean) request.getAttribute("replyBean");
ArrayList<ReplyBean> replyList = (ArrayList<ReplyBean>)request.getAttribute("replyList");
int idx = Integer.parseInt(request.getParameter("idx"));
int movieSeq = Integer.parseInt(request.getParameter("movieSeq"));
String name = (String) session.getAttribute("name");

%>
<script src="//code.jquery.com/jquery-1.11.1.min.js"></script>
<!-- <script src="//maxcdn.bootstrapcdn.com/bootstrap/3.3.0/js/bootstrap.min.js"></script> -->
<!-- <link href="//maxcdn.bootstrapcdn.com/bootstrap/3.3.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css"> -->
<link href="${pageContext.request.contextPath}/css/default.css" rel="stylesheet" type="text/css">
<script src="${pageContext.request.contextPath}/js/jquery-3.5.1.js"></script>
<script src="${pageContext.request.contextPath}/js/jquery-ui.js"></script>

<title></title>
	<h2>답댓글</h2>
</head>
<header>
	<jsp:include page="/inc/top.jsp"/>
</header>
<body>
	<div>
		<div><%=replyBean.getContent() %></div>
		<div class ="re"><%=replyBean.getName() %> | <%=replyBean.getDate() %></div>
		
	</div>
	<div class="textA">
		<textarea id = "rev_content" class="rev_content"></textarea>
		<input type = button value="등록" id = "submitBtn" class= "button" >
		<input type = button value="취소" class= "button" onClick="history.go(-1)">
	
	</div>
<%-- 	<%for(int i = 0; i < replyList.size(); i++) {%> --%>
	<%for(ReplyBean rb:replyList) {%>
				<div>
				<div><%=rb.getContent() %></div>
				<div class="re"> <%=rb.getName() %>| <%=rb.getDate()%></div>
				<%if(name.equals(rb.getName())){%>
				 <input type="button" value="수정" id="updateReply_<%=rb.getIdx() %>" class="button">
            	 <input type="button" value="삭제" id="deleteReply_<%=rb.getIdx() %>" class="button">
          		<%} %>
          		<div id="update-message_<%=rb.getIdx() %>" title="댓글 수정" style="display:none">
			    <textarea id="replyUpdate_<%=rb.getIdx() %>" name="replyUpdate" cols="30" rows="5"></textarea>
			     댓글을 수정해주세요.
				</div>		
				
				<div id = "delete-message_<%=rb.getIdx() %>" title="댓글 삭제" style="display:none">
				댓글을 삭제하시겠습니까?
				</div>
				</div>
<script type="text/javascript">
$(document).ready(function() {
	var movieSeq = $('#movieSeq').val();
	var idx = <%=rb.getIdx() %>;
	var name = $('#name').val();

	//리뷰삭제
	$('#deleteReply_<%=rb.getIdx() %>').click(function() {
		 $('#delete-message_<%=rb.getIdx() %>').dialog({
			 modal: true,
			 async : false,
             buttons: {
               "확인": function() {
                   
                   idx = $('#idx').val();
                   console.log(idx);
                   
                   $.ajax({
                  	 url: "BoardReplyDelete.bo?idx=<%=rb.getIdx()%>",
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
	$('#updateReply_<%=rb.getIdx() %>').click(function() {
		 $('#update-message_<%=rb.getIdx() %>').dialog({
			 modal: true,
			 async : false,
             buttons: {
                 "수정": function() {
                     
                     name = $('#name').val()
                     movieSeq = $("#movieSeq").val();
                     idx = $('#idx').val();
                     reply = $('#replyUpdate_<%=rb.getIdx() %>').val();
                     console.log('수정된댓글'+reply);
                     
                     $.ajax({
                    	 url: "BoardReplyUpdate.bo?idx=<%=rb.getIdx()%>",
                    	 method: "get",
                         data: {
                             idx:idx,
                             movieSeq:movieSeq,
                             name:name,
                             reply:reply
                         },		 
                    			 
                         success: function(data) {
                        	 console.log(reply);
//                              location.reload();
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
	
	
// 	// 답댓글
// 	$('#submitBtn').click(function() {
// 		var content = $('#rev_content').val();
// 		var content = $('#rev_content').val();
// 		console.log(content);
		
// 		$.ajax("BoardReplyWrite.bo", {
// 			method:"post",
// 			async: false,
// 			data:{
// 				content:content,
// 				idx:idx,
// 				movieSeq:movieSeq
// 			},
// 			success: function(data) {
// 				console.log("성공");
// 				console.log(data);
// 	            location.reload();

// 			}
			
			
			
// 		});
		
// 	});//click
	
});//ready


</script>
			<%} %>
	
	
	<input type="hidden" id="name" name="name" value="<%=name%>">
	<input type="hidden" id="movieSeq" name="movieSeq" value="<%=movieSeq%>">
	<input type="hidden" id=idx name="idx" value="<%=idx%>">
	
	
	
	
</body>
</html>