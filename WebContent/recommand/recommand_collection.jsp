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
            
			$('.recommandCollection').prepend('<h2> 님의 컬렉션</h2>');
			
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