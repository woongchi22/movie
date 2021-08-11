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
    
    // 선호하는 영화 리스트
    $.ajax({
        url: "RecommandList.mo",
        method: "post",
        dataType: "json",
        data: {
            name:name
        },
        success: function(data) {
            
            var plus = '';
            for(var i=0; i<data.length; i++) {
//              console.log(data[i].nation);
                plus = data[i].nation + ',' + plus // 나라 다 더하기
            }
            
            var comma = plus.slice(0, -1); // 끝에 콤마 삭제
            const strings = comma.split(','); // 배열로 만들기
            console.log(strings);
            
            // 출현빈도 구하기 1 (forEach)
            const res = {};
            strings.forEach((x) => {
                res[x] = (res[x] || 0) + 1;
            });
            console.log(res);
            
            // 최빈값 구하기
            const keys = Object.keys(res);
            let mode = keys[0];
            keys.forEach((val, idx) => {
                if(res[val] > res[mode]) {
                    mode = val;
                }
            });
//          console.log(mode);
            
            var nation = mode;
            console.log(nation);
            
            // 나라 랜덤
            $.ajax({
                url: "RecommandNationSearch.mo",
                method:"post",       
                dataType: "json",
                data: {
                    nation:nation
                },
                success: function(data) {
                    
                    $('.recommandNation').prepend('<h2><%=name %>님이 선호하는 나라의 영화 추천</h2>');
                    
                    $.each(data.Data, function(idx, item) {
                        var totalCount = item.TotalCount
                        console.log(totalCount);
                        
                        $.ajax("RecommandNationRandomSearch.mo", {
//                          async: false,    
                            dataType:"json",
                            method: 'post',
                            data: {
                                nation:nation,
                                totalCount:totalCount
                            }, 
                            success: function(data) {
                                $.each(data.Data, function(idx,item) {
                                     $.each(item.Result, function(idx2,item2) {
                                         var title1 = item2.title
                                         var titleNoSpace = title1.replace(/ /g, ''); // 타이틀 공백제거
                                         var title2 = titleNoSpace.replace(/!HS/g,'') // 검색어는 !HS , !HE 로 둘러 싸여있어서 제거해줌
                                         var title3 = title2.replace(/!HE/g,'')
                                         var title4 = title3.trim(); // 양쪽끝에 공백을 제거해줌
                                         var title = encodeURIComponent(title4);
                                            
                                         var posters = item2.posters.split("|");
                                         var poster = posters[0]
                                            
                                         if(poster) {
                                             $('.nationMovie').append('<div class=boxOfficeMovie><a href=MovieDetailPro.mo?movieSeq='+item2.movieSeq+'&query='+title4+' class=boxOfficePoster>'+
                                                     '<div class=poster style="background-image:url('+poster+'),url(${pageContext.request.contextPath}/img/noImage.gif);"></div></a>'+
                                                     '<div class=title>'+title4+'</div></div>');
                                         }
                                         
                                           
                                     });
                                 });
                                     
                               $('.nationMovie').slick({
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
                   
                   
                }
                
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
    <div class="recommandNation">
        <div class="nationMovie"></div>
    </div>
    
    
    <input type="hidden" id="name" value="<%=name %>">

</body>
</html>