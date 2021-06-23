<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>

<%
request.setCharacterEncoding("UTF-8");
String email = (String)session.getAttribute("email");
%>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<a href="./index.jsp">Main</a>

<%
if(email != null) { %>
	  <a><%=email %> 님</a> | <a href="MemberLogout.me">로그아웃</a> | <a href="MemberList.me">관리자 페이지</a>
      
<%} else {%>
    <a href="MemberLoginForm.me">로그인</a> | <a href="MemberJoinForm.me">회원가입</a>

<%} %>





<script type="text/javascript">
$(document).ready(function() {
	
});

</script>
</head>
</html>