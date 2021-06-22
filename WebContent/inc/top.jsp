<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>

<%
request.setCharacterEncoding("UTF-8");
String name = (String)session.getAttribute("name");
%>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<a href="Main.me">Main</a>

<%
if(name != null) { %>
	  <a href="Mypage.me"><%=name %> 님</a>
	  <a href="MemberLogout.me">로그아웃</a>
      
<%} else {%>
    <a href="MemberLoginForm.me">로그인</a>
    <a href="MemberJoinForm.me">회원가입</a>

<%} %>





<script type="text/javascript">
$(document).ready(function() {
	
});

</script>
</head>
</html>