<%@page import="board.vo.PageInfo"%>
<%@page import="board.vo.ReviewBean"%>
<%@page import="java.util.ArrayList"%>
<%@page import="movie.vo.MovieBean"%>
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
String review = (String)request.getAttribute("review");
String grade = (String)request.getAttribute("grade");
ArrayList<ReviewBean> reviewList = (ArrayList<ReviewBean>) request.getAttribute("reviewList");

%>
<title>[WhatFilx] <%=query %></title>
<link href="${pageContext.request.contextPath}/css/default.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath}/css/movie.css" rel="stylesheet" type="text/css">
<script src="${pageContext.request.contextPath}/js/jquery-3.5.1.js"></script>
<script src="//code.jquery.com/jquery-1.11.1.min.js"></script>

<%-- slick --%>
<!-- <script type="text/javascript" src="//code.jquery.com/jquery-1.11.0.min.js"></script> -->
<!-- <script type="text/javascript" src="//code.jquery.com/jquery-migrate-1.2.1.min.js"></script> -->
<link rel="stylesheet" type="text/css" href="slick/slick.css"/>
<link rel="stylesheet" type="text/css" href="slick/slick-theme.css"/>	
<script type="text/javascript" src="slick/slick.min.js"></script>

<%-- modal --%>
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script src="${pageContext.request.contextPath}/js/jquery-ui.js"></script>
  
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
// 	                var openDt = item2.ratings.rating[0].ratingDate.substr(0,4);
	                var openDt = item2.prodYear;
	                var company = item2.company;
					var poster = item2.posters.split("|");
					var stills = item2.stlls.split("|");
					
					
					for(var num=0; num < item2.actors.actor.length; num++){
						actor = actor + item2.actors.actor[num].actorNm+ ", ";
					}
					for(var num=0; num < item2.directors.director.length; num++){
						director = director + item2.directors.director[num].directorNm+ ", ";
					}
					
					for(var i in stills){
						
						if (stills[i]) {
		                     $('.stills').append('<div class=stillCut style="background-image: url(' + stills[i] + ');"></div>')
		                 } 
					}
					
					var actors = actor.replace(/,\s*$/, '');
					var directors = director.replace(/,\s*$/, '');
					directorNm=directors.replace(/ /g, '');
					
					avgStar(); // 평균별점 함수
					
					$('.title_top').append('<div class=title_top>'+title4+'</div>');
					$('.starAvg').append('<div id=avgGrade></div><div class=runtime>'+rating+'&nbsp; &middot; &nbsp;'+runtime+'분</div>');
					$('.posters').append('<div class=poster style="background-image:url('+poster[0]+'),url(${pageContext.request.contextPath}/img/noImage.gif);"></div>');
					$('.info').append('<div class=plot>'+plot+'</div><dt>감독</dt><div class=directors>'+directors+'</div><dt>출연</dt><div class=actors>'
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
            console.log('데이터 y/n' + data);
            
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
            	
            	if(item.TotalCount == 0) {
            		$('.directorP').text(directorNm + "감독의 다른 영화를 찾을 수 없습니다");
            		return false;
            	} 
            	
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

    
    // 평균 별점 함수
    function avgStar() {
    	$.ajax("AverageStar.mo", {
            data: {
                movieSeq:movieSeq,
                grade:grade
            },
            success: function(data) {
            	
            	if(typeof(Storage) != null) {
                    localStorage.setItem("avgStar", "평균 별점 &nbsp;" + data + "&nbsp;");
                    document.getElementById("avgGrade").innerHTML = localStorage.getItem("avgStar");
                }
            }
            
        });
    	
	}
   
    // 별점 클릭 시 함수(등록, 수정)
    function starClick(grade, nation, director, genre, runtime, poster) {
		$.ajax("GradeStar.mo", {
			method: 'post',
			data: {
				grade:grade,
				name:name,
				movieSeq:movieSeq,
				query:query,
				nation:nation,
				director:director,
				genre:genre,
				runtime:runtime,
				poster:poster
			},
			success: function(data) {
				
				avgStar(); // 평균 별점 함수
				
				if(typeof(Storage) != 0) {
			        localStorage.setItem("getStar", data+"점");
			        document.getElementById("showGrade").innerHTML = localStorage.getItem("getStar");
			        
			        if($('#cancelStar').css("display") == "none") {
			        	jQuery('#cancelStar').show(); 
			        } 
			        
			        if($('#comment').css("display") == "none") {
			        	jQuery('#comment').show(); 
			        } 
			        
			        
			    } else {
			        document.getElementById("showGrade").innerHTML = "별점을 남겨주세요";
			    }
				
			}
		});
	}
	
	// 별점
	var grade = $('#grade').val();
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
                	
                	var nation = item2.nation
                	var director = item2.directors.director[0].directorNm
                	var genre = item2.genre
                	var runtime = item2.runtime
                	var image = item2.posters.split("|");
                	var poster = image[0]

                    // 별점 클릭하면 별 채워짐
                    $('.starRev a').click(function() {
                        $(this).parent().children('a').removeClass('on');
                        $(this).addClass('on').prevAll('a').addClass('on');
                        return false;
                    });
                    
                    
                    $('#star1').click(function() {
                        var grade = 1;
                        starClick(grade, nation, director, genre, runtime, poster);
                    });
                    
                    $('#star2').click(function() {
                        var grade = 2; 
                        starClick(grade, nation, director, genre, runtime, poster);
                    });
                    
                    $('#star3').click(function() {
                        var grade = 3;
                        starClick(grade, nation, director, genre, runtime, poster);
                    });
                    
                    $('#star4').click(function() {
                        var grade = 4;
                        starClick(grade, nation, director, genre, runtime, poster);
                    });
                    
                    $('#star5').click(function() {
                        var grade = 5;
                        starClick(grade, nation, director, genre, runtime, poster);
                    });
                    
                }); //each2
                
            }); // each
            
        } // success
        
    }); // ajax - MovieDetail
    
    // 별점 삭제
    function dialogStar() {
        
        $('#diStar').dialog({
            title: "별점",
            modal: true,
            buttons: {
                "확인": function() {
                    $.ajax('DeleteStar.mo', {
                        data: {
                            name:name,
                            query:query,
                            movieSeq:movieSeq
                        },
                        success: function(data) {
                        	avgStar(); // 평균 별점 함수
                            $('#star5').removeClass('on').prevAll('a').removeClass('on');
                            $('#showGrade').html('별점을 남겨주세요');
                            $('#cancelStar').css("display", "none");
                            $('#comment').css("display", "none");
                            $('#commentBtn').css("display", "");
                            $('#commentBox').css("display", "none");
                        }
                    });
                    
                    $(this).dialog('close');
                },
                "취소": function() {
                    $(this).dialog('close');
                }
            }
        });
        
    }
    
    // 별점 취소 클릭
    $('#cancelBtn').on("click", function() {
        dialogStar();
    });
    
    // 별점 조회
    $.ajax('Star.mo', {
        data: {
            movieSeq:movieSeq,
            grade:grade
        },
        success: function(data) {
            console.log('데이터' + data);
            if(data == 0){
                $('#showGrade').html('별점을 남겨주세요');
            }
            if(data == 1){
            	$('#star1').addClass('on').prevAll('a').addClass('on');
                $('#showGrade').html(data + "점");
                $('#cancelStar').css("display", "");
                $('#comment').css("display", "");
            }
            if(data == 2){
            	$('#star2').addClass('on').prevAll('a').addClass('on');
            	$('#showGrade').html(data + "점");
                $('#cancelStar').css("display", "");
                $('#comment').css("display", "");
            }   
            if(data == 3){
                $('#star3').addClass('on').prevAll('a').addClass('on');
                $('#showGrade').html(data + "점");
                $('#cancelStar').css("display", "");
                $('#comment').css("display", "");
            }   
            if(data == 4){
                $('#star4').addClass('on').prevAll('a').addClass('on');
                $('#showGrade').html(data + "점");
                $('#cancelStar').css("display", "");
                $('#comment').css("display", "");
            }   
            if(data == 5){
            	$('#star5').addClass('on').prevAll('a').addClass('on');
            	$('#showGrade').html(data + "점");
            	$('#cancelStar').css("display", "");
            	$('#comment').css("display", "");
            }
          
        }
    });
    
    
    // 리뷰 조회
    $.ajax('GetContent.bo', {
        data: {
            movieSeq:movieSeq,
            grade:grade
        },
        success: function(data) {
            
            if(data != 0) {
            	$('#commentBtn').css("display", "none");
                $('#commentBox').css("display", "");
                $('#review').html(data);
                $('#deleteBtn').css("display", "");
                $('#updateBtn').css("display", "");
            }
          
        }
    });
    
    
    // 리뷰 등록
    $('#commentBtn').click(function() {
		var review = $('#opinion').val();
		var grade = $('#grade').val();
		
		$.ajax({
			url: "MovieDetail.mo",
			method: "post",
	        dataType: "json",
	        data: {
	            movieSeq:movieSeq,
	            query:query
	        },
	        success: function(data) {

	            $.each(data.Data, function(idx, item) {
	                $.each(item.Result, function(idx, item2) {
	                
	                	var image = item2.posters.split("|");
	                	var poster = image[0]
	                	
	                	$('#dialog-comment').dialog({
	                        modal: true,
	                        buttons: {
	                            "작성": function() {
	                                var review = $('#opinion').val();
	               
	                                $.ajax({
	                                    url: "BoardReviewWrite.bo",
	                                    method: "get",
	                                    async: false,
	                                    data: {
	                                        query:query,
	                                        review:review,
	                                        movieSeq:movieSeq,
	                                        grade:grade,
	                                        poster:poster
	                                    },
	                                    success: function(data) {
	                                        console.log(data);
	                                        
	                                        $('#commentBtn').css("display", "none");
	                                        $('#commentBox').css("display", "");
	                                        $('#review').html(data);
	                                        $('#deleteBtn').css("display", "");
	                                        $('#updateBtn').css("display", "");
	                                    }
	                                });
	                                $(this).dialog('close');
	                                
	                            },
	                            "취소": function() {
	                                $(this).dialog('close');
	                            }
	                        }
	               
	                   });
	                	
	                	
	                	
	                });
	            });    
			}
			
		});
		
    }); 
    
    
    // 리뷰 삭제
    $('#deleteBtn').click(function() {
        
        $('#dialog-delete').dialog({
        	title: "삭제",
             modal: true,
             buttons: {
                 "확인": function() {
                     $.ajax({
                         url: "BoardReviewDelete.bo",
                         method: "get",
                         async: false,
                         data: {
                        	 name:name,
                             query:query,
                             movieSeq:movieSeq
                         },
                         success: function(data) {
                             $('#commentBtn').css("display", "");
                             $('#commentBox').css("display", "none");
                         }
                     });
                     $(this).dialog('close');
                 },
                 "취소": function() {
                     $(this).dialog('close');
                 }
             }
    
        });
    });    
    

    // 리뷰 수정
    $('#updateBtn').click(function() {
        var review = $('#opinion').val();
        
        $('#dialog-comment').dialog({
             modal: true,
             buttons: {
                 "수정": function() {
                     var review = $('#opinion').val();
    
                     $.ajax({
                         url: "BoardReviewUpdate.bo",
                         method: "get",
                         async: false,
                         data: {
                        	 name:name,
                             query:query,
                             review:review,
                             movieSeq:movieSeq,
                             grade:grade
                         },
                         success: function(data) {
                             console.log(data);
                             
                             $('#review').html(data);
                             $('#commentBtn').css("display", "none");
                             $('#commentBox').css("display", "");
                             $('#deleteBtn').css("display", "");
                             $('#updateBtn').css("display", "");
                         }
                     });
                     $(this).dialog('close');
                     
                 },
                 "취소": function() {
                     $(this).dialog('close');
                 }
             }
    
        });
    }); 
	
 
 
    
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
<input type="hidden" id="grade" name="grade" value="<%=grade %>">



<div class="wrap">
	<div class="title_top"></div>
		<% if(pass != null) { %>
		  <div class="starRev">
		       <a class="starR" id="star1"></a>
		       <a class="starR" id="star2"></a>
		       <a class="starR" id="star3"></a>
		       <a class="starR" id="star4"></a>
		       <a class="starR" id="star5"></a>
          </div>
          <div id="showGrade"></div>
          
          <div id="cancelStar" style='display:none'>
            <input id="cancelBtn" type="button" value="취소">
          </div>
          <div id="diStar" style='display:none'>별점을 삭제하시겠습니까?</div>
		  <div class="dibs">
		      <button class="dibsBtn" value="<%=movieSeq %>"><img class="dibsBtnImg" src="img/check.png" width="20px" height="20px">&nbsp;찜꽁</button>
		  </div>
		<%} else { %> 
		  <div class="dibsLogin"><a href="MemberLoginForm.me">로그인</a>하시고 별점을 남겨주세요</div>
		<%} %>
		
		<div id="comment" style="display: none">
			<input id="commentBtn" type="button" value ="코멘트 남기기">
	  		<div id="commentBox" style="display: none">
		  		<div id="reviewName"><%=name %>님의 코멘트</div>
		  		<div id="review"></div>
	  		    <input type="button" id ="deleteBtn" style="display: none" value="삭제">
	  		    <input type="button" id ="updateBtn" style="display: none" value="수정">
		  	</div>	
		</div>
		
		<div id="dialog-comment" title="<%=query %>" style="display:none">
		  <textarea id="opinion" cols="800" rows="800"><%=review %></textarea>
		</div>
		<div id="dialog-delete" style="display:none">코멘트를 삭제하시겠습니까?</div>
		
		<div class="starAvg"></div>
		<div class="posters" ></div>
		<div class="info"></div>
		<a style="color: yellow" class="moreCmt" href="BoardReviewList.bo?movieSeq=<%=movieSeq %>&query=<%=query %>">코멘트 더보기</a>
		<div class="reviewList" >
			<% for(ReviewBean rb : reviewList) {%>
			<div class = "review_box" >
				<span class="reviewLn"><%=rb.getName() %> </span>
				<span class="reviewLg"><img class="reviewStar" src="img/star3.png"> <%=rb.getGrade() %>점</span>
				<hr>
				<div class="reviewLco"><%=rb.getContent() %></div>
				<hr>
				<div id="likeImg"></div>
				<div><%=rb.getLike_count() %></div>
				<div><input type="button" id = "like_<%=rb.getIdx() %>"class="button" value="좋아요"></div>
			</div>
			<%} %>
		</div>
	    <div class="stills" ></div>
	    <div class="directorP"></div>
	    <div class="directorMovie"></div>
   
</div>






	
</body>
</html>