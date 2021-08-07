<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<%
String query = request.getParameter("query"); 
String name = (String)session.getAttribute("name");


%>

<link href="${pageContext.request.contextPath}/css/default.css" rel="stylesheet" type="text/css">
<script src="${pageContext.request.contextPath}/js/jquery-3.5.1.js"></script>
<script type="text/javascript" src="//code.jquery.com/jquery-1.11.0.min.js"></script>
<script type="text/javascript" src="//code.jquery.com/jquery-migrate-1.2.1.min.js"></script>
<link rel="stylesheet" type="text/css" href="slick/slick.css"/>
<link rel="stylesheet" type="text/css" href="slick/slick-theme.css"/>   
<script type="text/javascript" src="slick/slick.min.js"></script>


<script type="text/javascript">
$(document).ready(function() {
	console.log("들어왔슈");
	
	var query = $('#query').val();
	var name = $('#name').val();
	console.log(query);
	query = query.replace(/ /g,'');

		

	// 영화 검색(한국, 외국)
	$.ajax('SearchMoviePro.mo', {
		method:"post",
		dataType:"json",
		data:{query:query},
		success: function(data) {
// 			console.log(query);
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
	                				'<div class=title>' + title4 + '</div>'+
	                				'<input type="button" value="담기" id="'+item2.movieSeq+'" ></div>');
	                				
	                	}
	                	
///////////////////////////////////
					  $('#koreaList').on('click', '#' + item2.movieSeq, function() {
                        var movieSeq = item2.movieSeq;
//                         var poster = poster;
                        console.log("들왔당께");
                        $.ajax('CollectionMovieAdd.mp', {
                            data: {
                                name: name,
                                movieSeq: movieSeq,
                                title: title4,
                                poster: poster
                            },
                            success: function(rdata) {
                                var dupCheck = "";
                                if ($("#movies", opener.document).find('.title').length == 0) {
                                	console.log("추가되라 ㅠ");
                                    dupCheck = "Y";
                                    $("#movies", opener.document).append("<div class=collectionList>" +
                                        '<div class=poster style="background-image: url(' + poster + ')"></div>' +
                                        '<div class=title>' + title4+
                                        "</div>" +
                                        "<input type='hidden' value='" + movieSeq + "'name = 'movieSeq' id='movieSeq'>" +
                                        "<input type='hidden' value='" + poster + "'name = 'poster'>" +
                                        "<input type='hidden' value='" + title4+ "'name = 'title'></div>")
                                        	console.log("젭알 ㅠ");

                                        
                                        return false;
                                } else { // #movies가 존재하는 경우
                                    $("#movies", opener.document).find('.title').each(function(idx) {
                                        dupCheck = "";
                                        var title = $("#movies", opener.document).find('.title').eq(idx).text();
                                        if (title != title4) {
                                            dupCheck = "Y";
                                        } else {
                                            dupCheck = "N";
                                            return false;
                                        }

                                    });


                                    if (dupCheck == "Y") {
                                        $("#movies", opener.document).append("<div class=collectionList>" +
                                            '<div class=poster style="background-image: url(' + poster + ')"></div>' +
                                            '<div class=title>' + title4+
                                            "</div>" +
                                            "<input type='hidden' value='" + movieSeq + "'name = 'movieSeq' id='movieSeq'>" +
                                            "<input type='hidden' value='" + poster + "'name = 'poster'>" +
                                            "<input type='hidden' value='" + title4+ "'name = 'title'></div>")
                                    } else { 
                                        alert("이미 추가된 영화입니다.")
                                    }

                                }
                            }
                        });
                    });
	                
	                // 해외 영화 검색	
                	} else {
                		if(poster) {
                			$('#foreignList').append('<div id=foreignMovie><a href=MovieDetailPro.mo?movieSeq=' + item2.movieSeq + '&query=' + title +
                                    '><div class=poster style="background-image: url(' + poster + '),url(${pageContext.request.contextPath}/img/noImage.gif;"></div></a>' + 
                                    '<div class=title>' + title4 + '</div></div>');
                		}
                	} //해외 영화 검색
					
				}); //each
                
			}); //each
	        
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
    <jsp:include page="/inc/collectionTop.jsp"/>
</header>
<body>
	<section>
	        <div class="content">
			    <h2>한국 영화</h2>
			    <div id="koreaList"></div>
	        </div>
	        
	        <div class="content">
	            <h2>외국 영화</h2>
	            <div id="foreignList"></div>
	        </div>
	        
	        <div class="content">
	            <h2>감독</h2>
	            <div id="directorList"></div>
	        </div>
	        
	        <div class="content">
	            <h2>배우</h2>
	            <div id="actorList"></div>
	        </div>
	        
	        <div class="content">
	            <h2>키워드</h2>
	            <div id="keywordList"></div>
	        </div>
	    
    </section>
    
	<input type="hidden" id="query" name="query" value="<%=query %>">
</body>
</html>