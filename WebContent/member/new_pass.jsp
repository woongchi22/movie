<%@page import="member.vo.MemberBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
MemberBean mb = (MemberBean)request.getAttribute("mb");
String name = (String)session.getAttribute("name");

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>비밀번호 변경</title>
<link href="${pageContext.request.contextPath}/css/default.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath}/css/memberLogin.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath}/css/memberJoin.css" rel="stylesheet" type="text/css">
<script src="${pageContext.request.contextPath}/js/jquery-3.5.1.js"></script>

<script type="text/javascript">
$(document).ready(function() {
	
    // 패스워드 정규식 & 보안강도 표시
    $('#pass').keyup(function(){
    	
    	$('#check_pass').html('');
    	
        var pw = $('#pass').val();
        
        var lengthReg = /(?=.{8,15})/; // 8~15자리
        var upperReg = /[A-Z]/; // A~Z
        var lowerReg = /[a-z]/; // a~z
        var numReg = /[0-9]/; // 0-9
        var specialReg = /[!@]/; // !,@
        
        var length = lengthReg.test(pw)
        var upper = null;
        var lower = null;
        var num = null;
        var special = null;
        
        if(length){
            lower = lowerReg.test(pw);
            upper = upperReg.test(pw);
            num = numReg.test(pw);
            special = specialReg.test(pw);
            
            if(lower && upper && num && special){
                $('#pass_msg').removeClass();
                $('#pass_msg').addClass('강함');
                $('#pass_msg').html("<div id='box1'></div><div id='box2'></div><div id='box3'></div><div id='box4'></div><div id='box5'>강함</div>");
                $('#regPass').html('사용 가능');
                $('.confirm').eq(1).val("Y");
            
            } else if ((lower || upper) && (num || secial)){
                $('#pass_msg').removeClass();
                $('#pass_msg').addClass('중간');
                $('#pass_msg').html("<div id='box1'></div><div id='box2'></div><div id='box3'></div><div id='box4'></div><div id='box5'>중간</div>");
                $('#regPass').html('사용 가능');
                $('.confirm').eq(1).val("Y");   

            } else { // 한가지 조합으로만 8글자 입력했을 경우
                $('#pass_msg').removeClass();
                $('#pass_msg').addClass('약함');
                $('#pass_msg').html("<div id='box1'></div><div id='box2'></div><div id='box3'></div><div id='box4'></div><div id='box5'>약함</div>");
                $('#regPass').html('비밀번호는 숫자와 영어[대문자or소문자or특수문자(!,@)]를 포함한 8~15자 입니다');
//                 $('.msg').css({"color":"red","font-size":"12px"});
                $('.confirm').eq(1).val("N");
            }
            
        } else {
            $('#pass_msg').removeClass();
            $('#pass_msg').addClass('짧음');
            $('#pass_msg').html("<div id='box1'></div><div id='box2'></div><div id='box3'></div><div id='box4'></div><div id='box5'>짧음</div>");
            $('#regPass').html('비밀번호는 숫자와 영어[대문자or소문자or특수문자(!,@)]를 포함한 8~15자 입니다');
//             $('.msg').css({"color":"red","font-size":"12px"});
            $('.confirm').eq(1).val("N");
            
            if (pw.length == 0) {
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
    
    $('#pass2').keyup(function() {
        if($('#pass').val() != $('#pass2').val()) {
            $('#check_pass2').html('비밀번호가 일치하지 않습니다');
            $('.check_font').css('color','red');
        } else {
            $('#check_pass2').html('비밀번호가 일치합니다');
            $('.check_font').css('color','green');
        }
        
        if($('#pass2').val() == '') {
            $('#check_pass2').hide();
        } else {
            $('#check_pass2').show();
        }
            
    });
    
    // 비밀번호 변경 입력란
    $('#newPass').submit(function() {
        
        if($('#pass').val() == "") {
            $('#check_pass').text('비밀번호를 입력해주세요');
            $('.check_font').css('color', 'red');
            $("#check_pass").attr("disabled", true);
            $('#pass').focus();
            return false;
        } else {
            $("#check_pass").hide();
        }
        
        if($('#pass2').val() == "") {
            $('#check_pass2').text('비밀번호를 확인해주세요');
            $('.check_font').css('color','red');
            $("#check_pass2").attr("disabled", true);         
            $('#pass2').focus();
            return false;
        }
        
        if($('#pass').val() != $('#pass2').val()) {
            $('#pass2').focus();
            return false;
        }
         
        if($('.confirm').eq(1).val() == "N"){
            alert("비밀번호 설정에 문제가 있습니다.");
            $('#pass').focus();
            return false;
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
            <span class="loginSpan">비밀번호 변경</span>
            <a class="loginOther" href="MemberLoginForm.me">돌아가기</a>
        </div>
        <form action="NewPassPro.me" method="post" id="newPass">
        <input type="hidden" name="name" value=<%=name %>>
            <div>
                <input type="password" name="pass" id="pass" maxlength="15" placeholder="새 비밀번호" class="loginEmail">
                <div class="check_font" id="check_pass"></div>
                <div id="pass_msg"></div>
                <div id="regPass" class="msg"></div>
            </div>
            <div>
                <input type="password" name="pass2" id="pass2" maxlength="15" placeholder="새 비밀번호 확인" class="loginPass">
                <div class="check_font" id="check_pass2"></div>
            </div>
        
	        <input type="submit" value="확인" id="submit" class="loginSubmit">
        </form>
    
	    <input type="hidden" class="confirm">
	    <input type="hidden" class="confirm">
	    <input type="hidden" class="confirm">
	    <input type="hidden" class="confirm">
    
    </div>
    
</body>
</html>