<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<%
	String name = (String)session.getAttribute("name"); 
	String movieSeq = (String)request.getParameter("movieSeq");
	String query = request.getParameter("query");
	String poster = (String)request.getParameter("image");
	String director=request.getParameter("director");
%>
<title>[WhatFilx] <%=query %></title>
<link rel="stylesheet" type="text/css" href="slick/slick.css"/>
<link rel="stylesheet" type="text/css" href="slick/slick-theme.css"/>	
<link href="${pageContext.request.contextPath}/css/default.css" rel="stylesheet" type="text/css">
<script src="${pageContext.request.contextPath}/js/jquery-3.5.1.js"></script>

<script type="text/javascript">
$(document).ready(function() {
	var query = $('#query').val();
	var movieSeq = $('#movieSeq').val();
	
	$.ajax("MovieDetail.mo",{
		method:"post",
		dataType:"json",
		data:{
			query:query,
			movieSeq:movieSeq
		},
		success: function(data){
			$.each(data.Data, function(idx,item) {
				$.each(item.Result, function(idx2,item2) {
					console.log("왔다");
					console.log(item2);
					
					var title1 = item2.title
					var titleNoSpace = title1.replace(/ /g, ''); // 타이틀 공백제거
					var title2 = titleNoSpace.replace(/!HS/g,'') // 검색어는 !HS , !HE 로 둘러 싸여있어서 제거해줌
	                var title3 = title2.replace(/!HE/g,'')
	                var title4 = title3.trim(); // 양쪽끝에 공백을 제거해줌
	                var title = encodeURIComponent(title4);
	                
	                var rating = item2.rating;
					var runtime = item2.runtime;
	                var plot = item2.plots.plot[0].plotText;
	                var director = "";
	                var actor = "";
	                var genre = item2.genre;
	                var nation = item2.nation;
	                var openDt = item2.ratings.rating[0].ratingDate.substr(0,4);
	                var company = item2.company;
					var poster = item2.posters.split("|");
					var stills = item2.stlls.split("|");
					
					
					console.log(stills);
					console.log(openDt);
					
					for(var num=0; num < item2.actors.actor.length; num++){
						actor = actor + item2.actors.actor[num].actorNm+ ", ";
					}
					for(var num=0; num < item2.directors.director.length; num++){
						director = director + item2.directors.director[num].directorNm+ " ";
					}
					
					for(var i in stills){
						console.log(stills[i]);
						
						if (stills[i]) {
		                     $('.stills').append('<div class=stillCut style="background-image: url(' + stills[i] + ');"></div>')
		                     //                           $('.posters').append('<div class=stillCut><img style="height:150px;" src='+stills[i]+' onerror=this.src=../../../Movie/img/noImage.gif></div>')
		                 } else {
// 		                     $('.stills').append('<div class=stillCut style="background-image: url(${pageContext.request.contextPath}/img/noImage.gif;")></div>')
		                 }
							
				}
					
					var actors = actor.replace(/,\s*$/, '');
					var directors = director.replace(/,\s*$/, '');
					
					$('.title_top').append('<div class=title_top>'+title4+'</div>');
					$('.posters').append('<div class=poster style="background-image:url('+poster[0]+'),url(${pageContext.request.contextPath}/img/noImage.gif);"></div>');
					$('.info').append('<dt>ㅁㅁ</dt><div class=runtime>'+rating+' '+runtime+'분</div><div class=plot style="margin-bottom:7px;">'+plot+'</div><dt>감독</dt><div class=directors>'+directors+'</div><dt>출연</dt><div class=actors>'
							+actors+'</div><dt>개요</dt><div class=summaryInfo>'+genre+' | '+nation+' | '+openDt+'</div><dt>배급</dt><div class=company>'+company+'</div>');
							
					
// 					$('.info').append('<div class=poster style="background-image:url('+poster[0]+'),url(${pageContext.request.contextPath}/img/noImage.gif);"></div><div class=title>'
// 							+ title4 +'</div><dt >ㅁㅁ</dt><div class=runtime>'+rating+' '+runtime+'분</div><div class=plot>'+plot+'</div><dt>감독</dt><div class=directors>'+directors+'</div><dt>출연 </dt><div class=actors>'
// 							+actors+'</div><dt>개요</dt><div class=summaryInfo>'+genre+' | '+nation+' | '+openDt+'</div><dt>배급</dt><div class=company>'+company+'</div>');
					
// 					$('.info').append('<div class=poster style="background-image:url('+poster[0]+'),url(${pageContext.request.contextPath}/img/noImage.gif);"></div><div class=title>'
// 							+ title4 +'</div><dt >개요</dt><div class=summaryInfo>'+rating+'</div><dt>상영시간</dt><div class=runtime>'
// 							+runtime+'분</div><dt>줄거리</dt><div class=plot>'+plot+'</div><dt>감독</dt><div class=directors>'+directors+'</div><dt>출연 </dt><div class=actors>'
// 							+actors+'</div><dt>장르</dt><div class=genre>'+genre+'</div><dt>국가</dt><div class=nation>'+nation+'</div><dt>개봉</dt><div class=openDt>'
// 							+openDt+'</div><dt>배급사</dt><div class=company>'+company+'</div>');
							
					
				});	
			});
				
			$('.stills').slick({
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
			   	 });	
			
			
			
			
			
		}
	});	
	
	
	 
});


</script>
</head>
<header>
	<jsp:include page="/inc/top.jsp"/>
</header>
<body>

<input type ="hidden" id="query" name="query" value="<%=query %>">
<input type ="hidden" id="movieSeq" name="movieSeq" value="<%=movieSeq %>">

<div class="wrap">

<div class="title_top"></div>
<div class="posters" ></div>
<div class= "info">

</div>
<div class="stills" ></div>

</div>



  <script type="text/javascript" src="//code.jquery.com/jquery-1.11.0.min.js"></script>
  <script type="text/javascript" src="//code.jquery.com/jquery-migrate-1.2.1.min.js"></script>
  <script type="text/javascript" src="slick/slick.min.js"></script>	
</body>
</html>