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
<script src="${pageContext.request.contextPath}/js/jquery-3.5.1.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	$('#dupName').click(function(){
		var name = $('#name').val();
		console.log(name);
		
		if(name==""){
			$("#check_name").text('이름을 입력해주세요');
			$('.check_font').css({'color':'gray','font-size':'8px'});
			$("#check_name").attr("disabled", true);
			return false;
		} else {
			$.ajax("dupName.me",{
				data:{name:name},
				success:function(rdata){
					if(rdata=="이름 중복"){
						$("#check_name").text('이미 사용중인 이름 입니다');
						$('.confirm').eq(0).val("N");
						
					}
					if(rdata=="사용가능 이름"){
						$("#check_name").text('사용 가능한 이름 입니다');
						$('.confirm').eq(0).val("Y");
					}
					$('#name').html(rdata);
				}
			});
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
// 				console.log("콘솔~~ ").val();
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
	
	$('.update_fr').submit(function(){
		
		if($('#pass').val()==""){
			alert("비밀번호를 입력하세요");
			$('#pass').focus();
			return false;
		}
		if($('.confirm').eq(0).val()=="Y"==false){
			alert("닉네임 설정에 문제가 있습니다.");
			$('#certificationNum_email').focus();
			return false;
		}
		if($('.confirm').eq(1).val()=="Y"==false){
			alert("패스워드 설정에 문제가 있습니다.");
			$('#pass').focus();
			return false;
		}
		
	});	
	
});

</script>
</head>
<body>
<jsp:include page="/inc/top.jsp"/>
	<fieldset>
	<legend>회원 정보 수정</legend>
	<form action="MemberUpdatePro.me" method="post" id="update_fr" class="update_fr">
		<fieldset>
		<legend>이메일</legend>
		<input type ="text" id="email" name="email" value ="<%=email%>"  readonly>
		</fieldset>
		
		<fieldset>
		<legend>이름</legend>
		<input type="text" id="name" name="name" value ="<%=name%>"  >
		<input type="button" value="닉네임 중복 체크" name="dupName" id="dupName">
		<div id ="check_name"></div>
		</fieldset>	
	
	
		<fieldset>
		<legend>패스워드</legend>
		<input type="password" id="pass" name="pass" maxlength="15" >
		<div id ="pass_msg"></div>
		<div id ="regPass"></div>
		</fieldset>
	
		<input type="submit" value="회원 정보 수정">
		<input type="reset" value="취소">
	</form>
	
	  <input type="hidden" class="confirm">
	  <input type="hidden" class="confirm">
	  
	 
	</fieldset>


</body>
</html>