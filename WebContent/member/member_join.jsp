
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
	
	
	//회원가입 이메일 중복 확인
	$('#dupEmail').click(function(){
		var email = $('#email').val();
		console.log("성공");

		if(email==""){
			$('#check_email').text('이메일을 입력해주세요');
 			$('.check_font').css('color', 'gray');
 			$("#check_email").attr("disabled", true);			
			return false;
		} else {
			$.ajax("dupEmail.me",{
				data:{email:email},
				success:function(rdata){
					if(rdata=="이메일 중복"){
						$('.confirm').eq(0).val("N");
					} 
					if(rdata=="사용가능 이메일") {
						$('.confirm').eq(0).val("Y");
					}
					$('#email').html(rdata);
				}
			});
		}
	});
	
	
	
	// 회원가입 입력란
	$('#join_insert').submit(function() {
		
		if($('#email').val() == "") {
			$('#check_email').text('이메일을 입력해주세요');
			$('.check_font').css('color', 'gray');
			$("#check_email").attr("disabled", true);			
            $('#email').focus();
            return false;
	    }
		if($('#name').val() == "") {
			$('#check_name').text('이름을 입력해주세요');
			$('.check_font').css('color','gray');
			$("#check_name").attr("disabled", true);			
			$('#name').focus();
			return false;
		}
		if($('#pass').val() == "") {
			$('#check_pass').text('패스워드를 입력해주세요');
			$('#check_font').css('color','gray','size','7px');
			$("#check_pass").attr("disabled", true);			
            $('#pass').focus();
            return false;
	    }
		if($('#passConfirm').val() == "") {
           $('#check_passConfirm').text('패스워드를 확인해주세요');
           $('#check_font').css('color','gray');
			$("#check_passConfirm").attr("disabled", true);			
            $('#passConfirm').focus();
            return false;
        }
		
		if ($('#passConfirm').val() != $('#pass')) {
			$('#check_passConfirm').text('패스워드가 일치하지 않습니다');
			 $('#check_font').css('color','gray');
				$("#check_email").attr("disabled", true);			
	            $('#passConfirm').focus();
	            return false;
		}
	});
	
	// 패스워드 정규식 & 보안강도 표시
	$('#pass').keyup(function(){
		var pw = $('#pass').val();
		
		var lengthReg = /(?=.{8,15})/; // 8~15자리
		var upperReg = /[A-Z]/;
		var lowerReg = /[a-z]/;
		var numReg = /[0-9]/;
		var specialReg = /[!@]/;
		
		var length = lengthReg.test(pw)
		var upper = null;
		var lower = null;
		var num = null;
		var special = null;
		
		if(lenght){
			
			upper = upperReg.test(pw);
			lower = lowerReg.test(pw);
			num = numReg.test(pw);
			sepcia = specialReg.test(pw);
			
			if(lower&&upper&&num&&special){
				$('#pass_msg').removeClass();
				$('#pass_msg').addClass('강함');
				$('#pass_msg').html("<div id='box1'></div><div id='box2'></div><div id='box3'></div><div id='box4'></div> 강함");
				$('#regPass').html('사용 가능');
 				$('.confirm').eq(1).val("Y");
			
			
			}
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
            <input type="button" value="이메일 중복체크"  id="dupEmail",>
<!--             <button class = "check_font" id="dupEmail" type="button">이메일 중복체크</button> -->
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
             <div class= check_font id="check_pass"></div>
             <div id="regPass"></div>
             <div id= "pass_msg"></div>
        </fieldset>
        <fieldset>
            <legend>패스워드 확인</legend>
            <input type="password" id="passConfirm" name="passConfirm">
             <div class = check_font id="check_passConfirm"></div>
        </fieldset>
        
        <input type="submit" value="가입" > 
        <input type="button" value="취소" onclick="history.back()">
        
        
        
        
    </form>
 
</body>
=======
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
	
	
	//회원가입 이메일 중복 확인
	$('#dupEmail').click(function(){
		var email = $('#email').val();
		console.log("성공");

		if(email==""){
			$('#check_email').text('이메일을 입력해주세요');
 			$('.check_font').css('color', 'gray');
 			$("#check_email").attr("disabled", true);			
			return false;
		} else {
			$.ajax("dupEmail.me",{
				data:{email:email},
				success:function(rdata){
					if(rdata=="이메일 중복"){
						$('.confirm').eq(0).val("N");
					} 
					if(rdata=="사용가능 이메일") {
						$('.confirm').eq(0).val("Y");
					}
					$('#email').html(rdata);
				}
			});
		}
	});
	
	
	
	// 회원가입 입력란
	$('#join_insert').submit(function() {
		if($('#email').val() == "") {
			$('#check_email').text('이메일을 입력해주세요');
			$('.check_font').css('color', 'gray');
			$("#check_email").attr("disabled", true);			
            $('#email').focus();
            return false;
	    }
		if($('#name').val() == "") {
			$('#check_name').text('이름을 입력해주세요');
			$('.check_font').css('color','gray');
			$("#check_name").attr("disabled", true);			
			$('#name').focus();
			return false;
		}
		if($('#pass').val() == "") {
			$('#check_pass').text('패스워드를 입력해주세요');
			$('#check_font').css('color','gray','size','7px');
			$("#check_pass").attr("disabled", true);			
            $('#pass').focus();
            return false;
	    }
		if($('#passConfirm').val() == "") {
           $('#check_passConfirm').text('패스워드를 확인해주세요');
           $('#check_font').css('color','gray');
			$("#check_passConfirm").attr("disabled", true);			
            $('#passConfirm').focus();
            return false;
        }
		
		if ($('#passConfirm').val() != $('#pass')) {
			$('#check_passConfirm').text('패스워드가 일치하지 않습니다');
			 $('#check_font').css('color','gray');
				$("#check_email").attr("disabled", true);			
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
            <input type="button" value="이메일 중복체크"  id="dupEmail",>
<!--             <button class = "check_font" id="dupEmail" type="button">이메일 중복체크</button> -->
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
 
</body>
</html>