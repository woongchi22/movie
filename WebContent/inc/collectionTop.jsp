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
		  	<a href="./" ><img src="img/logo.png" width="85px" height="50px"></a>
		</span>
		<span class="gradeBar">
		  <%if(pass != null) { %>
		      <a href="GradeMovie.mo">평가하기</a> &nbsp;&nbsp;&nbsp;
		      <a href="ExploreMovie.mo">탐색하기</a>
		  <%} %>    
		</span>
		<span class="loginBar">
		    <%if(pass != null) { %>
		        <%if(name.equals("관리자")) { %>
		            <a href="MemberLogout.me">로그아웃</a> | <a href="DibsAdmin.mp">찜꽁 관리</a> | <a href="MemberList.me">회원 관리</a>
		        <%} else { %>
		            <a href="Mypage.mp"><%=name %>님</a> | <a href="MemberLogout.me">로그아웃</a>
		        <%} %>
		    <%} else {%>
		        <a href="MemberLoginForm.me">로그인</a> | <a href="MemberJoinForm.me">회원가입</a>
		
		    <%} %>
		</span>
		<span class="dibsBar">
		  <%if(pass != null) { %>
		      <%if(name.equals("관리자")) {%>
		          <a>관리자</a>
		      <%} else { %>
		          <a href="DibsList.mp"><%=name %> 's <img src="img/check.png" width="15px" height="15px">&nbsp;찜꽁</a>
		      <%} %>
		  <%} %>
		</span>
	    <form action="CollectionSearch.mo" id="collection_search">
			<span class="searchBar">
			        <input class="searchIn" type="search" name="query" placeholder="Search...">
			        <button class="searchBtn" type="submit"><img src="img/search.png" width="15px" height="15px"></button>
			</span>
	    </form>
	</nav>
</header>
