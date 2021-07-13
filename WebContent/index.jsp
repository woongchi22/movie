<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
String name = (String)session.getAttribute("name");
%>
<html>
<head>
<title>WhatFlix</title>
<link href="${pageContext.request.contextPath}/css/default.css" rel="stylesheet" type="text/css">
</head>
<header>
	<jsp:include page="/inc/top.jsp"/>
</header>
<body>
	<section id="main">
		<div class="content">
			<jsp:include page="/recommand/movie_ranking.jsp"/>
		</div>
<!-- 		<div class="content"> -->
<%-- 			<jsp:include page="/recommand/movie_recommand_byChart.jsp"/> --%>
<!-- 		</div> -->

	</section>



</body>
</html>