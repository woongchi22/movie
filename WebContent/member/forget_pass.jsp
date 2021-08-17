<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>비밀번호 찾기</title>
<link href="${pageContext.request.contextPath}/css/default.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath}/css/memberLogin.css" rel="stylesheet" type="text/css">
<script src="${pageContext.request.contextPath}/js/jquery-3.5.1.js"></script>
<script type="text/javascript">

$(document).ready(function() {
	
	// 비밀번호 찾기 입력란
	$('#findPass').submit(function() {
		
		if($('#email').val() == "") {
			$('#check_email').text('이메일을 입력해주세요');
            $('.check_font').css('color', 'red');
            $('#email').focus();
            return false;
        }else{
            $("#check_email").hide();
        }
		
        if($('#name').val() == "") {
            $('#check_name').text('이름을 입력해주세요');
            $('.check_font').css('color','red');
            $('#name').focus();
            return false;
        }else{
            $("#check_name").hide();
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
	   
	
});



</script>
</head>
<header>
	<jsp:include page="/inc/top.jsp"/>
</header>

<body>
	<div class="loginAll">
		<div class="loginLogin">
            <span class="loginSpan">비밀번호 찾기</span>
            <a class="loginOther" href="MemberLoginForm.me">돌아가기</a>
        </div>
        <form action="ForgetPassPro.me" method="post" id="findPass">
	        <div>
                <input type="text" name="email" id="email" placeholder="이메일(xxx@xxx.xxx)" class="loginEmail">
                <div class="check_font" id="check_email"></div>
            </div>
            <div>
                <input type="text" name="name" id="name" placeholder="이름" class="loginPass">
                <div class="check_font" id="check_name"></div>
            </div>
	    
<%-- 	    <%if(pass != null) {%> --%>
<%-- 	       <b><%=name %></b> 님의 비밀번호 : <%=pass %><br>  --%>
<!-- 	       <a href="MemberLoginForm.me">로그인 하러 가기</a> -->
<%-- 	    <%} %><br> --%>
	    
		    <input type="submit" value="찾기" id="find" class="loginSubmit">
        </form>
		
	</div>
	
</body>
</html>