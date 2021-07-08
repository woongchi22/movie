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
			 }); //slick
			 
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
	
	
// 	//별점
// 	function starClick(param,grade,image) {
// 		$.ajax("SetGrade.mo", {
// 			method:"post",
// 			async: false,
// 			dataType:{
// 				data:param,
// 				name:name,
// 				grade:grade,
// 				image:image
// 			},
// 			success: function(data) {
// 				console.log(data);
// 				location.reload();
				
// 			} //star success
// 		}); //ajax
// 	}
			   	 
// 	if (name != 'null') {
//          $.ajax("MovieDetail.mo", {
//              method: "get",
//              dataType: "json",
//              async: false,
//              data: {
//                  movieSeq: movieSeq,
//                  query: query
//              },
//              success: function(data) {
//             	 console.log("성공");

//             	 console.log(data);
//                  var grade = 0;
//                  $.each(data.Data, function(idx, item) {
//                      var i = 1;
//                      var l = 1;

//                      $.each(item.Result, function(idx, item2) {

//                          var num = 0;
//                          var image = item2.posters.split("|");
//                          var title = item2.title;
//                          var titleNoSpace = title.replace(/ /g, '');
//                          var title2 = titleNoSpace.replace(/!HS/g, '');
//                          var title3 = title2.replace(/!HE/g, '');
//                          var title5 = title3.trim();

//                          // 10개의 라벨에 각기 다른 값을 부여하기위한 반복문
//                          for (var o = 1; o < 11; o++) {
//                              $('.rev-star' + o).eq(idx).attr("id", "p" + i++);
//                          }
//                          // 10개의 라벨에 각기 다른 값을 부여하기위한 반복문
//                          for (var o = 1; o < 11; o++) {
//                              $('.star' + o).eq(idx).attr("for", "p" + l++);
//                          }

//                          var getGrade = $('#getGrade').val();
                         
//                          switch (getGrade) {

//                              case "0.5":
//                                      $('.star1').focus();
//                                      $('#isGrade').show();
//                                      break;
//                                  case "1":
//                                      $('.star2').focus();
//                                      $('#isGrade').show();
//                                      break;
//                                  case "1.5":
//                                      $('.star3').focus();
//                                      $('#isGrade').show();
//                                      break;
//                                  case "2":
//                                      $('.star4').focus();
//                                      $('#isGrade').show();
//                                      break;
//                                  case "2.5":
//                                      $('.star5').focus();
//                                      $('#isGrade').show();
//                                      break;
//                                  case "3":
//                                      $('.star6').focus();
//                                      $('#isGrade').show();
//                                      break;
//                                  case "3.5":
//                                      $('.star7').focus();
//                                      $('#isGrade').show();
//                                      break;
//                                  case "4":
//                                      $('.star8').focus();
//                                      $('#isGrade').show();
//                                      break;
//                                  case "4.5":
//                                      $('.star9').focus();
//                                      $('#isGrade').show();
//                                      break;
//                                  case "5":
//                                      $('.star10').focus();
//                                      $('#isGrade').show();
//                                      break;
//                          } // switch문

// //                          var nation = item2.nation.split(",");
//                          $('.rev-star1').eq(idx).val(item2.director[0].directorNm + "/" + title5 + "/" + item2.movieSeq + "/" + item2.runtime + "/" + item2.genre + "/" + item2.prodYear);
//                              var image = image[0];
//                              var garde = 0;
//                              var movieSeq = ""
//                              $('.rev-star1').eq(idx).click(function() {
//                                  var grade = 1;
//                                  var data = $('.rev-star1').eq(idx).val();
//                                  starClick(data, grade, image);

//                              });

//                              $('.rev-star2').eq(idx).click(function() {
//                                  var grade = 2;
//                                  var data = $('.rev-star1').eq(idx).val();
//                                  starClick(data, grade, image);

//                              });
//                              $('.rev-star3').eq(idx).click(function() {
//                                  var grade = 3;
//                                  var data = $('.rev-star1').eq(idx).val();
//                                  starClick(data, grade, image);

//                              });

//                              $('.rev-star4').eq(idx).click(function() {
//                                  var grade = 4;
//                                  var data = $('.rev-star1').eq(idx).val();
//                                  starClick(data, grade, image);
//                              });

//                              $('.rev-star5').eq(idx).click(function() {
//                                  var grade = 5;
//                                  var data = $('.rev-star1').eq(idx).val();
//                                  starClick(data, grade, image);
//                              });

//                              $('.rev-star6').eq(idx).click(function() {
//                                  var grade = 6;
//                                  var data = $('.rev-star1').eq(idx).val();
//                                  starClick(data, grade, image);

//                              });
                             
//                              $('.rev-star7').eq(idx).click(function() {
//                                  var grade = 7;
//                                  var data = $('.rev-star1').eq(idx).val();
//                                  starClick(data, grade, image);
//                              });
                             
//                              $('.rev-star8').eq(idx).click(function() {
//                                  var grade = 8;
//                                  var data = $('.rev-star1').eq(idx).val();
//                                  starClick(data, grade, image);
//                              });
                             
//                              $('.rev-star9').eq(idx).click(function() {
//                                  var grade = 9;
//                                  var data = $('.rev-star1').eq(idx).val();
//                                  starClick(data, grade, image);
//                              });
                             
//                              $('.rev-star10').eq(idx).click(function() {
//                                  var grade = 10;
//                                  var data = $('.rev-star1').eq(idx).val();
//                                  starClick(data, grade, image);

//                          });

//                      }); //each문 끝남
//                  }); // each문 
//              } // success
//          }); // ajax
         
//     } else {
//         $('.star1').click(function() {
//             selectBtn();
//         });

//         $('.star2').click(function() {
//             selectBtn();
//         });

//         $('.star3').click(function() {
//             selectBtn();
//         });

//         $('.star4').click(function() {
//             selectBtn();
//         });

//         $('.star5').click(function() {
//             selectBtn();
//         });

//         $('.star6').click(function() {
//             selectBtn();
//         });

//         $('.star7').click(function() {
//             selectBtn();
//         });

//         $('.star8').click(function() {
//             selectBtn();
//         });

//         $('.star9').click(function() {
//             selectBtn();
//         });

//         $('.star10').click(function() {
//             selectBtn();
//         });
        
//     } // else
		   	 
	

	

	
	
	
	
	
	
	 
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

<div class="review"><a href="BoardReview.bo?movieSeq=<%=movieSeq %>&query=<%=query %>" >리뷰</a></div>
<div class="wrap">
	<div class="title_top"></div>
		<%if(pass != null) { %>
			<div class="review-star">
			<div class="review_star">
				<input type="button" name="star" id="star1" value="1" class="rev-star" title="1점">
				<label for="star1"></label>
				<input type="button" name="star" id="star2" value="2" class="rev-star" title="2점">
				<label for="star2"></label>
				<input type="button" name="star" id="star3" value="3" class="rev-star" title="3점">
				<label for="star3"></label>
				<input type="button" name="star" id="star4" value="4" class="rev-star" title="4점">
				<label for="star4"></label>
				<input type="button" name="star" id="star5" value="5" class="rev-star" title="5점">
				<label for="star5"></label>
			
			
			
			
			</div>
			</div>
			
		    <div class="dibs"><button class="dibsBtn" value="<%=movieSeq %>"><img class="dibsBtnImg" src="img/check.png" width="20px" height="20px">&nbsp;찜꽁</button></div>
		<%} else {%>   
		      <div class="dibsLogin"><a href="MemberLoginForm.me">로그인</a>하시고 별점을 남겨주세요</div>
		<%} %>
			
	<div class="star"></div>
	<div class="posters" ></div>
	<div class="info"></div>
    <div class="stills" ></div>
    <div class="directorP"> </div>
    <div class="directorMovie"></div>
   
</div>






	
</body>
</html>