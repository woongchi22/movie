<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>비밀번호 변경</title>

<script src="${pageContext.request.contextPath}/js/jquery-3.5.1.js"></script>
<script type="text/javascript">

$(document).ready(function() {
    
    // 칸 공백일 시
    $('#newPass').submit(function() {
        if($('#pass').val() == "") {
            alert("비밀번호를 입력하세요");
            $('#pass').focus();
            return false;
        }
        if($('#pass2').val() == "") {
            alert("비밀번호를 다시 입력하세요");
            $('#pass2').focus();
            return false;
        }
    });
    
    
});

</script>
</head>
<body>
<jsp:include page="/inc/top.jsp"/>
    <h2>비밀번호 변경</h2>
    <form action="NewPassPro.me" method="post" id="newPass">
        새 비밀번호 : <input type="password" name="pass" id="pass"><br>
        비밀번호 확인 : <input type="password" name="pass2" id="pass2"><br>
        
        <input type="submit" value="확인" id="submit">
        <input type="button" value="취소" onclick="location.href='MemberLoginForm.me'">
    </form>

</body>
</html>