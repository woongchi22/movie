<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<%
String name = (String)session.getAttribute("name");
%>
<title>Main</title>
</head>
<body>
    <jsp:include page="/inc/top.jsp"/>
    

</body>
</html>