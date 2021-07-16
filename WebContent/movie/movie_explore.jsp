<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>[WhatFilx]</title>
<link href="${pageContext.request.contextPath}/css/default.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath}/css/movie.css" rel="stylesheet" type="text/css">
<script src="${pageContext.request.contextPath}/js/jquery-3.5.1.js"></script>
<script type="text/javascript">
$(document).ready(function() {
	
	$('#genreExplore').change(function() {
// 		var genre = $(this).val();
// 		console.log(genre);
// 		$(this).val();
		var genre = $(this).children("option:selected").val();
		console.log(genre);
		
		$.ajax("ExploreMovieAction.mo", {
			method: 'post',
			data: {
				genre:genre
			},
			success: function(data) {
				console.log(data);
			}
			
			
		});
		
		
        
	});
	
	
	
	
	
	
	
	
	
});





</script>


</head>
<header>
    <jsp:include page="/inc/top.jsp"/>
</header>
<body>

    <h2>찾고싶은 작품을 탐색해보세요</h2>
    <div class="exploreBar">
        <select id="genreExplore">
            <option id="allGenre">모든 장르</option>
            <option id="sf">SF</option>
            <option id="family">가족</option>
            <option id="horror">공포</option>
            <option id="docu">다큐멘터리</option>
            <option id="homo">동성애</option>
            <option id="drama">드라마</option>
            <option id="romance">로맨스</option>
            <option id="roco">로맨틱코메디</option>
            <option id="melo">멜로드라마</option>
            <option id="mystery">미스터리</option>
            <option id="crime">범죄</option>
            <option id="historical">사극/시대극</option>
            <option id="western">서부</option>
            <option id="thriller">스릴러</option>
            <option id="sport">스포츠</option>
            <option id="ani">애니메이션</option>
            <option id="action">액션</option>
            <option id="adventure">어드벤처</option>
            <option id="omnibus">옴니버스</option>
            <option id="music">음악</option>
            <option id="disaster">재난</option>
            <option id="war">전쟁</option>
            <option id="comedy">코메디</option>
            <option id="kids">키즈</option>
            <option id="fantasy">판타지</option>
            <option id="highteen">하이틴</option>
        </select>
        
        <select id="nationExplore">
            <option id="allNation">모든 국가</option>
            
        </select>
        
        <select id="recommandExplore">
            <option id="randomRecommand">랜덤 추천</option>
            
        </select>
        
    </div>
    
    <div id="selected"></div>

</body>
</html>