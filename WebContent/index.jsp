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
		<h3 id="h3"><a href="MemberLoginForm.me" style="color: red">로그인</a>을 하시면 영화를 추천해드립니다</h3>
		<div class="content">
			<jsp:include page="/recommand/movie_ranking.jsp"/>
		</div>
		
		<%if(name != null) { %>
	      <script type="text/javascript">
	      $('#h3').css("display", "none");
	      </script>
	      
			<div class="content">
	            <jsp:include page="/recommand/movie_genre.jsp"/>
	        </div>
	        
	        <div class="content">
                <jsp:include page="/recommand/movie_nation.jsp"/>
            </div>
            
		<%} %>

	</section>



</body>
</html>