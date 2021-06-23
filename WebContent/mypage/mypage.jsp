<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>




<head>
<meta charset="UTF-8">
<title>Mypage</title>
</head>
<body>
	<fieldset>
	<legend>회원 정보 수정</legend>
	<form action="MemberUpdatePro.me" method="post" id="update_fr" class="update_fr">
		<fieldset>
		<legend>이메일</legend>
<%-- 		<input type ="text" id="email" name="email" value="<%=memberBean.getEmail() %>" redonly > --%>
		</fieldset>
		
		<fieldset>
		<legend>닉네임</legend>
<%-- 		<input type="text" id="name" name="name" value="<%=memberBean.getName%>"> --%>
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