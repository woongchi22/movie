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
<link href="${pageContext.request.contextPath}/css/default.css" rel="stylesheet" type="text/css">
<script src="${pageContext.request.contextPath}/js/jquery-3.5.1.js"></script>

<script type="text/javascript">
$(document).ready(function() {
	var query = $('#query').val();
	var movieSeq = $('#movieSeq').val();
	
	$.ajax("MovieSearchPro.mo",{
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
	                var openDt = item2.ratings.rating[0].ratingDate;
	                var company = item2.company;
					var poster = item2.posters.split("|");
					for(var num=0; num < item2.actors.actor.length; num++){
						actor = actor + item2.actors.actor[num].actorNm+ " ";
					}
					for(var num=0; num < item2.directors.director.length; num++){
						director = director + item2.directors.director[num].directorNm+ " ";
					}
					
					var actorT = actor.trim();
					var actors = actorT.replace(/ /g, ', ');					
					var directT = director.trim();
					var directors = directT.replace(/ /g, ', ');
					
					
					$('.info').append('<div class=poster style="background-image:url('+poster[0]+'),url(${pageContext.request.contextPath}/img/noImage.gif);"></div><div class=title>'
							+ title4 +'</div><div class=rating>'+rating+'</div><div class=runtime>'
							+runtime+'분</div><div class=plot>'+plot+'</div><div class=directors>'+directors+'</div><div class=actors>'
							+actors+'</div><div class=genre>'+genre+'</div><div class=nation>'+nation+'</div><div class=openDt>'
							+openDt+'</div><div class=company>'+company+'</div>');
							
					
					
				});	
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


<div class = "info">

</div>
</body>
</html>