<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입</title>

<script src="${pageContext.request.contextPath}/js/jquery-3.5.1.js"></script>
<script type="text/javascript" >

$(document).ready(function() {
	
	// 회원가입 입력란
	$("button").click(function() {
		if($('#email').val() == "") {
            alert("이메일을 입력하세요");
            $('#email').focus();
            return false;
	    }
		if($('#name').val() == "") {
			alert("이름을 입력하세요");
			$('#name').focus();
			return false;
		}
		if($('#pass').val() == "") {
            alert("패스워드를 입력하세요");
            $('#pass').focus();
            return false;
	    }
		if($('#passConfirm').val() == "") {
            alert("패스워드를 다시 입력해주세요");
            $('#passConfirm').focus();
            return false;
        }
		
	});
	
	
	// 이메일 인증
	
	
	// 패스워드 확인 -> 아직 안됨
	var pass = $('#pass').val();
	var passConfirm = $('#passConfirm').val();
    
	if(pass != passConfirm) {
		alert("불일치");
		$('#passConfirm').focus();
		return false;
	} 
	
		
		
		
	
});

</script>

</head>
<body>
    <h2>회원가입</h2>
    <h1>회원가입이시다!</h1>
    <h1>진짜로!</h1>
    <form action="MemberJoinPro.me" method="post" name="join_insert">
        <fieldset>
            <legend>이메일</legend>
            <input type="text" id="email" name="email">
        </fieldset>
        <fieldset>
            <legend>이름</legend>
            <input type="text" id="name" name="name">
        </fieldset>
        <fieldset>
            <legend>패스워드</legend>
            <input type="password" id="pass" name="pass">
        </fieldset>
        <fieldset>
            <legend>패스워드 확인</legend>
            <input type="password" id="passConfirm" name="passConfirm">
        </fieldset>
        
        <button type="submit">가입</button>
        <button type="reset">취소</button>
        
        
    </form>

</body>
</html>