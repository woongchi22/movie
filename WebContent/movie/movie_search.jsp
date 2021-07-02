<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
String query = request.getParameter("query"); 
String nick = (String)session.getAttribute("nick");



%>

<html>
<head>
<meta charset="UTF-8">
<title>영화 검색</title>
<link href="${pageContext.request.contextPath}/css/default.css" rel="stylesheet" type="text/css">
<script src="${pageContext.request.contextPath}/js/jquery-3.5.1.js"></script>
<script type="text/javascript">
// $(document).ready(function() {
	
// 	// 영화 검색
// 	var query = $('#query').val();
// 	var name = $('#name').val();
// 	query = query.replace(/ /g,'');
	
// 	$.ajax('MovieSearchPro.mo', {
// 		method:"post",
// 		dataType:"json",
// 		data:{query:query},
// 		success: function(data) {
// 			$.each(data.Data, function(idx, item) {
				
// 				var count = item.Count
				
// 				$.each(item.Result, function(idx, item2) {
// 					var title = item2.title
// 					var titleNoSpace = title.replace(/ /g, ''); // 타이틀 공백제거
// 					var title2 = titleNoSpace.replace(/!HS/g,'') // 검색어는 !HS , !HE 로 둘러 싸여있어서 제거해줌
// 	                var title3 = title2.replace(/!HE/g,'')
// 	                var title5 = title3.trim(); // 양쪽끝에 공백을 제거해줌
// 	                var title6 =  encodeURIComponent(title5);
// 	                var actors = "";
	                  
// 	                var image = item2.posters.split("|") // 포스터 데이터는 | 로 구분되어있어서 스플리 처리함 ( 여러개 있음 )
// 	                var nation = item2.nation
					
// 	                if(nation == "대한민국") {
// 	                	for(var num = 0; num <item2.actor.length; num++) {
// 	                		actors = actors + item2.actor[num].actorNm + ", ";
// 	                	}
	                	
// 	                	if(image[0]) {
// 	                		$('#koreaMovie').append('<div class=koreaMovie>' + '<a href=MovieDetailSearch.mo?movieId=' + item2.movieId + '&movieSeq=' + item2.movieSeq + '&query=' + title6 +
// 	                				'&image=' + image[0] + '><div class=poster style="background-image: url(' + image[0] + '),url(${pageContext.request.contextPath}/img/noImage.gif;"></div></a>' + 
// 	                				'<div class=nation>' + item2.nation + '</div>' + 
// 	                				'<div class=ration>' + item2.rating[0].rationGrade + '</div>' +
// 	                				'<div class=title>' + title5 + '</div></div>');
// 	                	}
//                 	} else {
//                 		for(var num = 0; num < item2.actor.length; num++) {
//                 			actors = actors + item2.actor[num].actorNm + ", ";
//                 		}
//                 		if(image[0]) {
//                 			$('#foreignMovie').append('<div class=foreignMovie>' + '<a href=MovieDetailSearch.mo?movieId=' + item2.movieId + '&movieSeq=' + item2.movieSeq + '&query=' + title6 +
//                                     '&image=' + image[0] + '><div class=poster style="background-image: url(' + image[0] + '),url(${pageContext.request.contextPath}/img/noImage.gif;"></div></a>' + 
//                                     '<div class=nation>' + item2.nation + '</div>' + 
//                                     '<div class=ration>' + item2.rating[0].rationGrade + '</div>' +
//                                     '<div class=title>' + title5 + '</div></div>');
//                 		}
//                 	}
					
// 				});
                
// 			});
				
				
// 			$('#koreaMovie').slick({
//                 dots: false,
//                 infinite: false,
//                 arrows: true,
//                 variableWidth:true,
//                 speed: 300,
//                 slidesToShow: 4,
//                 slidesToScroll: 3,
//                 responsive: [{
//                     breakpoint: 1024,
//                     settings: {
//                     	slidesToShow: 3,
//                         slidesToScroll: 3,
//                         infinite: true,
//                         dots: true
//                     }
//                  }, {
//                     breakpoint: 600,
//                     settings: {
//                         slidesToShow: 2,
//                         slidesToScroll: 2
//                     }
//                  }, {
//                     breakpoint: 480,
//                     settings: {
//                         slidesToShow: 1,
//                         slidesToScroll: 1
//                     }
//                  }]
			
//             }); // slick(koreaMovie)끝
            
//             $('#foreignMovie').slick({
//                 dots: false,
//                 infinite: false,
//                 arrows: true,
//                 variableWidth:true,
//                 speed: 300,
//                 slidesToShow: 4,
//                 slidesToScroll: 3,
//                 responsive: [{
//                     breakpoint: 1024,
//                     settings: {
//                         slidesToShow: 3,
//                         slidesToScroll: 3,
//                         infinite: true,
//                         dots: true
//                     }
//                  }, {
//                     breakpoint: 600,
//                     settings: {
//                         slidesToShow: 2,
//                         slidesToScroll: 2
//                     }
//                  }, {
//                     breakpoint: 480,
//                     settings: {
//                         slidesToShow: 1,
//                         slidesToScroll: 1
//                     }
//                  }]
            
//             }); // slick(foreignMovie)끝
            
// 		} // ajax: success 끝
		
// 	}); // ajax 끝
	
	
	
	
// }); // document 끝



$(document).ready(function() {
    
    // 영화 검색
    var query = $('#query').val();
    var name = $('#name').val();
    query = query.replace(/ /g,'');
    
    $.ajax('MovieSearchPro.mo', {
        method:"post",
        dataType:"json",
        data:{query:query},
        success: function(data) {
            $.each(data.Data, function(idx, item) {
                
                var count = item.Count
                
                $.each(item.Result, function(idx, item2) {
                    var title = item2.title
                    var titleNoSpace = title.replace(/ /g, ''); // 타이틀 공백제거
                    var title2 = titleNoSpace.replace(/!HS/g,'') // 검색어는 !HS , !HE 로 둘러 싸여있어서 제거해줌
                    var title3 = title2.replace(/!HE/g,'')
                    var title5 = title3.trim(); // 양쪽끝에 공백을 제거해줌
                    var title6 =  encodeURIComponent(title5);
                    var actors = "";
                      
                    var image = item2.posters.split("|") // 포스터 데이터는 | 로 구분되어있어서 스플리 처리함 ( 여러개 있음 )
                    var nation = item2.nation
                    
                    if(nation == "대한민국") {
                        for(var num = 0; num <item2.actor.length; num++) {
                            actors = actors + item2.actor[num].actorNm + ", ";
                        }
                        
                        if(image[0]) {
                            $('#koreaMovie').append('<div class=koreaMovie>' + '<a href=MovieDetailSearch.mo?movieId=' + item2.movieId + '&movieSeq=' + item2.movieSeq + '&query=' + title6 +
                                    '&image=' + image[0] + '><div class=poster style="background-image: url(' + image[0] + '),url(${pageContext.request.contextPath}/img/noImage.gif;"></div></a>' + 
                                    '<div class=nation>' + item2.nation + '</div>' + 
                                    '<div class=ration>' + item2.rating[0].rationGrade + '</div>' +
                                    '<div class=title>' + title5 + '</div></div>');
                        }
                    } else {
                        for(var num = 0; num < item2.actor.length; num++) {
                            actors = actors + item2.actor[num].actorNm + ", ";
                        }
                        if(image[0]) {
                            $('#foreignMovie').append('<div class=foreignMovie>' + '<a href=MovieDetailSearch.mo?movieId=' + item2.movieId + '&movieSeq=' + item2.movieSeq + '&query=' + title6 +
                                    '&image=' + image[0] + '><div class=poster style="background-image: url(' + image[0] + '),url(${pageContext.request.contextPath}/img/noImage.gif;"></div></a>' + 
                                    '<div class=nation>' + item2.nation + '</div>' + 
                                    '<div class=ration>' + item2.rating[0].rationGrade + '</div>' +
                                    '<div class=title>' + title5 + '</div></div>');
                        }
                    }
                    
                });
                
            });
                
                
            $('#koreaMovie').slick({
                dots: false,
                infinite: false,
                arrows: true,
                variableWidth:true,
                speed: 300,
                slidesToShow: 4,
                slidesToScroll: 3,
                responsive: [{
                    breakpoint: 1024,
                    settings: {
                        slidesToShow: 3,
                        slidesToScroll: 3,
                        infinite: true,
                        dots: true
                    }
                 }, {
                    breakpoint: 600,
                    settings: {
                        slidesToShow: 2,
                        slidesToScroll: 2
                    }
                 }, {
                    breakpoint: 480,
                    settings: {
                        slidesToShow: 1,
                        slidesToScroll: 1
                    }
                 }]
            
            }); // slick(koreaMovie)끝
            
            $('#foreignMovie').slick({
                dots: false,
                infinite: false,
                arrows: true,
                variableWidth:true,
                speed: 300,
                slidesToShow: 4,
                slidesToScroll: 3,
                responsive: [{
                    breakpoint: 1024,
                    settings: {
                        slidesToShow: 3,
                        slidesToScroll: 3,
                        infinite: true,
                        dots: true
                    }
                 }, {
                    breakpoint: 600,
                    settings: {
                        slidesToShow: 2,
                        slidesToScroll: 2
                    }
                 }, {
                    breakpoint: 480,
                    settings: {
                        slidesToShow: 1,
                        slidesToScroll: 1
                    }
                 }]
            
            }); // slick(foreignMovie)끝
            
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
        <input type="hidden" id="query" name="query" value="<%=query%>">
    
    
	    <h2>국내 영화</h2>
	    <section id="koreaMovie"></section>
	    
	    <h2>국외 영화</h2>
	    <section id="foreignMovie"></section>
	    
	    <h2>감독 검색 결과</h2>
	    <section id="directorMovie"></section>
    
    </section>
    



</body>
</html>