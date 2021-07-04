<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
String query = request.getParameter("query"); 
String name = (String)session.getAttribute("name");


%>

<html>
<head>
<meta charset="UTF-8">
<title>[<%=query %>] 검색 결과</title>
<link rel="stylesheet" type="text/css" href="slick/slick.css"/>
<link rel="stylesheet" type="text/css" href="slick/slick-theme.css"/>
<link href="${pageContext.request.contextPath}/css/default.css" rel="stylesheet" type="text/css">
<script src="${pageContext.request.contextPath}/js/jquery-3.5.1.js"></script>
<script type="text/javascript" src="//code.jquery.com/jquery-1.11.0.min.js"></script>
<script type="text/javascript" src="//code.jquery.com/jquery-migrate-1.2.1.min.js"></script>
<script type="text/javascript" src="slick/slick.min.js"></script>
<script type="text/javascript">
$(document).ready(function() {
	
	var query = $('#query').val();
	var name = $('#name').val();
	query = query.replace(/ /g,'');
	
	// 영화 검색(한국, 외국)
	$.ajax('MovieSearchPro.mo', {
		method:"post",
		dataType:"json",
		data:{query:query},
		success: function(data) {
			console.log(query);
			// 배열 4개
			$.each(data.Data, function(idx, item) {
				
				var count = item.Count; // 10
				
				$.each(item.Result, function(idx, item2) {
					
					var title1 = item2.title
					var titleNoSpace = title1.replace(/ /g, ''); // 타이틀 공백제거
					var title2 = titleNoSpace.replace(/!HS/g,'') // 검색어는 !HS , !HE 로 둘러 싸여있어서 제거해줌
	                var title3 = title2.replace(/!HE/g,'')
	                var title4 = title3.trim(); // 양쪽끝에 공백을 제거해줌
	                var title = encodeURIComponent(title4);
	                
// 	                var actor = item2.actors.actor;
// 	                console.log(actor);
	                
	                var actors = "";
	                  
	                var image = item2.posters.split("|"); // 포스터 데이터는 '|' 로 구분되어있어서 스플릿 처리함 ( 여러개 있음 )
	                var nation = item2.nation
	                
	                var rating = item2.ratings.rating[0].ratingGrade;
// 	                console.log(rating)
// 					console.log(image[0]);
					
	                if(nation == "대한민국") {
	                	
	                	// 한국 영화 검색
	                	for(var num = 0; num < item2.actors.actor.length; num++) {
	                		actors = actors + item2.actors.actor[num].actorNm + ", ";
	                	}
	                	
	                	if(image[0]) {
	                		$('#koreaList').append('<div id=koreaMovie><a href=MovieDetailSearch.mo?movieId=' + item2.movieId + '&movieSeq=' + item2.movieSeq + '&query=' + title +
	                				'&image=' + image[0] + '><div class=poster style="background-image: url(' + image[0] + '), url(${pageContext.request.contextPath}/img/noImage.gif;"></div></a>' + 
	                				'<div id=title>' + title4 + '</div></div>');
	                	}
	                	
                	} else {
                		
                		// 해외 영화 검색
                		for(var num = 0; num < item2.actors.actor.length; num++) {
                			actors = actors + item2.actors.actor[num].actorNm + ", ";
                		}
                		
                		if(image[0]) {
                			$('#foreignList').append('<div id=foreignMovie><a href=MovieDetailSearch.mo?movieId=' + item2.movieId + '&movieSeq=' + item2.movieSeq + '&query=' + title +
                                    '&image=' + image[0] + '><div class=poster style="background-image: url(' + image[0] + '),url(${pageContext.request.contextPath}/img/noImage.gif;"></div></a>' + 
                                    '<div id=title>' + title4 + '</div></div>');
                		}
                	}
					
				});
                
			});
	        
		    $('#koreaList').slick({
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
            }); // koreaList - slilck 끝 
            
            $('#foreignList').slick({
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
             }); // foreignList - slilck 끝 
	                		
		} // ajax: success 끝
		
	}); // ajax 끝
	
	
	// 감독 검색
	$.ajax('DirectorSearchPro.mo', {
        method:"post",
        dataType:"json",
        data:{query:query},
        success: function(data) {
            console.log(query);
            
            $.each(data.Data, function(idx, item) {
                
                $.each(item.Result, function(idx, item2) {
                    
                    var title1 = item2.title
                    var titleNoSpace = title1.replace(/ /g, ''); // 타이틀 공백제거
                    var title2 = titleNoSpace.replace(/!HS/g,'') // 검색어는 !HS , !HE 로 둘러 싸여있어서 제거해줌
                    var title3 = title2.replace(/!HE/g,'')
                    var title4 = title3.trim(); // 양쪽끝에 공백을 제거해줌
                    var title = encodeURIComponent(title4);
                    
                    var actors = "";
                    var image = item2.posters.split("|"); // 포스터 데이터는 '|' 로 구분되어있어서 스플릿 처리함 ( 여러개 있음 )
                    
                    for(var num = 0; num < item2.actors.actor.length; num++) {
                        actors = actors + item2.actors.actor[num].actorNm + ", ";
                    }
                    
                    if(image[0]) {
                        $('#directorList').append('<div id=directorMovie><a href=MovieDetailSearch.mo?movieId=' + item2.movieId + '&movieSeq=' + item2.movieSeq + '&query=' + title +
                                '&image=' + image[0] + '><div class=poster style="background-image: url(' + image[0] + '), url(${pageContext.request.contextPath}/img/noImage.gif;"></div></a>' + 
                                '<div id=title>' + title4 + '</div></div>');
                    }
                        
                });
                
            });
                
            $('#directorList').slick({
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
             }); // directorList - slilck 끝     
                
        } // ajax: success 끝
        
    }); // ajax 끝
    
    
     // 배우 검색
    $.ajax('ActorSearchPro.mo', {
        method:"post",
        dataType:"json",
        data:{query:query},
        success: function(data) {
            console.log(query);
            
            $.each(data.Data, function(idx, item) {
                
                $.each(item.Result, function(idx, item2) {
                    
                    var title1 = item2.title
                    var titleNoSpace = title1.replace(/ /g, ''); // 타이틀 공백제거
                    var title2 = titleNoSpace.replace(/!HS/g,'') // 검색어는 !HS , !HE 로 둘러 싸여있어서 제거해줌
                    var title3 = title2.replace(/!HE/g,'')
                    var title4 = title3.trim(); // 양쪽끝에 공백을 제거해줌
                    var title = encodeURIComponent(title4);
                    
                    var actors = "";
                    var image = item2.posters.split("|"); // 포스터 데이터는 '|' 로 구분되어있어서 스플릿 처리함 ( 여러개 있음 )
                    
                    for(var num = 0; num < item2.actors.actor.length; num++) {
                        actors = actors + item2.actors.actor[num].actorNm + ", ";
                    }
                    
                    if(image[0]) {
                        $('#actorList').append('<div id=actorMovie><a href=MovieDetailSearch.mo?movieId=' + item2.movieId + '&movieSeq=' + item2.movieSeq + '&query=' + title +
                                '&image=' + image[0] + '><div class=poster style="background-image: url(' + image[0] + '), url(${pageContext.request.contextPath}/img/noImage.gif;"></div></a>' + 
                                '<div id=title>' + title4 + '</div></div>');
                    }
                        
                });
                
            });
                
            $('#actorList').slick({
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
             }); // actorList - slilck 끝     
                
        } // ajax: success 끝
        
    }); // ajax 끝
    
    
    // 키워드 검색
    $.ajax('KeywordSearchPro.mo', {
        method:"post",
        dataType:"json",
        data:{query:query},
        success: function(data) {
            console.log(query);
            
            $.each(data.Data, function(idx, item) {
                
                $.each(item.Result, function(idx, item2) {
                    
                    var title1 = item2.title
                    var titleNoSpace = title1.replace(/ /g, ''); // 타이틀 공백제거
                    var title2 = titleNoSpace.replace(/!HS/g,'') // 검색어는 !HS , !HE 로 둘러 싸여있어서 제거해줌
                    var title3 = title2.replace(/!HE/g,'')
                    var title4 = title3.trim(); // 양쪽끝에 공백을 제거해줌
                    var title = encodeURIComponent(title4);
                    
                    var actors = "";
                    var image = item2.posters.split("|"); // 포스터 데이터는 '|' 로 구분되어있어서 스플릿 처리함 ( 여러개 있음 )
                    
                    for(var num = 0; num < item2.actors.actor.length; num++) {
                        actors = actors + item2.actors.actor[num].actorNm + ", ";
                    }
                    
                    if(image[0]) {
                        $('#keywordList').append('<div id=keywordMovie><a href=MovieDetailSearch.mo?movieId=' + item2.movieId + '&movieSeq=' + item2.movieSeq + '&query=' + title +
                                '&image=' + image[0] + '><div class=poster style="background-image: url(' + image[0] + '), url(${pageContext.request.contextPath}/img/noImage.gif;"></div></a>' + 
                                '<div id=title>' + title4 + '</div></div>');
                    }
                        
                });
                
            });
                
            $('#keywordList').slick({
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
             }); // keywordList - slilck 끝     
                
        } // ajax: success 끝
        
    }); // ajax 끝
	
}); // document 끝





</script>
</head>
<header>
    <jsp:include page="/inc/top.jsp"/>
</header>

<body>
    <section>
        <input type="hidden" id="query" name="query" value="<%=query %>">
        
	    <h2>한국 영화</h2>
	    <section id="koreaList"></section>
	    
	    <h2>외국 영화</h2>
	    <section id="foreignList"></section>
	    
	    <h2>감독</h2>
	    <section id="directorList"></section>
	    
	    <h2>배우</h2>
        <section id="actorList"></section>
    
        <h2>키워드</h2>
        <section id="keywordList"></section>
        
    </section>
    



</body>
</html>