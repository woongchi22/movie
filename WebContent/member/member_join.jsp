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
	$('#join_insert').submit(function() {
		
		if($('#email').val() == "") {
			$('#check_email').text('이메일을 입력해주세요');
			$('.check_font').css('color', 'gray');
			$("#join_insert").attr("disabled", true);			
            $('#email').focus();
            return false;
	    }
		if($('#name').val() == "") {
			$('#check_name').text('이름을 입력해주세요');
			$('.check_font').css('color','gray');
			$("#join_insert").attr("disabled", true);			
			$('#name').focus();
			return false;
		}
		if($('#pass').val() == "") {
			$('#check_pass').text('패스워드를 입력해주세요');
			$('#check_font').css('color','gray','size','7px');
			$("#join_insert").attr("disabled", true);			
            $('#pass').focus();
            return false;
	    }
		if($('#passConfirm').val() == "") {
           $('#check_passConfirm').text('패스워드를 확인해주세요');
           $('#check_font').css('color','gray');
			$("#join_insert").attr("disabled", true);			
            $('#passConfirm').focus();
            return false;
        }
		
		if ($('#passConfirm').val() != $('#pass')) {
			$('#check_passConfirm').text('패스워드가 일치하지 않습니다');
			 $('#check_font').css('color','gray');
				$("#join_insert").attr("disabled", true);			
	            $('#passConfirm').focus();
	            return false;
		}
	});
	
	
	// 이메일 인증
	
	
	// 패스워드 확인 -> 아직 안됨
	var password = $('#pass').val();
	var passwordConfirm = $('#passConfirm').val();
    
	if(password != passwordConfirm) {
		$('#check_passConfirm').text('패스워드가 일치하지 않습니다');
		 $('#check_font').css('color','gray');
		$('#passConfirm').focus();
		return false;
	}
	
		
		
		
	
});

</script>

</head>
<body>
    <h2>회원가입</h2>
    <form action="MemberJoinPro.me" method="post" id="join_insert">
        <fieldset>
            <legend>이메일</legend>
            <input type="text" id="email" name="email">
            <div class = check_font id="check_email"></div>
        </fieldset>
        <fieldset>
            <legend>이름</legend>
            <input type="text" id="name" name="name">
             <div class = check_font id="check_name"></div>
        </fieldset>
        <fieldset>
            <legend>패스워드</legend>
            <input type="password" id="pass" name="pass">
             <div class = check_font id="check_pass"></div>
        </fieldset>
        <fieldset>
            <legend>패스워드 확인</legend>
            <input type="password" id="passConfirm" name="passConfirm">
             <div class = check_font id="check_passConfirm"></div>
        </fieldset>
        
        <input type="submit" value="가입" > 
        <input type="button" value="취소" onclick="history.back()">
        
        
        
        
    </form>
  <!-- 
    <script>
// 아이디 유효성 검사(1 = 중복 / 0 != 중복)
	$("#user_id").blur(function() {
		// id = "id_reg" / name = "userId"
		var user_id = $('#user_id').val();
		$.ajax({
			url : '${pageContext.request.contextPath}/user/idCheck?userId='+ user_id,
			type : 'get',
			success : function(data) {
				console.log("1 = 중복o / 0 = 중복x : "+ data);							
				
				if (data == 1) {
						// 1 : 아이디가 중복되는 문구
						$("#id_check").text("사용중인 아이디입니다 :p");
						$("#id_check").css("color", "red");
						$("#reg_submit").attr("disabled", true);
					} else {
						
						if(idJ.test(user_id)){
							// 0 : 아이디 길이 / 문자열 검사
							$("#id_check").text("");
							$("#reg_submit").attr("disabled", false);
				
						} else if(user_id == ""){
							
							$('#id_check').text('아이디를 입력해주세요 :)');
							$('#id_check').css('color', 'red');
							$("#reg_submit").attr("disabled", true);				
							
						} else {
							
							$('#id_check').text("아이디는 소문자와 숫자 4~12자리만 가능합니다 :) :)");
							$('#id_check').css('color', 'red');
							$("#reg_submit").attr("disabled", true);
						}
						
					}
				}, error : function() {
						console.log("실패");
				}
			});
		});
</script>

 -->

</body>
</html>