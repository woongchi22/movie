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
<link href="${pageContext.request.contextPath}/css/default.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath}/css/movie.css" rel="stylesheet" type="text/css">
<script src="${pageContext.request.contextPath}/js/jquery-3.5.1.js"></script>
<script type="text/javascript">
$(document).ready(function() {
	
	var query = $('#query').val();
	var name = $('#name').val();
	query = query.replace(/ /g,'');
	
	// 영화 검색(한국, 외국)
	$.ajax('SearchMoviePro.mo', {
		method:"post",
		dataType:"json",
		data:{query:query},
		success: function(data) {

			// 배열 4개
			$.each(data.Data, function(idx, item) {
				
				var count = item.Count; // 10
				
				$.each(item.Result, function(idx, item2) {
					
					var title1 = item2.title
					var titleNoSpace = title1.replace(/ /g, ''); // 타이틀 공백제거
					var title2 = titleNoSpace.replace(/!HS/g,''); // 검색어는 !HS , !HE 로 둘러 싸여있어서 제거해줌
	                var title3 = title2.replace(/!HE/g,'')
	                var title4 = title3.trim(); // 양쪽끝에 공백을 제거해줌
	                var title = encodeURIComponent(title4);
	                
	                var nation = item2.nation
	                var posters = item2.posters.split("|"); // 포스터 데이터는 '|' 로 구분되어있어서 스플릿 처리함 ( 여러개 있음 )
	                
	                var poster = posters[0]
// 	                console.log(poster);
					
	                // 한국 영화 검색
	                if(nation == "대한민국") {
	                	
	                	if(poster) {
	                		$('#koreaList').append('<div id=koreaMovie><a href=MovieDetailPro.mo?movieSeq=' + item2.movieSeq + '&query=' + title +
	                				'><div class=poster style="background-image: url(' + poster + '), url(${pageContext.request.contextPath}/img/noImage.gif;"></div></a>' + 
	                				'<div class=title>' + title4 + '</div><input type="button" value="담기"></div>');
	                				
	                	}
	                
	                // 해외 영화 검색	
                	} else {
                		if(poster) {
                			$('#foreignList').append('<div id=foreignMovie><a href=MovieDetailPro.mo?movieSeq=' + item2.movieSeq + '&query=' + title +
                                    '><div class=poster style="background-image: url(' + poster + '),url(${pageContext.request.contextPath}/img/noImage.gif;"></div></a>' + 
                                    '<div class=title>' + title4 + '</div></div>');
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
	
	
// 	// 감독 검색
// 	$.ajax('DirectorSearchPro.mo', {
//         method:"post",
//         dataType:"json",
//         data:{query:query},
//         success: function(data) {
//             console.log(query);
            
//             $.each(data.Data, function(idx, item) {
                
//                 $.each(item.Result, function(idx, item2) {
                    
//                     var title1 = item2.title
//                     var titleNoSpace = title1.replace(/ /g, ''); // 타이틀 공백제거
//                     var title2 = titleNoSpace.replace(/!HS/g,'') // 검색어는 !HS , !HE 로 둘러 싸여있어서 제거해줌
//                     var title3 = title2.replace(/!HE/g,'')
//                     var title4 = title3.trim(); // 양쪽끝에 공백을 제거해줌
//                     var title = encodeURIComponent(title4);
                    
//                     var poster = item2.posters.split("|"); // 포스터 데이터는 '|' 로 구분되어있어서 스플릿 처리함 ( 여러개 있음 )
                    
//                     if(poster[0]) {
//                     	$('#directorList').append('<div id=directorMovie><a href=MovieDetailPro.mo?movieSeq=' + item2.movieSeq + '&query=' + title +
//                                 '><div class=poster style="background-image: url(' + poster[0] + '), url(${pageContext.request.contextPath}/img/noImage.gif;"></div></a>' + 
//                                 '<div class=title>' + title4 + '</div></div>');
//                     }
                        
//                 });
                
//             });
                
//             $('#directorList').slick({
//                 dots: false,
//                 infinite: false,
//                 arrows: true,
//                 variableWidth:true,
//                 speed: 300,
//                 slidesToShow: 4,
//                 slidesToScroll: 3,
//                 responsive: [
//                   {
//                     breakpoint: 1024,
//                     settings: {
//                       slidesToShow: 3,
//                       slidesToScroll: 3,
//                       infinite: false,
//                       dots: false
//                     }
//                   },
//                   {
//                     breakpoint: 600,
//                     settings: {
//                       slidesToShow: 2,
//                       slidesToScroll: 2
//                     }
//                   },
//                   {
//                     breakpoint: 480,
//                     settings: {
//                       slidesToShow: 1,
//                       slidesToScroll: 1
//                     }
//                   }
//                 ]
//              }); // directorList - slilck 끝     
                
//         } // ajax: success 끝
        
//     }); // ajax 끝
    
    
//      // 배우 검색
//     $.ajax('ActorSearchPro.mo', {
//         method:"post",
//         dataType:"json",
//         data:{query:query},
//         success: function(data) {
//             console.log(query);
            
//             $.each(data.Data, function(idx, item) {
                
//                 $.each(item.Result, function(idx, item2) {
                    
//                     var title1 = item2.title
//                     var titleNoSpace = title1.replace(/ /g, ''); // 타이틀 공백제거
//                     var title2 = titleNoSpace.replace(/!HS/g,'') // 검색어는 !HS , !HE 로 둘러 싸여있어서 제거해줌
//                     var title3 = title2.replace(/!HE/g,'')
//                     var title4 = title3.trim(); // 양쪽끝에 공백을 제거해줌
//                     var title = encodeURIComponent(title4);
                    
//                     var poster = item2.posters.split("|"); // 포스터 데이터는 '|' 로 구분되어있어서 스플릿 처리함 ( 여러개 있음 )
                    
//                     if(poster[0]) {
//                         $('#actorList').append('<div id=actorMovie><a href=MovieDetailPro.mo?movieSeq=' + item2.movieSeq + '&query=' + title +
//                                 '><div class=poster style="background-image: url(' + poster[0] + '), url(${pageContext.request.contextPath}/img/noImage.gif;"></div></a>' + 
//                                 '<div class=title>' + title4 + '</div></div>');
//                     }
                        
//                 });
                
//             });
                
//             $('#actorList').slick({
//                 dots: false,
//                 infinite: false,
//                 arrows: true,
//                 variableWidth:true,
//                 speed: 300,
//                 slidesToShow: 4,
//                 slidesToScroll: 3,
//                 responsive: [
//                   {
//                     breakpoint: 1024,
//                     settings: {
//                       slidesToShow: 3,
//                       slidesToScroll: 3,
//                       infinite: false,
//                       dots: false
//                     }
//                   },
//                   {
//                     breakpoint: 600,
//                     settings: {
//                       slidesToShow: 2,
//                       slidesToScroll: 2
//                     }
//                   },
//                   {
//                     breakpoint: 480,
//                     settings: {
//                       slidesToShow: 1,
//                       slidesToScroll: 1
//                     }
//                   }
//                 ]
//              }); // actorList - slilck 끝     
                
//         } // ajax: success 끝
        
//     }); // ajax 끝
    
    
//     // 키워드 검색
//     $.ajax('KeywordSearchPro.mo', {
//         method:"post",
//         dataType:"json",
//         data:{query:query},
//         success: function(data) {
//             console.log(query);
            
//             $.each(data.Data, function(idx, item) {
                
//                 $.each(item.Result, function(idx, item2) {
                    
//                     var title1 = item2.title
//                     var titleNoSpace = title1.replace(/ /g, ''); // 타이틀 공백제거
//                     var title2 = titleNoSpace.replace(/!HS/g,'') // 검색어는 !HS , !HE 로 둘러 싸여있어서 제거해줌
//                     var title3 = title2.replace(/!HE/g,'')
//                     var title4 = title3.trim(); // 양쪽끝에 공백을 제거해줌
//                     var title = encodeURIComponent(title4);
                    
//                     var poster = item2.posters.split("|"); // 포스터 데이터는 '|' 로 구분되어있어서 스플릿 처리함 ( 여러개 있음 )
                    
//                     if(poster[0]) {
//                         $('#keywordList').append('<div id=keywordMovie><a href=MovieDetailPro.mo?movieSeq=' + item2.movieSeq + '&query=' + title +
//                                 '><div class=poster style="background-image: url(' + poster[0] + '), url(${pageContext.request.contextPath}/img/noImage.gif;"></div></a>' + 
//                                 '<div class=title>' + title4 + '</div></div>');
//                     }
                        
//                 });
                
//             });
                
//             $('#keywordList').slick({
//                 dots: false,
//                 infinite: false,
//                 arrows: true,
//                 variableWidth:true,
//                 speed: 300,
//                 slidesToShow: 4,
//                 slidesToScroll: 3,
//                 responsive: [
//                   {
//                     breakpoint: 1024,
//                     settings: {
//                       slidesToShow: 3,
//                       slidesToScroll: 3,
//                       infinite: false,
//                       dots: false
//                     }
//                   },
//                   {
//                     breakpoint: 600,
//                     settings: {
//                       slidesToShow: 2,
//                       slidesToScroll: 2
//                     }
//                   },
//                   {
//                     breakpoint: 480,
//                     settings: {
//                       slidesToShow: 1,
//                       slidesToScroll: 1
//                     }
//                   }
//                 ]
//              }); // keywordList - slilck 끝     
                
//         } // ajax: success 끝
        
//     }); // ajax 끝
	
}); // document 끝





</script>
<title>My Collection</title>
</head>
<header>
    <jsp:include page="/inc/top.jsp"/>
</header>
<body>
<input type ="button" value="담기">
        <input type="hidden" id="query" name="query" value="<%=query %>">


</body>
</html>