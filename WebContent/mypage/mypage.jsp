<%@page import="member.dao.MemberDao"%>
<%@page import="mypage.dao.MypageDao"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.io.Console"%>
<%@page import="member.vo.MemberBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    
<!DOCTYPE html>
<html>
<%
request.setCharacterEncoding("UTF-8");
String email = (String) session.getAttribute("email");
String name = (String) session.getAttribute("name");
String pass = (String) session.getAttribute("pass");

%>
<head>
<meta charset="UTF-8">
<title>Mypage</title>
<link href="${pageContext.request.contextPath}/css/default.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath}/css/memberLogin.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath}/css/memberJoin.css" rel="stylesheet" type="text/css">
<script src="${pageContext.request.contextPath}/js/jquery-3.5.1.js"></script>
<script type="text/javascript">

$(document).ready(function(){
	
	$('#dupName').click(function(){
		
		var name = $('#name').val();
		console.log(name);
		
			if(name==""){
				$("#check_name").text('이름을 입력해주세요');
				$('.check_font').css('color', 'gray');
				$("#check_name").attr("disabled", true);
				$('#name').focus();
				return false;
				
			}else {
				$.ajax("dupName.me",{
					data:{name:name},
					success:function(rdata){
						if(rdata=="이름 중복"){
							 alert("중복된 이름 입니다.");
							 $('#name').focus();
							 $('.confirm').eq(0).val("N");
							
						}
						if(rdata=="사용가능 이름"){
							 alert("사용 가능한 이름 입니다.");
							$('.confirm').eq(0).val("Y");
						}
						
					}
					if(rdata=="사용가능 이름"){
						 alert("사용 가능한 이름 입니다.");
						$('.confirm').eq(0).val("Y");
					}
					
					$('#name').html(rdata);
					$('#pass').focus();
				}
			});
		}
		
	});
	
	
	// 패스워드 정규식 & 보안강도 표시
	$('#pass').keyup(function(){
		
		$('#check_pass').html('');
		
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
			special = specialReg.test(pw);
			
			if(lower&&upper&&num&&special){
				$('#pass_msg').removeClass();
				$('#pass_msg').addClass('강함');
				$('#pass_msg').html("<div id='box1'></div><div id='box2'></div><div id='box3'></div><div id='box4'></div><div id='box5'>강함</div>");
                $('#regPass').html('사용 가능');
 				$('.confirm').eq(1).val("Y");
			
			}else if((lower||upper)&&(num||secial)){
				$('#pass_msg').removeClass();
				$('#pass_msg').addClass('중간');
				$('#pass_msg').html("<div id='box1'></div><div id='box2'></div><div id='box3'></div><div id='box4'></div><div id='box5'>중간</div>");
                $('#regPass').html('사용 가능');
 				$('.confirm').eq(1).val("Y");	
 				
			}else { // 한가지 조합으로만 8글자 입력했을 경우
				$('#pass_msg').removeClass();
				$('#pass_msg').addClass('약함');
				$('#pass_msg').html("<div id='box1'></div><div id='box2'></div><div id='box3'></div><div id='box4'></div><div id='box5'>약함</div>");
	            $('#regPass').html('비밀번호는 숫자와 영어[대문자or소문자or특수문자(!,@)]를 포함한 8~15자 입니다');
	            $('.confirm').eq(1).val("N");
			}
			
	 	} else {
	       	$('#pass_msg').removeClass();
	       	$('#pass_msg').addClass('짧음');
	        $('#pass_msg').html("<div id='box1'></div><div id='box2'></div><div id='box3'></div><div id='box4'></div><div id='box5'>짧음</div>");
            $('#regPass').html('비밀번호는 숫자와 영어[대문자or소문자or특수문자(!,@)]를 포함한 8~15자 입니다');
            $('.confirm').eq(1).val("N");
            
			if (pw.length==0) {
				$('#pass_msg').hide();
				$('#regPass').hide();
				
	        }else {
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
	
	$('#name').keyup(function() {
        if($('#name').val() == '') {
            $('#check_name').show();
        }else {
            $('#check_name').hide();
        }
            
    });
	
	$('#passConfirm').keyup(function() {
        if($('#pass').val() != $('#passConfirm').val()) {
            $('#check_passConfirm').html('비밀번호가 일치하지 않습니다');
            $('.check_font').css('color','red');
        }else {
            $('#check_passConfirm').html('비밀번호가 일치합니다');
            $('.check_font').css('color','green');
        }
        
        if($('#passConfirm').val() == '') {
            $('#check_passConfirm').hide();
        }else {
            $('#check_passConfirm').show();
        }
            
    });
	
	// 입력란
	$('.update_fr').submit(function(){
		
		if($('#name').val()==""){
            $('#check_name').text('이름을 입력해주세요');
            $('.check_font').css('color', 'gray');
            $("#check_name").attr("disabled", true);
            $('#name').focus();
            return false;
        } else {
            $("#check_name").hide();
        }
		if($('#pass').val()==""){
			$('#check_pass').text('비밀번호를 입력해주세요');
            $('.check_font').css('color', 'gray');
            $("#check_pass").attr("disabled", true);
            $('#pass').focus();
            return false;
        } else {
            $("#check_pass").hide();
        }
		if($('.confirm').eq(0).val() =="Y"==false){
			alert("이름 중복 체크를 해주세요.");
			$('#name').focus();
			return false;
		}
		if($('.confirm').eq(1).val() =="Y"==false){
			alert("패스워드 설정에 문제가 있습니다.");
			$('#pass').focus();
			return false;
		}
		if($('#pass').val() != $('#passConfirm').val()) {
       	 	$('#check_passConfirm').text('비밀번호를 확인해주세요');
            $('#check_passConfirm').focus();
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
    <div class="joinAll">
        <div class="loginLogin">
           <span class="loginSpan">회원정보 수정</span>
		   <a class="loginOther" href="javascript:location.reload()">취소</a>
		</div>
	    <form action="MemberUpdatePro.me" method="post" id="update_fr" class="update_fr">
	       <div>
               <input type="email" name="email" id="email" value="<%=email %>" readonly class="joinEmail">
           </div>
           <div>
               <input type="text" name="name" id="name" value="<%=name %>" class="joinEmail">
               <div class="check_font" id="check_name"></div>
               <button type="button" id="dupName" class="joinCheck"> 이름 중복 체크 </button>
           </div>
           <div>
               <input type="password" name="pass" id="pass" maxlength="15" placeholder="비밀번호" class="joinPass">
               <div class="check_font" id="check_pass"></div>
               <div id="pass_msg"></div>
               <div id="regPass" class="msg"></div>
           </div> 
           <div>
               <input type="password" name="passConfirm" id="passConfirm" maxlength="15" placeholder="비밀번호 확인" class="joinPass">
               <div class="check_font" id="check_passConfirm"></div>
           </div>
        
		   <input type="submit" value="회원정보 수정" class="loginSubmit">
        
         </form>
	
		 <input type="hidden" class="confirm">
		 <input type="hidden" class="confirm">

    </div>
    
</body>
</html>