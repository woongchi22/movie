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
    var grade = $('#grade').val();

    // 영화 평가 
    $.ajax("MovieGradeRandom.mo", {
        method: "post",
        dataType: "json",
        data: {
            movieSeq:movieSeq,
            query:query,
            name:name
        },
        success: function(data) {
            
            $.each(data.Data, function(idx, item) {
                $.each(item.Result, function(idx, item2) {
                	
                    var title1 = item2.title
                    var titleNoSpace = title1.replace(/ /g, ''); // 타이틀 공백제거
                    var title2 = titleNoSpace.replace(/!HS/g,'') // 검색어는 !HS , !HE 로 둘러 싸여있어서 제거해줌
                    var title3 = title2.replace(/!HE/g,'')
                    var title = title3.trim(); // 양쪽끝에 공백을 제거해줌
                    var title4 = encodeURIComponent(title);
                    
                    var director = item2.directors.director[0].directorNm
                    var runtime = item2.runtime;
                    var genre = item2.genre;
                    var nation = item2.nation;
                    var movieSeq = item2.movieSeq;
                    
                    var posters = item2.posters.split("|");
                    var poster = posters[0]
                    
                    if(poster) {
                    	$('#gradeMovieList').append('<div class=gradeMovie id=m_' + idx + '><a href=MovieDetailPro.mo?movieSeq=' + item2.movieSeq + '&query='
                    			+ title + '><div class=gradePoster style="background-image: url(' + poster + '), url(${pageContext.request.contextPath}/img/noImage.gif;"></div></a>'
                    			+ '<div class=starGra id=m_' + idx + '><a class=starG id=star01_' + idx +'></a><a class=starG id=star02_' + idx + '></a><a class=starG id=star03_' + idx 
                    			+ '></a><a class=starG id=star04_' + idx + '></a><a class=starG id=star05_' + idx + '></a></div><div class=gradeTitle>' + title + '</div></div>');
                    }
                    
                    // 별점 클릭하면 별 채워짐
                    $('.starGra a').click(function() {
                        $(this).parent().children('a').removeClass('on');
                        $(this).addClass('on').prevAll('a').addClass('on');
                        return false;
                    });
                    
                                       
                    var grade = 0;
                    var query = title;
                    $('#star01_' + idx).click(function() {
                        var grade =  1;
                        
                        // 별점 등록 확인
                        $('#dialog-check').dialog({
                             title: "별점 " + grade + "점 등록",
                             modal: true,
                             buttons: {
                                 "확인": function() {
                                	 starClick(grade, nation, director, genre, runtime, poster, movieSeq, query, idx);
                                     $(this).dialog('close');
                                 },
                                 "취소": function() {
                                     $(this).dialog('close');
                                     $('.starG').removeClass('on');
                                 }
                             }
                        });
                    });
                    
                    $('#star02_' + idx).click(function() {
                        var grade = 2; 

                        // 별점 등록 확인
                        $('#dialog-check').dialog({
                             title: "별점 " + grade + "점 등록",
                             modal: true,
                             buttons: {
                                 "확인": function() {
                                     starClick(grade, nation, director, genre, runtime, poster, movieSeq, query, idx);
                                     $(this).dialog('close');
                                 },
                                 "취소": function() {
                                     $(this).dialog('close');
                                     $('.starG').removeClass('on');
                                 }
                             }
                        });
                    });
                    
                    $('#star03_' + idx).click(function() {
                        var grade = 3;
                        
                        // 별점 등록 확인
                        $('#dialog-check').dialog({
                             title: "별점 " + grade + "점 등록",
                             modal: true,
                             buttons: {
                                 "확인": function() {
                                     starClick(grade, nation, director, genre, runtime, poster, movieSeq, query, idx);
                                     $(this).dialog('close');
                                 },
                                 "취소": function() {
                                     $(this).dialog('close');
                                     $('.starG').removeClass('on');
                                 }
                             }
                        });
                    });
                    
                    $('#star04_' + idx).click(function() {
                        var grade = 4;
                        
                        // 별점 등록 확인
                        $('#dialog-check').dialog({
                             title: "별점 " + grade + "점 등록",
                             modal: true,
                             buttons: {
                                 "확인": function() {
                                     starClick(grade, nation, director, genre, runtime, poster, movieSeq, query, idx);
                                     $(this).dialog('close');
                                 },
                                 "취소": function() {
                                     $(this).dialog('close');
                                     $('.starG').removeClass('on');
                                 }
                             }
                        });
                    });
                    
                    $('#star05_' + idx).click(function() {
                        var grade = 5;
                        
                        // 별점 등록 확인
                        $('#dialog-check').dialog({
                             title: "별점 " + grade + "점 등록",
                             modal: true,
                             buttons: {
                                 "확인": function() {
                                     starClick(grade, nation, director, genre, runtime, poster, movieSeq, query, idx);
                                     $(this).dialog('close');
                                 },
                                 "취소": function() {
                                     $(this).dialog('close');
                                     $('.starG').removeClass('on');
                                 }
                             }
                        });
                    }); 
                    
                }); //each2
                
            }); // each
            
        } // success
    
    }); // ajax
    
    
    // 별점 클릭 시 함수
    function starClick(grade, nation, director, genre, runtime, poster, movieSeq, query, idx) {
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
            	$('#m_' + idx).css("display", "none");
            	
            }
        });
    	
    }
    
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
<input type="hidden" id="grade" name="grade" value="<%=grade %>">

    <h2>영화를 평가하시면 <%=name %>님의 취향에 맞게 추천해드립니다</h2>
    <div class="otherMovie"><a href="GradeMovie.mo">다른 영화 더보기</a></div>
    <div id="gradeMovieList"></div>
    
    <div id="dialog-check" style="display:none">별점을 등록하시겠습니까?</div>
    
</body>
</html>