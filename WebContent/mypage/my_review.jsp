<%@page import="movie.vo.MovieBean"%>
<%@page import="board.vo.ReviewBean"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<%
ArrayList<ReviewBean> reviewList = (ArrayList<ReviewBean>)request.getAttribute("reviewList");
ArrayList<MovieBean> movieList = (ArrayList<MovieBean>)request.getAttribute("movieList");
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
		<li class="active"><a href="Mypage.mp">개인정보 수정</a></li>
		<li><a href="BoardMyReviewList.bo?name=<%=name %>">▶&nbsp; 내가 평가한 영화</a></li>
		<li><a href="MypageCollection.mp?name=<%=name%>">컬렉션</a></li>
	</ul>
</div>

	<div class="noMovie">아직 평가한 영화가 없습니다.</div>

	<%for(MovieBean mb : movieList) { %>
	   <script type="text/javascript">
          $('.noMovie').css("display", "none");
       </script>
       
	   <div class="myReAll">
	       <div class="myGradeList" id="ms_<%=mb.getMovieSeq() %>">
               <div class="reviewPoster" style="background-image: url('<%=mb.getPoster() %>'), url(${pageContext.request.contextPath}/img/noImage.gif);"></div>
	           <div class="reviewTitle"><%=mb.getTitle() %></div>
	           <div class="reviewGrade"><img class="reviewStar" src="img/star3.png"> <%=mb.getGrade() %>점</div>
	           <hr>
               <div class="reviewGo"><a class="reA" href="MovieDetailPro.mo?movieSeq=<%=mb.getMovieSeq()%>&query=<%=mb.getTitle()%>">▶&nbsp;코멘트 쓰러가기</a></div>
               <hr>
               <div class="button">
                  <a href="MovieDetailPro.mo?movieSeq=<%=mb.getMovieSeq()%>&query=<%=mb.getTitle()%>">
                   <input type="button" class="updateBtn" value="수정"></a>
                   <input type="button" id="gradeDeleteBtn_<%=mb.getIdx() %>" class="deleteBtn" value="삭제">
               </div>
	       </div>
	   </div>
	   
	   <script type="text/javascript">
	   $(document).ready(function() {
		    // 평점부분 삭제
		    $('#gradeDeleteBtn_<%=mb.getIdx()%>').click(function() {
		        name = $('#name_<%=mb.getMovieSeq()%>').val();
		        movieSeq = $('#movieSeq_<%=mb.getMovieSeq()%>').val();
		        query = $('#query').val();
                
		          $('#dialog-delete').dialog({
		                title: "삭제",
		                modal: true,
		                buttons: {
		                     "확인": function() {
		                         $.ajax({
		                             url: "DeleteStar.mo",
		                             method: "get",
		                             async: false,
		                             data: {
		                                 name:name,
		                                 movieSeq:movieSeq,
		                                 query:query
		                             },
		                             success: function(data) {
		                             }
		                         });
		                         $(this).dialog('close');
		                         location.reload();
		                     },
		                     "취소": function() {
		                         $(this).dialog('close');
		                         
		                     }
		                 }
		        
		            });
		        
		    });
		});
	   
	   </script>
	   <input type="hidden" id="name_<%=mb.getMovieSeq()%>" name="name" value="<%=mb.getName()%>">
       <input type ="hidden" id="query" name="query" value="<%=mb.getTitle()%>">
       <input type ="hidden" id="movieSeq_<%=mb.getMovieSeq()%>" name="movieSeq" value="<%=mb.getMovieSeq()%>">
	   
	   <%for(ReviewBean rb : reviewList){ %>
            <%if(mb.getMovieSeq() == rb.getMovieSeq() && rb.getContent() != null) { %>
                <script type="text/javascript">
                   $('#ms_'+<%=mb.getMovieSeq() %>).css("display", "none");
                </script>
            
            <%} %>
       <%} %>
	<%} %>
	
	<%for(ReviewBean rb : reviewList){ %>
	   <script type="text/javascript">
	      $('.noMovie').css("display", "none");
	   </script>
	   
	   	<div class="myReAll">
			<div class="myReviewList">
			     <div class="reviewPoster" style="background-image: url('<%=rb.getPoster() %>'), url(${pageContext.request.contextPath}/img/noImage.gif);"></div>
				 <div class="reviewTitle"><%=rb.getTitle() %></div>
				 <div class="reviewGrade"><img class="reviewStar" src="img/star3.png"> <%=rb.getGrade() %>점</div>
				 <hr>
				 <div class="reviewContent"><%=rb.getContent() %></div>
				 <hr>
				 <div class="button">
				 	<a href="MovieDetailPro.mo?movieSeq=<%=rb.getMovieSeq()%>&query=<%=rb.getTitle()%>">
					 <input type="button" class="updateBtn" value="수정"></a>
					 <input type="button" id="deleteBtn_<%=rb.getIdx() %>" class="deleteBtn" value="삭제">
				 </div>
				 <div id="dialog-delete" style="display:none">코멘트를 삭제하시겠습니까?</div>
			</div>
		</div>
	   

<script type="text/javascript">
$(document).ready(function() {
	//리뷰 삭제
	$('#deleteBtn_<%=rb.getIdx()%>').click(function() {
		name = $('#name_<%=rb.getMovieSeq()%>').val();
		movieSeq =$('#movieSeq_<%=rb.getMovieSeq()%>').val();
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
	                         }
	                     });
	                     $(this).dialog('close');
	                     location.reload();
	                 },
	                 "취소": function() {
	                     $(this).dialog('close');
	                     
	                 }
	             }
	    
	        });
		
	});
});


</script>
<input type="hidden" id="name_<%=rb.getMovieSeq()%>" name="name" value="<%=rb.getName()%>">
<input type ="hidden" id="query" name="query" value="<%=rb.getTitle()%>">
<input type ="hidden" id="movieSeq_<%=rb.getMovieSeq()%>" name="movieSeq" value="<%=rb.getMovieSeq()%>">
    <%} %>
   

</body>
</html>