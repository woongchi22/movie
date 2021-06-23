
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입</title>

<script src="${pageContext.request.contextPath}/js/jquery-3.5.1.js">

</script>
<script type="text/javascript" >

$(document).ready(function() {
	
	//회원가입 이메일 중복 확인
	$('#dupEmail').click(function(){
		var email = $('#email').val();
		console.log("성공");

		if(email==""){
			$('#check_email').text('이메일을 입력해주세요');
 			$('.check_font').css({'color':'gray','font-size':'8px'});
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
            $('#email').focus();
            return false;
	    }else{
	    	$("#check_email").hide();
	    }
		if($('#name').val() == "") {
			$('#check_name').text('이름을 입력해주세요');
			$('.check_font').css('color','gray');
			$('#name').focus();
			return false;
		}else{
	    	$("#check_name").hide();
	    }
		if($('#pass').val() == "") {
			$('#check_pass').text('패스워드를 입력해주세요');
			$('#check_font').css('color','gray','size','7px');
			$("#check_pass").attr("disabled", true);			
            $('#pass').focus();
            return false;
	    }else{
	    	$("#check_pass").hide();
	    }
		if($('#passConfirm').val() == "") {
           $('#check_passConfirm').text('패스워드를 확인해주세요');
           $('#check_font').css('color','gray');
			$("#check_passConfirm").attr("disabled", true);			
            $('#passConfirm').focus();
            return false;
        }
		if ($('#passConfirm').val() != $('#pass').val()) {
			$('#check_passConfirm').text('패스워드가 일치하지 않습니다');
			 $('#check_font').css('color','gray');
				$("#check_email").attr("disabled", true);			
	            $('#passConfirm').focus();
	            return false;
		}else{
	    	$("#check_passConfirm").hide();
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
		
		if(length){
			
			upper = upperReg.test(pw);
			lower = lowerReg.test(pw);
			num = numReg.test(pw);
			sepcia = specialReg.test(pw);
			
			if(lower&&upper&&num&&special){
				console.log("콘솔~~ ").val();
				$('#pass_msg').removeClass();
				$('#pass_msg').addClass('강함');
				$('#pass_msg').html("<div id='box1'></div><div id='box2'></div><div id='box3'></div><div id='box4'></div> 강함");
				$('#regPass').html('사용 가능');
 				$('.confirm').eq(1).val("Y");
			
			
			}else if((lower||upper)&&(num||secial)){
				$('#pass_msg').removeClass();
				$('#pass_msg').addClass('중간');
				$('#pass_msg').html("<div id='box1'></div><div id='box2'></div><div id='box3'></div><div id='box4'></div> 중간");
				$('#regPass').html('사용 가능');
 				$('.confirm').eq(1).val("Y");	
			}else { // 한가지 조합으로만 8글자 입력했을 경우
				$('#pass_msg').removeClass();
				$('#pass_msg').addClass('약함');
				$('#pass_msg').html("<div id='box1'></div><div id='box2'></div><div id='box3'></div><div id='box4'></div> 약함");
				$('#regPass').html('비밀번호는 8~15자이며,\n숫자/대문자/소문자/특수문자(!,@)를 포함해야 합니다.');
				 $('.confirm').eq(1).val("N");
			}
			
		} else {
        	$('#pass_msg').removeClass();
        	$('#pass_msg').addClass('짧음');
	        $('#pass_msg').html("<div id='box1'></div><div id='box2'></div><div id='box3'></div><div id='box4'></div> 짧음");
	        $('#regPass').html('비밀번호는 8~15자이며,\n숫자/대문자/소문자/특수문자(!,@)를 포함해야 합니다.');
	        $('.confirm').eq(1).val("N");
			if (pw.length==0) {
					$('#pass_msg').hide();
					$('#regPass').hide();
	        } else {
	        	$('#pass_msg').show();
	        	$('#regPass').show();
	        }
		}
        
		if(/(\w)\1\1\1/.test(pw)) {
			$('#regPass').html('같은 문자를 4번 이상 사용할 수 없습니다.');
			 $('.confirm').eq(1).val("N");
		}
		if(pw.search(/\s/) != -1) {
			$('#regPass').html('비밀번호는 공백 없이 입력해주세요.');
			$('.confirm').eq(1).val("N");
		}
    
  });

	
	
	// 이메일 인증
	
	
		
});
	
	

</script>

</head>
<body>
    <h2>회원가입</h2>
    <form action="MemberJoinPro.me" method="post" id="join_insert">
        <fieldset>
            <legend>이메일</legend>
            <input type="email" id="email" name="email">
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
             <div id= "pass_msg"></div>
             <div id="regPass"></div>
        </fieldset>
        <fieldset>
            <legend>패스워드 확인</legend>
            <input type="password" id="passConfirm" name="passConfirm">
             <div class = check_font id="check_passConfirm"></div>
        </fieldset>
        
        <input type="submit" value="가입" > 
        <input type="button" value="취소" onclick="history.back()">
        
    </form>


  <input type="hidden" class="confirm">
  <input type="hidden" class="confirm">
  <input type="hidden" class="confirm">
  <input type="hidden" class="confirm">

  <link href="${pageContext.request.contextPath}/css/memberJoin.css" rel="stylesheet" type="text/css">


 
</body>
</html>