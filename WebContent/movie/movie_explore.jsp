<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>[WhatFilx]</title>
<link href="${pageContext.request.contextPath}/css/default.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath}/css/movie.css" rel="stylesheet" type="text/css">
<script src="${pageContext.request.contextPath}/js/jquery-3.5.1.js"></script>


</head>
<header>
    <jsp:include page="/inc/top.jsp"/>
</header>
<body>

    <h2>찾고싶은 작품을 탐색해보세요</h2>
    <div>
        <select id="genreExplore">
            <option id="allGenre">모든 장르</option>
            <option id=""></option>
            <option id=""></option>
            <option id=""></option>
            <option id=""></option>
            <option id=""></option>
            <option id=""></option>
            <option id=""></option>
            <option id=""></option>
            <option id=""></option>
            <option id=""></option>
            <option id=""></option>
            
        </select>
        <select id="nationExplore">
            <option id="allNation">모든 국가</option>
            
        </select>
        <select id="recommandExplore">
            <option id="randomRecommand">랜덤 추천</option>
            
        </select>
        
    </div>

</body>
</html>