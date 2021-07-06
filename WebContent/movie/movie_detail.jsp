<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<%
String name = (String)session.getAttribute("name"); 
String pass = (String)session.getAttribute("pass");
String movieSeq = (String)request.getParameter("movieSeq");
String query = request.getParameter("query");
String poster = (String)request.getParameter("image");
String director=request.getParameter("director");


%>
<title>[WhatFilx] <%=query %></title>
<link rel="stylesheet" type="text/css" href="slick/slick.css"/>
<link rel="stylesheet" type="text/css" href="slick/slick-theme.css"/>	
<link href="${pageContext.request.contextPath}/css/default.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath}/css/movie.css" rel="stylesheet" type="text/css">
<script src="${pageContext.request.contextPath}/js/jquery-3.5.1.js"></script>
<script type="text/javascript" src="//code.jquery.com/jquery-1.11.0.min.js"></script>
<script type="text/javascript" src="//code.jquery.com/jquery-migrate-1.2.1.min.js"></script>
<script type="text/javascript" src="slick/slick.min.js"></script>
<script type="text/javascript">
$(document).ready(function() {
	var query = $('#query').val();
	var movieSeq = $('#movieSeq').val();
	var name = $('#name').val();
	var directorNm = null;

	
	$.ajax("MovieDetail.mo",{
		method:"post",
		dataType:"json",
		async: false,		
		data:{
			query:query,
			movieSeq:movieSeq
		},
		success: function(data){
			$.each(data.Data, function(idx,item) {
				$.each(item.Result, function(idx2,item2) {
					
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
					
					
					for(var num=0; num < item2.actors.actor.length; num++){
						actor = actor + item2.actors.actor[num].actorNm+ ", ";
					}
					for(var num=0; num < item2.directors.director.length; num++){
						director = director + item2.directors.director[num].directorNm+ " ";
					}
					
					for(var i in stills){
						
						if (stills[i]) {
		                     $('.stills').append('<div class=stillCut style="background-image: url(' + stills[i] + ');"></div>')
		                     //                           $('.posters').append('<div class=stillCut><img style="height:150px;" src='+stills[i]+' onerror=this.src=../../../Movie/img/noImage.gif></div>')
		                 } 
							
				}
					
					var actors = actor.replace(/,\s*$/, '');
					var directors = director.replace(/,\s*$/, '');
					directorNm=directors.replace(/ /g, '');
					
					$('.title_top').append('<div class=title_top>'+title4+'</div>');
					$('.star').append('<dt>평균별점: </dt><div class=runtime>'+rating+'&nbsp;  &middot;&nbsp;'+runtime+'분</div>');
					$('.posters').append('<div class=poster style="background-image:url('+poster[0]+'),url(${pageContext.request.contextPath}/img/noImage.gif);"></div>');
					$('.info').append('<div class=plot style="margin-bottom:7px;">'+plot+'</div><dt>감독</dt><div class=directors>'+directors+'</div><dt>출연</dt><div class=actors>'
							+actors+'</div><dt>개요</dt><div class=summaryInfo>'+genre+' &nbsp;|&nbsp; '+nation+' &nbsp;|&nbsp; '+openDt+'</div><dt>배급</dt><div class=company>'+company+'</div>');
							
					
					
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
			   	 }); //slick
		
			
			
			
			
			
		} //success
		
		
		
		
	});	
	
	
	// 찜꽁
	$.ajax("MovieDetail.mo", {
		method: "post",
		dataType: "json",
		data: {
			movieSeq:movieSeq,
			query:query
		},
		success: function(data) {
			
			$.each(data.Data, function(idx, item) {
				$.each(item.Result, function(idx, item2) {

                    var title1 = item2.title
                    var titleNoSpace = title1.replace(/ /g, ''); // 타이틀 공백제거
                    var title2 = titleNoSpace.replace(/!HS/g,'') // 검색어는 !HS , !HE 로 둘러 싸여있어서 제거해줌
                    var title3 = title2.replace(/!HE/g,'')
                    var title4 = title3.trim(); // 양쪽끝에 공백을 제거해줌
                    var title = encodeURIComponent(title4);
                    
                    var poster = item2.posters.split("|");
                    
				    $('.dibsBtn').click(function() {
                        var dibs = $('#dibs').val();
				    	$.ajax({
				    		url: "DibsPro.mp",
				    		type: "post",
				    		data: {
				    			name:name,
				    			movieSeq:movieSeq,
				    			query:query,
				    			poster:poster[0],
				    			dibs:dibs
				    		},
				    		success: function(data) {
				    			$('.dibsBtn').addClass('done');
				    			
				    			
							} // success2
				    	
				    	}); // ajax2
				        
				    }); // dibs 버튼 클릭
					
				}); //each2
				
				
			}); // each
			
		} // success
    
	}); // ajax
	
	//감독 다른 영화
	$.ajax('DirectorSearchPro.mo',{
		method:"post",
		dataType:"json",
		async: false,
		data:{query:directorNm},
		success: function(data) {
			$.each(data.Data, function(idx,item) {
				var count = item.Count;
				$.each(item.Result, function(idx, item2) {
					
					var title = item2.title
					var titleNoSpace = title.replace(/ /g, '');
					var title2 = titleNoSpace.replace(/!HS/g, '')
		            var title3 = title2.replace(/!HE/g, '')
		            var title5 = title3.trim();
		            var title6 = encodeURIComponent(title5);
		            var image = item2.posters.split("|");
		         console.log(title6);
		            
		            if(image[0]){
		            	$('.directorMovie').append('<div class="directorsMovie"><a href=MovieDetailPro.mo?movieSeq='+item2.movieSeq+'&query='+title6+'>'
		            			+'<div class=poster style="background-image:url('+image[0]+'),url(${pageContext.request.contextPath}/img/noImage.gif);"></div></a>'+
		            	'<div class=title>'+title+'</div></div>');
		            }
		            $('.directorP').text(directorNm + "감독의 다른 영화들");

						
						
				});
			});
		

			$('.directorMovie').slick({
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
<input type ="hidden" id="director" name="director" value="<%=director %>">
<input type="hidden" id="name" name="name" value="<%=name %>">
<input type="hidden" id="dibs" name="dibs" value="Y">


<div class="wrap">
	<div class="title_top"></div>
		<%if(pass != null) { %>
		   <div class="dibs"><button class="dibsBtn" value="<%=movieSeq %>"><img class="dibsBtnImg" src="img/check.png" width="20px" height="20px">&nbsp;찜</button></div>
		<%} else {%>   
		      <div class="dibsLogin"><a href="MemberLoginForm.me">로그인</a>하시고 별점을 남겨주세요</div>
		<%} %>
	<div class="star"></div>
	<div class="posters" ></div>
	<div style="width:250px;margin:0 auto;">
<!-- 	 <span class='star-input'> -->
<!-- 	       <span class='input'> -->
<!-- 	    <input type="button" class="c1" ><label style= "width: 10px; z-index: 10;" class="l1">1</label> -->
<!-- 	    <input type="button" class="c2" ><label style= "width: 20px; z-index: 9;" class="l2">2</label> -->
<!-- 	    <input type="button" class="c3" ><label style= "width: 30px; z-index: 8;" class="l3">3</label> -->
<!-- 	    <input type="button" class="c4" ><label style= "width: 40px; z-index: 7;" class="l4">4</label> -->
<!-- 	    <input type="button" class="c5" ><label style= "width: 50px; z-index: 6;" class="l5">5</label> -->
<!-- 	    <input type="button" class="c6" ><label style= "width: 60px; z-index: 5;" class="l6">6</label> -->
<!-- 	    <input type="button" class="c7" ><label style= "width: 70px; z-index: 4;" class="l7">7</label> -->
<!-- 	    <input type="button" class="c8" ><label style= "width: 80px; z-index: 3;" class="l8" >8</label> -->
<!-- 	    <input type="button" class="c9" ><label style= "width: 90px; z-index: 2;" class="l9">9</label> -->
<!-- 	    <input type="button" class="c10"><label style= "width: 100px; z-index: 1;" class="l10">10</label> -->
<!-- 	    </span></span> -->
	    </div>
	<div class="info"></div>
    <div class="stills" ></div>
    <div class="directorP"> </div>
    <div class="directorMovie"></div>
   
</div>






	
</body>
</html>