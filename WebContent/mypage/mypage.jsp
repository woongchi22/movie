<%@page import="java.util.ArrayList"%>
<%@page import="java.io.Console"%>
<%@page import="member.dao.MemberDao"%>
<%@page import="member.vo.MemberBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    
<!DOCTYPE html>
<html>
<%
	
%>
<head>
<meta charset="UTF-8">
<title>Mypage</title>
<script src="${pageContext.request.contextPath}/js/jquery-3.5.1.js"></script>
</head>
<body>
<jsp:include page="/inc/top.jsp"/>
	<fieldset>
	<legend>회원 정보 수정</legend>
	<form action="MemberUpdatePro.me" method="post" id="update_fr" class="update_fr">
		<fieldset>
		<legend>이메일</legend>
<%-- 		<input type ="text" id="email" name="email" value="<%=mb.getEmail()%>" > --%>
		</fieldset>
		
		<fieldset>
		<legend>이름</legend>
<%-- 		<input type="text" id="name" name="name" value="<%=mb.getName()%>"> --%>
		</fieldset>	
	
	
		<fieldset>
		<legend>패스워드</legend>
		<input type="password" id="pass" maxlength="15">
		</fieldset>
	
		<input type="submit" value="회원 정보 수정">
		<input type="reset" value="취소">
	</form>
	</fieldset>
</body>
</html>