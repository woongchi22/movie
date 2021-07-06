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
<link rel="stylesheet" type="text/css" href="slick/slick.css"/>
<link rel="stylesheet" type="text/css" href="slick/slick-theme.css"/>				
<link href="${pageContext.request.contextPath}/css/default.css" rel="stylesheet" type="text/css">
<script src="${pageContext.request.contextPath}/js/jquery-3.5.1.js"></script>
<script type="text/javascript">
$(document).ready(function() {

	var result;
	// 하루 전 날짜 구하기
    var d = new Date();
    var yy = d.getFullYear();
    var mm = d.getMonth() + 1; // 리턴값: (0~11) +1 => 1월~12월
    var dd = d.getDate();
    
    if(d.getDay()!=0){
 	   dd = dd-d.getDay();
    }else{
 	   dd = -7; 
    }
		if(dd<=0){ // 마지막 일요일이 지난달일경우 계산하는 계산 식
			var lastDay = new Date(yy,mm-1,0).getDate();
			dd = lastDay - Math.abs(dd);
			mm = mm-1;
		}
		
		if(mm < 10){
          mm = "0" + mm; 
        }
        if(dd < 10){
          dd = "0" + dd;
        }
		
    var today = yy + "" + mm + "" + dd; // 박스오피스에서 정해준 날짜 형식(yyyymmdd)으로 변환
    $.ajax({
         url: "BoxOffice.mo",
                 // &itemPerPage: 1-10위 까지의 데이터가 출력되도록 설정(최대 10)
         method:"get",       
         dataType: "json",
         data: {
         	targetDt:today,
          	},
         success: function(data) {
         	$('.boxOfficeMovie').prepend('<h2>박스오피스</h2>');
            $.each(data, function(idx, item) {
         	   $.each(item.weeklyBoxOfficeList, function(idx2,item2){
         		    var title = item2.movieNm;
                    var titleNoSpace = title.replace(/ /g, '');
                    var openDt = item2.openDt.replace(/-/g,'');
                    var num =0;
                    
                    result = getNation(openDt,titleNoSpace);
                    result = result.split("|");	 
                    
					$('.boxOffice').append("<div class=boxOfficeMovie>"+
          			 '<a class=boxOfficePoster><div class=poster style="background-image:url('+result[0]+'),url(${pageContext.request.contextPath}/img/noImage.gif);"></div></a>'+
          			 '<div class=title>'+item2.movieNm+'</div></div>');   
           
           			$('.boxOfficePoster').eq(idx2).attr('href','MovieDetailPro.mo?movieSeq='+result[2]+'&query='+titleNoSpace);
                    
         	   });
         	  
                
            });
            
            $('.boxOffice').slick({
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
    
    function getNation(openDt,title){
        $.ajax("BoxOfficeNation.mo",{
             method: "get",
             dataType: "json",
             async: false, // ajax 방식일때 리턴값만 비동기로 바꿔주는 부분
             data : {
                openDt:openDt,
                title:title
                 },
             success: function(data) { 
                 $.each(data.Data, function(idx, item) {
                   $.each(item.Result,function(idx2,item2){
                	   
                       var image = item2.posters.split("|");
                       result = image[0] +"|"+item2.nation + "|"+item2.movieSeq;
//                         result = image[0] +"|"+item2.nation + "|"+item2.movieSeq +"|"+item2.movieId +"|"+item2.rating[0].ratingGrade; // 밑에 영화포스터 링크(a 태그)안에 movieId,ratingGrade 포함해야해서 추가함 - 낙원
                   });
                 });
                 
             }
       }); 
        return result;
        
     }
    
    
}); 

</script>
</head>

<header>
    <jsp:include page="/inc/top.jsp"/>
</header>
<body>
   <div class="boxOfficeMovie">
   	 <div class="boxOffice"></div>
   </div>
 
  <script type="text/javascript" src="//code.jquery.com/jquery-1.11.0.min.js"></script>
  <script type="text/javascript" src="//code.jquery.com/jquery-migrate-1.2.1.min.js"></script>
  <script type="text/javascript" src="slick/slick.min.js"></script>	
 
</body>
</html>
