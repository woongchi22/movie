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
<title>My collection</title>
<link href="${pageContext.request.contextPath}/css/default.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath}/css/memberLogin.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath}/css/memberJoin.css" rel="stylesheet" type="text/css">
<script src="${pageContext.request.contextPath}/js/jquery-3.5.1.js"></script>
<script type="text/javascript">
$(document).ready(function() {

	$('#showAddCollection').click(function() {
		$('#showCollection').show();
		$('#showAddCollection').hide();
	});
	
	$('#addMov').click(function(){
		
		window.open("CollectionSearch.mo",
				"open the window",
				"toolbar=no, width=1000, height=850, top=150, left=150");
	});	



	
	
});//ready


</script>
</head>

<header>
    <jsp:include page="/inc/top.jsp"/>
</header>
<body>

<div class="sidebar">
	<ul>
		<li class="active"><a href="Mypage.mp">개인정보수정</a></li>
		<li><a href="BoardMyReviewList.bo?name=<%=name %>" data-nav-section="review">내가 쓴 리뷰</a></li>
		<li><a href="MypageCollection.mp?name=<%=name%>">컬렉션</a></li>
	</ul>
	
</div>

<div style="float: right;">
	<input type="button" value="컬렉션 추가" id="showAddCollection">
	
	<div style="display: none;" id="showCollection">
		<form action ="MypageCollectionUpdate.mp" method="post">
			컬렉션 이름<br> <input type ="text" id="collection_name"> <br>
			컬렉션 내용 <textarea id="collection_content" class="textarea"></textarea>
			<input type ="button" id="addMov" value="작품추가">
			<input type ="button" id="addCollection" value="생성">
		</form>	
	</div>



</div>



</body>
</html>