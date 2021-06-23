<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
String name = (String)session.getAttribute("name");
%>
<html>
<head>
<title>Main</title>
</head>
<body>
    <jsp:include page="/inc/top.jsp"/>
    

</body>
</html>