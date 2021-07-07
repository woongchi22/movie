<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
String name = (String)session.getAttribute("name"); 
String movieSeq = (String)request.getParameter("movieSeq");
String query = request.getParameter("query");

%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>평가하기</title>
<link href="${pageContext.request.contextPath}/css/default.css" rel="stylesheet" type="text/css">
<script src="${pageContext.request.contextPath}/js/jquery-3.5.1.js"></script>
<script type="text/javascript">
$(document).ready(function() {
    var query = $('#query').val();
    var movieSeq = $('#movieSeq').val();
    var name = $('#name').val();
    
    // 영화 평가 
    $.ajax("MovieGradeRandom.mo", {
        method: "post",
        dataType: "json",
        data: {
            movieSeq:movieSeq
        },
        success: function(data) {
        	console.log("오나");
            
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
                    console.log(title4);
                    
                    if(poster) {
                    	$('#gradeMovieList').append('<div id=gradeMovie><a href=MovieDetailPro.mo?movieSeq=' + item2.movieSeq + '&query='
                    			+ title + '><div class=gradePoster style="background-image: url(' + poster + '), url(${pageContext.request.contextPath}/img/noImage.gif;"></div></a>'
                    			+ '<div class=gradeTitle>' + title4 + '</div></div>');
                    }
                    
                }); //each2
                
            }); // each
            
        } // success
    
    }); // ajax
    
     
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
    <div id="gradeMovieList"></div>

</body>
</html>