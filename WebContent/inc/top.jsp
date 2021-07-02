<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("UTF-8");
String name = (String)session.getAttribute("name");
String pass = (String)session.getAttribute("pass");


%>

<link href="${pageContext.request.contextPath}/css/default.css" rel="stylesheet" type="text/css">

<header>
	<nav>
		<span class="mainBar">
		  	<a href="./">Main</a>
		</span>
		<span class="loginBar">
		    <%if(pass != null) { %>
		        <%if(name.equals("관리자")) { %>
		            <a href="Mypage.mp"><%=name %> 님</a> | <a href="MemberLogout.me">로그아웃</a> | <a href="MemberList.me">관리자 페이지</a>
		        <%} else { %>
		            <a href="Mypage.mp"><%=name %> 님</a> | <a href="MemberLogout.me">로그아웃</a>
		     <%} %>
		    <%} else {%>
		        <a href="MemberLoginForm.me">로그인</a> | <a href="MemberJoinForm.me">회원가입</a>
		
		    <%} %>
		</span>
	    <form action="MovieSearch.mo" id="movie_search">
			<span class="searchBar">
			        <input type="search" name="query" placeholder="search">
			        <button type="submit">검색</button>
			</span>
	    </form>
	</nav>
</header>
