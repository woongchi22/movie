<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
String name = (String)session.getAttribute("name");

%>     
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
<link href="${pageContext.request.contextPath}/css/default.css" rel="stylesheet" type="text/css">
<script src="${pageContext.request.contextPath}/js/jquery-3.5.1.js"></script>

<%-- slick --%>
<link rel="stylesheet" type="text/css" href="slick/slick.css"/>
<link rel="stylesheet" type="text/css" href="slick/slick-theme.css"/>   
<script type="text/javascript" src="slick/slick.min.js"></script>

<script type="text/javascript">
$(document).ready(function() {
	var name = $('#name').val();
	
	// 컬렉션 리스트
	$.ajax({
		url: "CollectionList.mp",
		method: "post",
		dataType: "json",
		data: {
			name:name
		},
		success: function(data) {
			console.log(data);
			
            var count = data.length
			const random = Math.floor(Math.random() * count) + 1;
            
			var col_name = data[random].collection_name
			var arrName = data[random].name
			
			var arrMovieSeq = data[random].movieSeq
			var movieSeq = arrMovieSeq.split(',');
			
			var arrPoster = data[random].poster
			var poster = arrPoster.split(',');
			
			var arrTitle = data[random].title
            var title = arrTitle.split('&');
			
			
			$('.recommandCollection').prepend("<h2>" + arrName + "님이 추천하는 '" + col_name + "' 컬렉션</h2>");
			
			for(var i = 0; i<movieSeq.length; i++){
			    $('.collectionMovie').append('<div><a href=MovieDetailPro.mo?movieSeq=' + movieSeq[i] + '&query=' + title[i] + ' class=boxOfficePoster>'+
			    		'<div class=poster style="background-image:url(' + poster[i] + '),url(${pageContext.request.contextPath}/img/noImage.gif);"></div></a>' + 
			    		'<div class=title>' + title[i] + '</div></div>');
			}
			
			$('.collectionMovie').slick({
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
	
	
});


</script>

</head>
<header>
    <jsp:include page="/inc/top.jsp"/>
</header>
<body>
    <div class="recommandCollection">
        <div class="collectionMovie"></div>
    </div>

    <input type="hidden" id="name" value="<%=name %>">
</body>
</html>