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
<link href="${pageContext.request.contextPath}/css/default.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath}/css/slick.css" rel="stylesheet" type="text/css">
<%-- <link href="${pageContext.request.contextPath}/css/slick-theme.css" rel="stylesheet" type="text/css"> --%>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/slick-carousel/1.8.1/slick-theme.css">
<!-- <script src="https://cdnjs.cloudflare.com/ajax/libs/slick-carousel/1.8.1/slick.min.js"></script> -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/slick-carousel/1.9.0/slick.min.js"></script>
<script src="${pageContext.request.contextPath}/js/jquery-3.5.1.js"></script>
<script type="text/javascript">
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
				  dots: true,
				  infinite: false,
				  speed: 300,
				  slidesToShow: 4,
				  slidesToScroll: 4,
				  responsive: [
				    {
				      breakpoint: 1024,
				      settings: {
				        slidesToShow: 3,
				        slidesToScroll: 3,
				        infinite: true,
				        dots: true
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
				    // You can unslick at a given breakpoint now by adding:
				    // settings: "unslick"
				    // instead of a settings object
				  ]
				});
	                		
	                		
            
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
	    
	    <h2>해외 영화</h2>
	    <section id="foreignList"></section>
	    
	    <h2>감독 검색 결과</h2>
	    <section id="directorList"></section>
    
    </section>
    



</body>
</html>