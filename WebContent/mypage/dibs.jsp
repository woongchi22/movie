<%@page import="mypage.vo.DibsBean"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<%
request.setCharacterEncoding("UTF-8");
ArrayList<DibsBean> dbList = (ArrayList<DibsBean>) request.getAttribute("dbList");
String name = (String) session.getAttribute("name");

%>
<head>
<meta charset="UTF-8">
<title>WhatFilx - 찜</title>
<link href="${pageContext.request.contextPath}/css/default.css" rel="stylesheet" type="text/css">
<script src="${pageContext.request.contextPath}/js/jquery-3.5.1.js"></script>

</head>
<header>
    <jsp:include page="/inc/top.jsp"/>
</header>
<body>
    <h2><%=name %>님이 찜한 영화</h2>
    
    <% for(DibsBean db : dbList) { %>
        <div class="dibsMovie">
            <a href="MovieDetailPro.mo?movieSeq=<%=db.getMovieSeq() %>&query=<%=db.getTitle() %>">
                <div class="posterDibs" style="background-image: url('<%=db.getPoster() %>'), url(${pageContext.request.contextPath}/img/noImage.gif);"></div>
            </a>
            <div class="titleDibs"><%=db.getTitle() %></div>
        </div>
    <%} %>
    


</body>
</html>