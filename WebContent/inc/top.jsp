<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("UTF-8");
String name = (String)session.getAttribute("name");
String pass = (String)session.getAttribute("pass");


%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>What top</title>
</head>
<body>
    <header>
        
        <form action="MovieSearch.mo" id="movie_search">
            <input type="search" name="search" placeholder="search">
            <button type="submit">검색</button>
        </form>
        
        <a href="./">Main</a>
        
        <%if(pass != null) { %>
            <%if(name.equals("관리자")) { %>
                <a href="Mypage.mp"><%=name %> 님</a> | <a href="MemberLogout.me">로그아웃</a> | <a href="MemberList.me">관리자 페이지</a>
            <%} else { %>
                <a href="Mypage.mp"><%=name %> 님</a> | <a href="MemberLogout.me">로그아웃</a>
	        <%} %>
        <%} else {%>
            <a href="MemberLoginForm.me">로그인</a> | <a href="MemberJoinForm.me">회원가입</a>

        <%} %>
        
    </header>

</body>
</html>