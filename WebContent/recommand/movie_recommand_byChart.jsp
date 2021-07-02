<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
<script type="text/javascript">
$(document).ready(function(){
	$.ajax('MovieGetChart.mo'),{
		method : "get",
		dataType : "json",
		async : false,
		success : function(data){
			if(data[0].movieTitle){
				$('.chartMovie').prepend('<h1>일간 인기 영화 순위! </h1>')
			}
			$.each(data,function(index,item){
				
				$('.MovieChart').append("<div class=MovieChartMovie>"+
              			'<a class=MovieChartPoster><div class=poster style="background-image: url('+item.moviePoster+'),url(${pageContext.request.contextPath}/img/noImage.gif;"></div></a>'+
              			
              			'<div class=title>'+item.movieTitle+'</div></div>');   
			
               $('.MovieChartPoster').eq(index).attr('href','MovieDetailPro.mo?movieSeq='+item.movieSeq+'&query='+item.movieTitle);
				
				
			});
		
			$('.MovieChart').slick({
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
<body>
	<div class="chartMovie">
		<div class="MovieChart"></div>
	</div>
</body>
</html>