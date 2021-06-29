<%@page import="member.vo.MemberBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<%

// String ls_test = "세션에 저장된 데이터가 바로 접니다. ^O^";


// session.setAttribute("email", email);    // "Testing"을 키로 문자열을 저장

// session.setAttribute("name", name);    // "MyData"를 키로 정수를 저장


%>
<head>
<meta charset="UTF-8">
<title>Login</title>
<link href="${pageContext.request.contextPath}/css/default.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath}/css/memberLogin.css" rel="stylesheet" type="text/css">
<script src="${pageContext.request.contextPath}/js/jquery-3.5.1.js"></script>
<script type="text/javascript">

$(document).ready(function() {
	
	// 로그인 입력란
	$('#login').submit(function() {
		
		if($('#email').val() == "") {
            $('#check_email').text('이메일을 입력해주세요');
            $('.check_font').css('color', 'red');
            $('#email').focus();
            return false;
        }else{
            $("#check_email").hide();
        }
		
        if($('#pass').val() == "") {
            $('#check_pass').text('비밀번호를 입력해주세요');
            $('.check_font').css('color','red');
            $('#pass').focus();
            return false;
        }else{
            $("#check_pass").hide();
        }
		
	});
	
	$('#email').keyup(function() {
        if($('#email').val() == '') {
            $('#check_email').show();
        } else {
            $('#check_email').hide();
        }
    });
    
    $('#pass').keyup(function() {
        if($('#pass').val() == '') {
            $('#check_pass').show();
        } else {
            $('#check_pass').hide();
        }
    });

	
});



</script>
</head>
<header>
	<jsp:include page="/inc/top.jsp"/>
</header>

<body>
	<div class="loginAll">
		<div class="loginLogin">
	   	 	<span class="loginSpan">로그인</span>
		    <a class="loginOther" href="ForgetPassForm.me">비밀번호 찾기 |</a> 
		    <a class="loginOther" href="MemberJoinForm.me">| 회원가입</a>
		</div>
	    <form action ="MemberLoginPro.me" method = "post" id="login">
		    <div>
	            <input type="text" name="email" id="email" placeholder="이메일(xxx@xxx.xxx)" class="loginEmail">
	            <div class="check_font" id="check_email"></div>
		    </div>
		    <div>
		        <input type="password" name="pass" id="pass" maxlength="15" placeholder="비밀번호" class="loginPass">
		        <div class="check_font" id="check_pass"></div>
		    </div>
			<div>
				<input type = "submit" value = "로그인" id = "submit" class="loginSubmit">
<!-- 					<input type = "button" value = "회원가입" onclick="location.href='MemberJoinForm.me'"> -->
<!-- 					<input type = "button" value = "취소" onclick = "location.href='./'"><br> -->
			</div>
	    </form>

	</div>
	
</body>
</html>