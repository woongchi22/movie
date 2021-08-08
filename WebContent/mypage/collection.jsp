<%@page import="mypage.vo.CollectionBean"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<%
request.setCharacterEncoding("UTF-8");
String name = (String)session.getAttribute("name");
ArrayList<CollectionBean> collection = (ArrayList<CollectionBean>)(request.getAttribute("collection")); 

%>
<head>
<meta charset="UTF-8">
<title>My collection</title>
<link href="${pageContext.request.contextPath}/css/collection.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath}/css/default.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath}/css/movie.css" rel="stylesheet" type="text/css">
<script src="${pageContext.request.contextPath}/js/jquery-3.5.1.js"></script>

<%-- slick --%>
<script type="text/javascript" src="//code.jquery.com/jquery-1.11.0.min.js"></script>
<script type="text/javascript" src="//code.jquery.com/jquery-migrate-1.2.1.min.js"></script>
<link rel="stylesheet" type="text/css" href="slick/slick.css"/>
<link rel="stylesheet" type="text/css" href="slick/slick-theme.css"/>   
<script type="text/javascript" src="slick/slick.min.js"></script>

<script type="text/javascript">
$(document).ready(function() {

	$('#showAddCollection').click(function() {
		$('#showCollection').show();
		$('#showAddCollection').hide();
	});
	
	$('#addMov').click(function(){
		
		window.open("CollectionSearch.mo",
				"open the window",
				"toolbar=no, width=1000, height=850, top=150, left=150");
	});	


	$('#submit').click(function(){
		if($('#subject').val() == ''){
			alert("제목을 입력하세요")
			return false;
		}
		if($('#content').val() == ''){
			alert("내용을 입력하세요")
			return false;
		}
		if($('#movieSeq').length < 1){
			alert("영화를 선택하세요");
			return false;
		} 
		location.reload();
	})
	
	$('.collectionView').slick({
		   dots: false,
	     infinite: false,
	     arrows: true,
	     variableWidth:true,
	     speed: 300,
	     slidesToShow: 4,
	     slidesToScroll: 3,
		   responsive: [
		     {
		       breakpoint: 1024,
		       settings: {
		         slidesToShow: 3,
		         slidesToScroll: 3,
		         infinite: false,
		         dots: false
		       }
		     },
		     {
		       breakpoint: 600,
		       settings: {
		         slidesToShow: 2,
		         slidesToScroll: 2
		       }
		     },
		     {
		       breakpoint: 480,
		       settings: {
		         slidesToShow: 1,
		         slidesToScroll: 1
		       }
		     }
		   ]
		 });	//$('.collectionView').slick() 끝
	$('#movies').slick({
		 dots: false,
	     infinite: false,
	     arrows: true,
	     variableWidth:true,
	     speed: 300,
	     slidesToShow: 4,
	     slidesToScroll: 3,
		   responsive: [
		     {
		       breakpoint: 1024,
		       settings: {
		         slidesToShow: 3,
		         slidesToScroll: 3,
		         infinite: false,
		         dots: false
		       }
		     },
		     {
		       breakpoint: 600,
		       settings: {
		         slidesToShow: 2,
		         slidesToScroll: 2
		       }
		     },
		     {
		       breakpoint: 480,
		       settings: {
		         slidesToShow: 1,
		         slidesToScroll: 1
		       }
		     }
		   ]
		 }); //$('#movies').slick() 끝
	
});//ready


</script>
</head>

<header>
    <jsp:include page="/inc/top.jsp"/>
</header>
<body>

<div class="sidebar">
	<ul>
		<li class="active"><a href="Mypage.mp">개인정보 수정</a></li>
		<li><a href="BoardMyReviewList.bo?name=<%=name %>" data-nav-section="review">내가 평가한 영화</a></li>
		<li><a href="MypageCollection.mp?name=<%=name%>">▶&nbsp; 컬렉션</a></li>
	</ul>
	
</div>

<div style="margin-left:  300px;">
	<input type="button" value="컬렉션 추가" id="showAddCollection" class="collectionBtn">
	
	<div style="display: none;" id="showCollection" class="showCollection">
		<form action ="MypageCollectionCreate.mp" method="post">
			<div class="c_title">Collection</div>
			<input type ="text" name="subject"id="subject" class="subject">
			<div class="c_title"><input type ="button" id="addMov" value="작품추가" class="collectionBtn"></div>
			<div id="movies">
			</div>
			<div class="c_title"><input type="submit" value="생성" id="submit" class="collectionBtn"></div>		
		</form>	
	</div>

<div><h3><%=name %> 님의 컬렉션 목록</h3></div>
<%for(int i = 0; i < collection.size(); i++){ %>
<div class="c_list">
<div><h2>Collection:<%=collection.get(i).getCollection_name() %></h2>
	<input type ="button" id="c_update" value="수정">
</div>
	<div class="collectionView" >
		<%for(int o = 0; o < collection.get(i).getTitle().split(",").length; o++){%>
			<div class ="eachList<%=o %>" id="eachList">
			<div id="modifyMovies"></div>
			<a href="MovieDetailPro.mo?movieSeq=<%=collection.get(i).getMovieSeq().split(",")[o]%>&query=<%=collection.get(i).getTitle().split(",")[o]%>">
			</a>
			<div class="poster" style="background-image: url('<%=collection.get(i).getPoster().split(",")[o]%>'),url(${pageContext.request.contextPath}/img/noImage.gif;"></div>
			<div class="title"><%=collection.get(i).getTitle().split(",")[o]%></div>
	
			<div class="modifyDel">
			<input type="button" class ="modifyBtn" id="eachList<%=o %>" value="삭제"><br>
			</div>
			
			<input type="hidden" name="movieSeq" value="<%=collection.get(i).getMovieSeq().split(",")[o]%>">
			<input type="hidden" name="title" value="<%=collection.get(i).getTitle().split(",")[o]%>">
			<input type="hidden" name="poster" value="<%=collection.get(i).getPoster().split(",")[o]%>">
			<input type="hidden" name="idx" value="<%=collection.get(i).getIdx()%>">
			</div>
			
		<%} %>
	</div>
</div>
<%} %>
</div>

<input type="hidden" id="name" name="name" value="<%=name %>">

</body>
</html>