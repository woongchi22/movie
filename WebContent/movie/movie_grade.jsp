<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
String name = (String)session.getAttribute("name"); 
String movieSeq = (String)request.getParameter("movieSeq");
String query = request.getParameter("query");
String grade = (String)request.getAttribute("grade");

%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>[WhatFilx]</title>
<link href="${pageContext.request.contextPath}/css/default.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath}/css/movie.css" rel="stylesheet" type="text/css">
<script src="${pageContext.request.contextPath}/js/jquery-3.5.1.js"></script>

<%-- modal --%>
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script src="${pageContext.request.contextPath}/js/jquery-ui.js"></script>

<script type="text/javascript">
$(document).ready(function() {
    var query = $('#query').val();
    var movieSeq = $('#movieSeq').val();
    var name = $('#name').val();
    var grade = 0;

    // 영화 평가 
    $.ajax("MovieGradeRandom.mo", {
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
                    
                    var posters = item2.posters.split("|");
                    var poster = posters[0]
                    
                    if(poster) {
                    	
//                     	for(i=0; i<100; i++){
                    		
	                    	$('#gradeMovieList').append('<div class=gradeMovie><a href=MovieDetailPro.mo?movieSeq=' + item2.movieSeq + '&query='
	                    			+ title + '><div class=gradePoster style="background-image: url(' + poster + '), url(${pageContext.request.contextPath}/img/noImage.gif;"></div></a>'
	                    			+ '<div class="starGra"><a class="starG" id="star01"></a><a class="starG" id="star02"></a><a class="starG" id="star03"></a><a class="starG" id="star04"></a><a class="starG" id="star05"></a></div><div class=gradeTitle>'
	                    			+ title4 + '</div></div>');
//                     	}
                    	
                    	$('#gradePoster').eq(idx).text('머노');
                    			
                    	 // 별점 클릭하면 별 채워짐
                        $('.starGra a').click(function() {
                            $(this).parent().children('a').removeClass('on');
                            $(this).addClass('on').prevAll('a').addClass('on');
                            return false;
                        });
                    	 
                        $('.starGra a').on("click", function() {
                            var idx = $('.starGra a').index(this);
                            console.log(idx);
                        });
                    	 
                    }
                    
                    
                    
                                       
                    var grade = 0;
                    $('#star01').click(function() {
                        var grade =  1;
                        console.log(grade+'별점!!!');
                        starClick(grade);
                    });
                    
                    $('#star02').click(function() {
                        var grade = 2; 
                        starClick(grade);
                    });
                    
                    $('#star03').click(function() {
                        var grade = 3;
                        starClick(grade);
                    });
                    
                    $('#star04').click(function() {
                        var grade = 4;
                        starClick(grade);
                    });
                    
                    $('#star05').click(function() {
                        var grade = 5;
                        starClick(grade);
                    }); 

                    
                    
                }); //each2
                
            }); // each
            
        } // success
    
    }); // ajax
    
    // 별점 클릭 시 함수
    function starClick(grade) {
        console.log(grade+'별점들고와주라');
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
                
//                     if(typeof(Storage) != 0) {
//                         localStorage.setItem("getStar", data+"점");
//                         document.getElementById("showGrade").innerHTML = localStorage.getItem("getStar");
                        
//                         if($('#cancelStar').css("display") == "none") {
//                             jQuery('#cancelStar').show(); 
//                         } 
                        
//                     } else {
//                         document.getElementById("showGrade").innerHTML = "별점을 남겨주세요";
//                     }
            }
        });
    }
    
   

    
    	
    
//     // 별점
//     var grade = 0;
//     $.ajax("MovieDetail.mo", {
//         method: "post",
//         dataType: "json",
//         data: {
//             movieSeq:movieSeq,
//             query:query,
//             grade:grade,
//             name:name
//         },
//         success: function(data) {
            
//             $.each(data.Data, function(idx, item) {
//                 $.each(item.Result, function(idx, item2) {

                    
//                     $('#star1').click(function() {
//                         var grade = 1;
//                         starClick(grade);
//                     });
                    
//                     $('#star2').click(function() {
//                         var grade = 2; 
//                         starClick(grade);
//                     });
                    
//                     $('#star3').click(function() {
//                         var grade = 3;
//                         starClick(grade);
//                     });
                    
//                     $('#star4').click(function() {
//                         var grade = 4;
//                         starClick(grade);
//                     });
                    
//                     $('#star5').click(function() {
//                         var grade = 5;
//                         starClick(grade);
//                     });
                    
//                 }); //each2
                
//             }); // each
            
//         } // success
        
//     }); // ajax - MovieDetail
    
    
    
//     // 별점 삭제
//     function dialogStar() {
        
//         $('#diStar').dialog({
//             title: "별점",
//             modal: true,
//             buttons: {
//                 "확인": function() {
//                     $.ajax('DeleteStar.mo', {
//                         data: {
//                             name:name,
//                             query:query,
//                             movieSeq:movieSeq
//                         },
//                         success: function(data) {
//                             $('#star5').removeClass('on').prevAll('a').removeClass('on');
//                             $('#showGrade').html('별점을 남겨주세요');
//                             $('#cancelStar').css("display", "none");
//                         }
//                     });
                    
//                     $(this).dialog('close');
                    
//                 },
//                 "취소": function() {
//                     $(this).dialog('close');
//                 }
//             }
//         });
        
//     }
    
//     // 별점 취소 클릭
//     $('#cancelBtn').on("click", function() {
//         dialogStar();
//     });
    
//     // 별점 조회
//     $.ajax('Star.mo', {
//         data: {
//             movieSeq:movieSeq,
//             grade:grade
//         },
//         success: function(data) {
//             console.log('데이터' + data);
            
//             if(data == 0){
//                 $('#showGrade').html('별점을 남겨주세요');
//             }
//             if(data == 1){
//                 $('#star1').addClass('on').prevAll('a').addClass('on');
//                 $('#showGrade').html('1점');
//                 $('#cancelStar').css("display", "");
//             }
//             if(data == 2){
//                 $('#star2').addClass('on').prevAll('a').addClass('on');
//                 $('#showGrade').html('2점');
//                 $('#cancelStar').css("display", "");
//             }   
//             if(data == 3){
//                 $('#star3').addClass('on').prevAll('a').addClass('on');
//                 $('#showGrade').html('3점');
//                 $('#cancelStar').css("display", "");
//             }   
//             if(data == 4){
//                 $('#star4').addClass('on').prevAll('a').addClass('on');
//                 $('#showGrade').html('4점');
//                 $('#cancelStar').css("display", "");
//             }   
//             if(data == 5){
//                 $('#star5').addClass('on').prevAll('a').addClass('on');
//                 $('#showGrade').html('5점');
//                 $('#cancelStar').css("display", "");
//             }
            
//         }
//     });
    
    
    
     
});


</script>
</head>
<header>
    <jsp:include page="/inc/top.jsp"/>
</header>
<body>
<input type ="hidden" id="query" name="query" value="<%=query %>">
<input type ="hidden" id="movieSeq" name="movieSeq" value="<%=movieSeq %>">
<input type="hidden" id="name" name="name" value="<%=name %>">

    <h2>영화를 평가하시면 <%=name %>님의 취향에 맞게 추천해드립니다</h2>
    <div class="otherMovie"><a href="GradeMovie.mo">다른 영화 더보기</a></div>
    <div id="gradeMovieList">
    
<!--         <div id="showGrade"></div> -->
        
<!--         <div id="cancelStar" style='display:none'> -->
<!--           <input id="cancelBtn" type="button" value="취소"> -->
<!--           <div id="diStar" style='display:none'>별점을 삭제하시겠습니까?</div> -->
<!--         </div> -->
    
    </div>
    

</body>
</html>