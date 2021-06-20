<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Login</title>
</head>

<body>
<h1>로그인</h1>
<form action ="MemberLoginPro.me" method = "post" id="login">
이메일 : <input type = "text" name = "email" id = "email" ><br>
비밀번호 : <input type = "password" name ="pass" id = "id"><br>
<input type = "submit" value = "로그인" id = "submit">
<input type = "button" value = "회원가입" id = "join" onclick="location.href='MemberJoinForm.me'">
<input type = "button" value = "취소" onclick = "history.back()">
</form>

</body>
</html>