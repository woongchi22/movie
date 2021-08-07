<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<%
request.setCharacterEncoding("UTF-8");
String name = (String)session.getAttribute("name");

%>
<head>
<meta charset="UTF-8">
<title>My collection</title>
<!-- <link rel="stylesheet" type="text/css" href="slick/slick.css"/> -->
<!-- <link rel="stylesheet" type="text/css" href="slick/slick-theme.css"/>    -->
<!-- <script type="text/javascript" src="slick/slick.min.js"></script> -->
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
		<form action ="MypageCollectionCreate.mp" method="post">
			컬렉션 이름<br> <input type ="text" name="subject"id="subject"> <br>
			컬렉션 내용 <textarea name="content"id="content" class="textarea"></textarea>
			<input type ="button" id="addMov" value="작품추가">
			<div id="movies">
			</div>
			<input type="submit" value="생성" id="submit">		
		</form>	
	</div>

<h2><%=name %> 님의 컬렉션 목록</h2>


</div>

<input type="hidden" id="name" name="name" value="<%=name %>">

</body>
</html>