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
	
	// 칸 공백일 시
	$('#findPass').submit(function() {
		if($('#email').val() == "") {
			alert("이메일을 입력하세요");
			return false;
		}
		if($('#name').val() == "") {
			alert("이름을 입력하세요");
			return false;
		}
	});
	
	
});



</script>
</head>
<body>
<jsp:include page="/inc/top.jsp"/>
    <h2>비밀번호 찾기</h2>
    <form action="ForgetPassPro.me" method="post" id="findPass">
	    이메일 : <input type="text" name="email" id="email"><br>
	    이름 : <input type="text" name="name" id="name"><br>
	    
	    <%if(pass != null) {%>
	       <b><%=name %></b> 님의 비밀번호 : <%=pass %><br> 
	       <a href="MemberLoginForm.me">로그인 하러 가기</a>
	    <%} %><br>
	    
	    <input type="submit" value="찾기" id="find">
	    <input type="button" value="취소" onclick="history.back()">
    </form>
    

</body>
</html>