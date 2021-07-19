<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<%
String name = (String)session.getAttribute("name"); 
%>
<title>[WhatFilx]</title>
<link href="${pageContext.request.contextPath}/css/default.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath}/css/movie.css" rel="stylesheet" type="text/css">
<script src="${pageContext.request.contextPath}/js/jquery-3.5.1.js"></script>
<script type="text/javascript">
$(document).ready(function() {
	
	$('.caption').html('<h2> 보고싶은 작품을 찾아보세요 </h2>');

	$("#selected *").remove();
	$('#genreExplore').change(function() {
		var genre = $('#genreExplore option:selected').val();
		var name = $('#name').val();
		var nations = $('#nationExplore option:selected').val();
		console.log(genre);
		
		$("#selected *").remove();
		$.ajax("ExploreMovieAction.mo", {
			async: false,	
			dataType:"json",
			method: 'post',
			data: {
				genre:genre,
				nations:nations
			},
			success: function(data) {
         	    $('.caption').html('<h2>'+name+'님에게 추천하는 '+nations+' '+ genre +' 영화</h2>');
         	    console.log("여 오나");
         	    $.each(data.Data, function(idx,item) {
					console.log("토탈카운트"+item.TotalCount);
				});
// 				$.each(data.Data, function(idx,item) {
// 					$.each(item.Result, function(idx2,item2) {
// 					    var title1 = item2.title
// 	                    var titleNoSpace = title1.replace(/ /g, ''); // 타이틀 공백제거
// 	                    var title2 = titleNoSpace.replace(/!HS/g,'') // 검색어는 !HS , !HE 로 둘러 싸여있어서 제거해줌
// 	                    var title3 = title2.replace(/!HE/g,'')
// 	                    var title4 = title3.trim(); // 양쪽끝에 공백을 제거해줌
// 	                    var title = encodeURIComponent(title4);
// 	                    var prodYear = item2.prodYear
	                    
// 	                    console.log(prodYear);
// 	                    var posters = item2.posters.split("|");
// 	                    var poster = posters[0]
		                    
	                    
// 	                    if(poster) {
// 	                        $('#selected').append('<div id=gradeMovie><a href=MovieDetailPro.mo?movieSeq=' + item2.movieSeq + '&query='
//                               + title + '><div class=gradePoster style="background-image: url(' + poster + '), url(${pageContext.request.contextPath}/img/noImage.gif;"></div></a><div class="gradeTitle">'
//                               + title4 + '</div></div>');
	                                
// 	                    }
                       
// 					});
// 				});
			}
		});
	}); //change
	
	$('#nationExplore').change(function() {
		var genre = $('#genreExplore option:selected').val();
		var name = $('#name').val();
		var nations = $('#nationExplore option:selected').val();
		console.log(nations);
		
		$("#selected *").remove();
		$.ajax("NationExploreMovieAction.mo", {
			async: false,	
			dataType:"json",
			method: 'post',
			data: {
				nations:nations,
				genre:genre
			},
			success: function(data) {
         	    $('.caption').html('<h2>'+name+'님에게 추천하는 '+nations+' '+ genre +' 영화</h2>');
         	    
         	    $.each(data.Data, function(idx,item) {
                   var totalCount = item.TotalCount
                   console.log(totalCount);
                   
                   $.ajax("CountNationExploreMovieAction.mo", {
                	   async: false,    
                       dataType:"json",
                       method: 'post',
                       data: {
                           nations:nations,
                           genre:genre,
                           totalCount:totalCount
                       }, 
                       success: function(data) {
						
                    	   console.log("발제에ㅜ");
                    	   
                    	   
                    	   
                    	   
                    	   
                       }
                       
                       
                       
                   });
                   
                   
                   
                   
                   
                   
               });
// 				$.each(data.Data, function(idx,item) {
// 					$.each(item.Result, function(idx2,item2) {
// 					    var title1 = item2.title
// 	                    var titleNoSpace = title1.replace(/ /g, ''); // 타이틀 공백제거
// 	                    var title2 = titleNoSpace.replace(/!HS/g,'') // 검색어는 !HS , !HE 로 둘러 싸여있어서 제거해줌
// 	                    var title3 = title2.replace(/!HE/g,'')
// 	                    var title4 = title3.trim(); // 양쪽끝에 공백을 제거해줌
// 	                    var title = encodeURIComponent(title4);
// 	                    var prodYear = item2.prodYear
	                    
// 	                    console.log(title4);
// 	                    var posters = item2.posters.split("|");
// 	                    var poster = posters[0]
		                    
	                    
// 	                    if(poster) {
// 	                        $('#selected').append('<div id=gradeMovie><a href=MovieDetailPro.mo?movieSeq=' + item2.movieSeq + '&query='
//                               + title + '><div class=gradePoster style="background-image: url(' + poster + '), url(${pageContext.request.contextPath}/img/noImage.gif;"></div></a><div class="gradeTitle">'
//                               + title4 + '</div><input type="hidden" id = "prodYear" name="prodYear" value = '+prodYear+'></div>');
	                                
// 	                    }
                       
// 					});
// 				});
			}
		});
	}); //change
	
	$('#year').change(function() {
		  $('#year').sort(function(a, b) { // 오름차순
		    return a.$('.gradeTitle') < b.$('.gradeTitle') ? -1 : a.$('.gradeTitle') > b.$('.gradeTitle') ? 1 : 0;
		});

	});
	
	
	
	
	
});





</script>


</head>
<header>
    <jsp:include page="/inc/top.jsp"/>
</header>
<body>
    <div class="caption"></div>
    <div class="exploreBar" style="padding: 0 10px;">
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
            <option id="music">뮤직</option>
            <option id="mystery">미스터리</option>
            <option id="crime">범죄</option>
            <option id="historical">시대극/사극</option>
            <option id="western">서부</option>
            <option id="thriller">스릴러</option>
            <option id="sport">스포츠</option>
            <option id="kids">아동</option>
            <option id="ani">애니메이션</option>
            <option id="action">액션</option>
            <option id="adventure">어드벤처</option>
            <option id="omnibus">옴니버스</option>
            <option id="disaster">재난</option>
            <option id="war">전쟁</option>
            <option id="comedy">코메디</option>
            <option id="fantasy">판타지</option>
            <option id="highteen">하이틴</option>
        </select>
        
        <select id="nationExplore">
            <option id="allNation">모든 국가</option>
            <option id="korea">대한민국</option>
            <option id="germany">독일</option>
            <option id="unitedStates">미국</option>
            <option id="spain">스페인</option>
            <option id="england">영국</option>
            <option id="italy">이탈리아</option>
            <option id="india">인도</option>
            <option id="japan">일본</option>
            <option id="china">중국</option>
            <option id="canada">캐나다</option>
            <option id="france">프랑스</option>
            <option id="hongkong">홍콩</option>
        </select>
        
        <select id="sort" style="float: right;margin-right: 40px;">
            <option id="sortRecommand">추천순</option>
            <option id="year">최신작품순</option>
            <option id="runtime">러닝타임 짧은 순</option>
            
            
        </select>
    </div>
    
    <div id="selected"></div>
    <input type="hidden" id="name" name="name" value="<%=name %>">
    

</body>
</html>