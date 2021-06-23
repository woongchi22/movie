<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Login</title>

<script src="${pageContext.request.contextPath}/js/jquery-3.5.1.js"></script>
<script type="text/javascript">

$(document).ready(function() {
	
	// 로그인 칸 공백일 시
	
	$('#login').submit(function() {
		if($('#email').val() == "") {
			alert("이메일을 입력하세요");
			$('#email').focus();
			return false;
		}
		if($('#pass').val() == "") {
            alert("비밀번호를 입력하세요");
            $('#pass').focus();
            return false;
        }
		
		// 로그인
		

		
// 		var action = $('#login').attr('action');
// 		var form_data = {
// 				email: $('#email').val(),
// 				pass: $('#pass').val(),
// 				is_ajax: 1
// 		};
		
// 		$.ajax({
// 			type: "post",
// 			url: action,
// 			data: form_data,
// 			success: function(response) {
// 				if(response == 'success') {
// 					$('#message').html("로그인 성공");
// // 					$('#login').slideUp('slow');
// 				} else {
// 					$('#message').html("이메일 또는 비밀번호가 잘못되었습니다");
// 				}
// 			}
// 		});
// 		return false;
		
	});


	
});

<%
String msg = request.getParameter("msg");

if(msg != null && msg.equals("0")) {
	out.println("비밀번호를 확인하세요");
}
%>




</script>
</head>

<body>
<h1>로그인</h1>
<form action ="MemberLoginPro.me" method = "post" id="login">
이메일 : <input type = "text" name = "email" id = "email" placeholder="이메일을 입력하세요"><br>
비밀번호 : <input type = "password" name ="pass" id = "pass" placeholder="비밀번호를 입력하세요"><br>
<input type = "submit" value = "로그인" id = "submit">
<input type = "button" value = "회원가입" onclick="location.href='MemberJoinForm.me'">
<input type = "button" value = "취소" onclick = "history.back()"><br>
<div id="message"></div>
<a href = "ForgetEmail.me">이메일 찾기</a>
<a href = "ForgetPass.me">비밀번호 찾기</a>
</form>


</body>
</html>