<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("UTF-8");
String pass = (String)session.getAttribute("pass");
String name = (String)session.getAttribute("name");


%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>비밀번호 찾기</title>

<script src="${pageContext.request.contextPath}/js/jquery-3.5.1.js"></script>
<script type="text/javascript">

$(document).ready(function() {
	
	// 비밀번호 찾기 입력란
	$('#findPass').submit(function() {
		
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
        
	});
	   
	
});



</script>
</head>
<body>
<jsp:include page="/inc/top.jsp"/>
    <h2>비밀번호 찾기</h2>
    <form action="ForgetPassPro.me" method="post" id="findPass">
        <fieldset>
            <legend>이메일</legend>
            <input type="text" name="email" id="email">
            <div class = check_font id="check_email"></div>
        </fieldset>
        <fieldset>
            <legend>이름</legend>
	        <input type="text" name="name" id="name">
            <div class = check_font id="check_name"></div>
        </fieldset>
        
	    
<%-- 	    <%if(pass != null) {%> --%>
<%-- 	       <b><%=name %></b> 님의 비밀번호 : <%=pass %><br>  --%>
<!-- 	       <a href="MemberLoginForm.me">로그인 하러 가기</a> -->
<%-- 	    <%} %><br> --%>
	    
	    <input type="submit" value="찾기" id="find">
	    <input type="button" value="취소" onclick="history.back()">
    </form>
    

</body>
</html>