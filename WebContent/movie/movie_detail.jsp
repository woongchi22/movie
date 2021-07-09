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
String director = request.getParameter("director");

%>
<title>[WhatFilx] <%=query %></title>
<link href="${pageContext.request.contextPath}/css/default.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath}/css/movie.css" rel="stylesheet" type="text/css">
<script src="${pageContext.request.contextPath}/js/jquery-3.5.1.js"></script>
<script type="text/javascript" src="//code.jquery.com/jquery-1.11.0.min.js"></script>
<script type="text/javascript" src="//code.jquery.com/jquery-migrate-1.2.1.min.js"></script>
<link rel="stylesheet" type="text/css" href="slick/slick.css"/>
<link rel="stylesheet" type="text/css" href="slick/slick-theme.css"/>	
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
					$('.starEvr').append('<dt>평균별점: </dt><div class=runtime>'+rating+'&nbsp;  &middot;&nbsp;'+runtime+'분</div>');
					$('.posters').append('<div class=poster style="background-image:url('+poster[0]+'),url(${pageContext.request.contextPath}/img/noImage.gif);"></div>');
					$('.info').append('<div class=plot style="margin-bottom:7px;">'+plot+'</div><dt>감독</dt><div class=directors>'+directors+'</div><dt>출연</dt><div class=actors>'
							+actors+'</div><dt>개요</dt><div class=summaryInfo>'+genre+' &nbsp;|&nbsp; '+nation+' &nbsp;|&nbsp; '+openDt+'</div><dt>배급</dt><div class=company>'+company+'</div>');
				
				});	// each
				
			}); // each
				
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
		    }); // stile slick
			 
		}
			   	 
	}); 
	
	// 찜꽁
    $.ajax('Dibs.mp', {
        data: {
            movieSeq:movieSeq
        },
        success: function(data) {
            console.log('데이터' + data);
            
            if(data == 'Y') {
                $('.dibsBtn').addClass('done');
                $('.dibsBtnImg').attr("src", "img/check2.png");
                
            } else {
                $('.dibsBtn').removeClass('done');
                $('.dibsBtnImg').attr("src", "img/check.png");
            }
        }
        
    });
    
    
    // 찜꽁 등록,삭제
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
                            async: false,
                            success: function(data) {
                            	
                                if($('.dibsBtn').hasClass('done') == true) {
                                    $('.dibsBtn').removeClass('done')
                                    $('.dibsBtnImg').attr("src", "img/check.png");
                                } else {
                                    $('.dibsBtn').addClass('done');
                                    $('.dibsBtnImg').attr("src", "img/check2.png");
                                }
                                
                            } 
                        
                        }); // ajax - DibsPro
                        
                    }); // dibs 버튼 클릭
                    
                }); //each2
                
            }); // each
            
        } // success
    
    }); // ajax - MovieDetail
    
    //감독 다른 영화
    $.ajax('DirectorSearchPro.mo',{
        method:"post",
        dataType:"json",
        async: false,
        data:{
        	query:directorNm
        },
        success: function(data) {
        	
            $.each(data.Data, function(idx,item) {
                $.each(item.Result, function(idx, item2) {
                    
                    var title = item2.title
                    var titleNoSpace = title.replace(/ /g, '');
                    var title2 = titleNoSpace.replace(/!HS/g, '')
                    var title3 = title2.replace(/!HE/g, '')
                    var title5 = title3.trim();
                    var title6 = encodeURIComponent(title5);
                    var image = item2.posters.split("|");
                    
                    if(image[0]){
                        $('.directorMovie').append('<div class="directorsMovie"><a href=MovieDetailPro.mo?movieSeq='+item2.movieSeq+'&query='+title6+'>'
                                +'<div class=poster style="background-image:url('+image[0]+'),url(${pageContext.request.contextPath}/img/noImage.gif);"></div></a>'+
                        '<div class=title>'+title+'</div></div>');
                    }
                    $('.directorP').text(directorNm + " 감독의 다른 영화들");

                        
                        
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
	
    
    // 별점
    function starClick(grade) {
		$.ajax("GradeStar.mo", {
			method: 'post',
			data: {
				grade:grade,
				name:name,
				movieSeq:movieSeq,
				query:query
			},
			success: function(data) {
				console.log("데이터뭐야" + data);
				
				$('.starRev a').click(function() {
                        $(this).parent().children('a').removeClass('on');
                        $(this).addClass('on').prevAll('a').addClass('on');
                        return false;
                });
				
				switch (data) {
                case "1":
                    $('#showGrade').append('<div class=showG>1점</div>');
                    break;
                    
                case "2":
                    $('#showGrade').append('<div class=showG>2점</div>');
                    break;  
                    
                case "3":
                    $('#showGrade').append('<div class=showG>3점</div>');
                    break;  
                    
                case "4":
                    $('#showGrade').append('<div class=showG>4점</div>');
                    break; 
                    
                case "5":
                    $('#showGrade').append('<div class=showG>5점</div>');
                    break;    

                }
				
			}
		});
	}
	
	// 별점
	var grade = 0;
    $.ajax("MovieDetail.mo", {
        method: "post",
        dataType: "json",
        data: {
            movieSeq:movieSeq,
            query:query,
            grade:grade,
            name:name
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
                    
                    // 별점 클릭 시
                    $('.starRev a').click(function() {
                        $(this).parent().children('a').removeClass('on');
                        $(this).addClass('on').prevAll('a').addClass('on');
                        return false;
                    }); // click
                    
                    
                    $('#star1').click(function() {
                        var grade = 1;
                        starClick(grade);
                    });
                    
                    $('#star2').click(function() {
                        var grade = 2;
                        starClick(grade);
                    });
                    
                    $('#star3').click(function() {
                        var grade = 3;
                        starClick(grade);
                    });
                    
                    $('#star4').click(function() {
                        var grade = 4;
                        starClick(grade);
                    });
                    
                    $('#star5').click(function() {
                        var grade = 5;
                        starClick(grade);
                    });
	                    
                    
                }); //each2
                
            }); // each
            
        } // success
    
    }); // ajax - MovieDetail
		   	 
	
	
	
	
	 
}); // document


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

<div class="review"><a href="BoardReviewList.bo?movieSeq=<%=movieSeq %>&query=<%=query %>" >리뷰</a></div>
<div class="wrap">
	<div class="title_top"></div>
		<%if(pass != null) { %>
		  <div class="starRev">
		       <a class="starR" id="star1"></a>
		       <a class="starR" id="star2"></a>
		       <a class="starR" id="star3"></a>
		       <a class="starR" id="star4"></a>
		       <a class="starR" id="star5"></a>
          </div>
          <div id="showGrade"></div>
        
<!-- 			<div class="review-star"> -->
<!-- 				<div class="review_star"> -->
<!-- 					<input type="button" name="star" id="star1" value="1" class="rev-star" title="1점"> -->
<!-- 					<label for="star1"></label> -->
<!-- 					<input type="button" name="star" id="star2" value="2" class="rev-star" title="2점"> -->
<!-- 					<label for="star2"></label> -->
<!-- 					<input type="button" name="star" id="star3" value="3" class="rev-star" title="3점"> -->
<!-- 					<label for="star3"></label> -->
<!-- 					<input type="button" name="star" id="star4" value="4" class="rev-star" title="4점"> -->
<!-- 					<label for="star4"></label> -->
<!-- 					<input type="button" name="star" id="star5" value="5" class="rev-star" title="5점"> -->
<!-- 					<label for="star5"></label> -->
<!-- 				</div> -->
<!-- 			</div> -->
			
			
		  <div class="dibs"><button class="dibsBtn" value="<%=movieSeq %>"><img class="dibsBtnImg" src="img/check.png" width="20px" height="20px">&nbsp;찜꽁</button></div>
		<%} else {%>   
		  <div class="dibsLogin"><a href="MemberLoginForm.me">로그인</a>하시고 별점을 남겨주세요</div>
		<%} %>
	
		<div class="starEvr"></div>
		<div class="posters" ></div>
		<div class="info"></div>
	    <div class="stills" ></div>
	    <div class="directorP"> </div>
	    <div class="directorMovie"></div>
   
</div>






	
</body>
</html>