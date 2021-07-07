<%@page import="mypage.vo.DibsBean"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<%
request.setCharacterEncoding("UTF-8");
ArrayList<DibsBean> dbList = (ArrayList<DibsBean>) request.getAttribute("dbList");

%>
<head>
<meta charset="UTF-8">
<title>관리자 찜꽁 페이지</title>
<link href="${pageContext.request.contextPath}/css/default.css" rel="stylesheet" type="text/css">
<script src="${pageContext.request.contextPath}/js/jquery-3.5.1.js"></script>
<style type="text/css">
td{
    border : 1px solid black;
}
table {
        margin: auto;
        width: 800px;
        border: 1px solid darkgray;
}
    
    #listForm tr {
    border: 1px solid darkgray;
    }
    
    #listForm td {
    border: 1px solid darkgray;
    }
    
    a {
        text-decoration: none;
    }

    #tr_top {
        background: red;
        width: 800px; 
        text-align: center;
    }
    
    h2 {
        text-align: center;
    }
    
</style>
</head>
<header>
    <jsp:include page="/inc/top.jsp"/>
</header>
<body>
    <section id="listForm">
        <h2>회원 찜꽁 List</h2>
        <table>
            <tr id="tr_top">
                <td width="250">idx</td>
                <td width="250">name</td>
                <td width="250">movieSeq</td>
                <td width="400">title</td>
            </tr>
            <%
                for(DibsBean db : dbList) {
            %>
                <tr>
                    <td align="center"><%= db.getIdx() %></td>
                    <td align="center"><%= db.getName() %></td>
                    <td align="center"><%= db.getMovieSeq() %></td>
                    <td align="center"><%= db.getTitle() %></td>
                </tr>
            <%}%>
        </table>
    </section>

</body>
</html>