
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입</title>
<link href="${pageContext.request.contextPath}/css/default.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath}/css/memberJoin.css" rel="stylesheet" type="text/css">
<script src="${pageContext.request.contextPath}/js/jquery-3.5.1.js"></script>
<script type="text/javascript">

$(document).ready(function() {
   
    //회원가입 이메일 중복 확인
     $('#dupEmail').click(function(){
         var email = $('#email').val();
      // 정규식 판별 변수
		 var regExp = /^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.([a-zA-Z]){2,3}$/i;
		 var checkResult = regExp.test( $("#email").val() );
         console.log("성공");

         if(email==""){
        	 $('#check_email').text('이메일을 입력해주세요.');
             $('.check_font').css('color', 'gray');
//              $("#check_email").attr("disabled", true);           
             return false;
          // 정규식에 위배되는 경우
         }else if(!checkResult){
        	 alert('이메일 양식을 확인해주세요.');
				$('.confirm').eq(0).val("N");
         }else {
         	 
             $.ajax("dupEmail.me",{
                 data:{email:email},
                 success:function(rdata){
                     if(rdata=="사용가능 이메일") {
                         $('.confirm').eq(0).val("Y");
                         alert("사용 가능한 이메일입니다 .");
                     }
                     if(rdata=="이메일 중복"){
                         $('.confirm').eq(0).val("N");
                         alert("중복된 이메일 입니다.");
                     } 
                     $('#email').html(rdata);
                 }
             });
         }
     });
    
     //회원가입 이름 중복 확인
     $('#dupName').click(function(){
         var name = $('#name').val();
         console.log("이름 성공");

         if(name == ""){
             $('#check_name').text('이름을 입력해주세요.');
             $('.check_font').css('color', 'gray');
//              $("#check_name").attr("disabled", true);           
             return false;
         } else {
             $.ajax("dupName.me",{
                 data:{name:name},
                 success:function(rdata){
                     if(rdata=="사용가능 이름") {
                         $('.confirm').eq(2).val("Y");
                         alert("사용 가능한 이름 입니다.");
                     }
                	 if(rdata == "이름 중복"){
                         $('.confirm').eq(2).val("N");
                         alert("중복된 이름 입니다.");
                     } 
                     
                     $('#name').html(rdata);
                 }
             });
         }
     });
     
     
     // 회원가입 입력란
     $('#join_insert').submit(function() {
    	 if($('.confirm').eq(0).val()=="Y"==false){
             alert("이메일 중복체크를 해주세요");
             return false;
         }
         
         if($('.confirm').eq(2).val()=="Y"==false){
             alert("이름 중복체크를 해주세요");
             return false;
         }
         if($('.confirm').eq(1).val()=="Y"==false){
             alert("패스워드 설정에 문제가 있습니다.");
             $('#pass').focus();
             return false;
         }
         
     });
 	// 이메일 체크
     $( function(){
 		$( '#email' ).on("blur keyup", function() {
 			$(this).val( $(this).val().replace( /[^0-9a-zA-Z-_\\@.]/g, '' ) );
 		});
 	})
    
 	// 비밀번호 확인
     $('#passConfirm').keyup(function() {
    	 
         if($('#pass').val() == $('#passConfirm').val()) {
             $('#check_passConfirm').html('비밀번호가 일치합니다');
             $('.check_font').css('color','green');
             $('.confirm').eq(1).val("Y");
         }else {
             $('#check_passConfirm').html('비밀번호가 일치하지 않습니다');
             $('.check_font').css('color','red');
             $('.confirm').eq(1).val("N");
         }if($('#passConfirm').val() == "") {
          $('#check_passConfirm').html('패스워드를 확인해주세요');
          $('#passConfirm').focus();
          $('.confirm').eq(1).val("N");
         }
          
         if($('#passConfirm').val() == '') {
             $('#check_passConfirm').hide();
         }else {
             $('#check_passConfirm').show();
         }
             
     });
     
     $('#email').keyup(function() {
         if($('#email').val() == '') {
             $('#check_email').show();
         } else {
             $('#check_email').hide();
         }
     });
     
     $('#name').keyup(function() {
         if($('#name').val() == '') {
             $('#check_name').show();
         } else {
             $('#check_name').hide();
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
            
	        }else {
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
   
  /// 이메일 체크
	
   
  
   
    
    
   
});
   
   

</script>

</head>
<header>
    <jsp:include page="/inc/top.jsp"/>
</header>
<body>
    <h2>회원가입</h2>
    <form action="MemberJoinPro.me" method="post" id="join_insert">
        <fieldset>
            <legend>이메일</legend>
            <input type="email" id="email" name="email"> <button
                type="button" id="dupEmail"> 이메일 중복체크 </button>
            <!--             <button class = "check_font" id="dupEmail" type="button">이메일 중복체크</button> -->
            <div class="check_font" id="check_email"></div>
        </fieldset>
        <fieldset>
            <legend>이름</legend>
            <input type="text" id="name" name="name"> <button
                type="button" id="dupName"> 이름 중복 체크 </button>
            <div class="check_font" id="check_name"></div>
        </fieldset>
        <fieldset>
            <legend>패스워드</legend>
            <input type="password" id="pass" name="pass">
            <div class="check_font" id="check_pass"></div>
            <div id="pass_msg"></div>
            <div id="regPass"></div>
        </fieldset>
        <fieldset>
            <legend>패스워드 확인</legend>
            <input type="password" id="passConfirm" name="passConfirm">
            <div class="check_font" id="check_passConfirm"></div>
        </fieldset>

        <input type="submit" value="가입"> <input type="button"
            value="취소" onclick="location.href='./'">

    </form>


    <input type="hidden" class="confirm">
    <input type="hidden" class="confirm">
    <input type="hidden" class="confirm">




</body>
</html>