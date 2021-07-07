<%@page import="member.vo.MemberBean"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자 페이지</title>
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
        height: 30px;
        font-weight: bold;
    }
    
    h2 {
        text-align: center;
    }
    
</style>
<%
	ArrayList<MemberBean> mbList = (ArrayList<MemberBean>)request.getAttribute("mbList");
%>

</head>
<header>
    <jsp:include page="/inc/top.jsp"/>
</header>
<body>
	<section id="listForm">
	    <h2>회원 List</h2>
	    <table>
	        <tr id="tr_top">
	            <td width="250">idx</td>
	            <td width="400">이메일</td>
	            <td width="250">이름</td>
	            <td width="250">비밀번호</td>
	            <td width="300">가입 날짜</td>
	        </tr>
	        <%
	        	for(MemberBean mb : mbList) {
	        %>
		        <tr>
		            <td align="center"><%= mb.getIdx() %></td>
		            <td align="center"><%= mb.getEmail() %></td>
		            <td align="center"><%= mb.getName() %></td>
		            <td align="center"><%= mb.getPass() %></td>
		            <td align="center"><%= mb.getDate() %></td>
		        </tr>
	        <%}%>
	    </table>
	</section>
</body>
</html>