<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
	
	$.ajax({
		url: "recommandGenre.mo",
		
		
		
	});
	
});


</script>

</head>
<header>
    <jsp:include page="/inc/top.jsp"/>
</header>

<body>
    <div class="recommandGenre">
        <div class="boxOffice"></div>
    </div>

</body>
</html>