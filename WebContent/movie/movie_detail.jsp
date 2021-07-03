<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<%
	String nick = (String)session.getAttribute("nick"); 
	String getGrade = (String)request.getAttribute("getGrade"); 
	String movieSeq = (String)request.getParameter("movieSeq");
	String query = request.getParameter("query");
	String returnCmt = (String)request.getAttribute("returnCmt");
	String poster = (String)request.getParameter("image");
	String director=request.getParameter("director");
%>
<title>[what챠] - 영화 <%=query %>의 상세정보</title>
<script type="text/javascript">


</script>
</head>
<body>
<!-- 헤더 -->
	<div style="width:100%;position: sticky !important;top:0;z-index: 100;">
		<jsp:include page="/inc/top.jsp"/>
		<div class="clear"></div>
	</div>
	<!-- 헤더 -->
    
	<!-- main[S] -->
	<section id="main">
	
		<!-- jbMenu[S] -->
		<div class="jbMenu">
			<div class="clear"></div>
			
		</div>
		<!-- jbMenu[E] -->
		    
		<!--     jb-container[S] -->
		<div id="jb-container">
		
			<!-- jbMenu[S] -->
			<div class="jbMenu1">
			<div class="clear"></div>
			
			<div id="Box">
				<div id="head">
				<div id="trailer"></div>
				</div>
			<!-- 	<div id="body"> -->
			<!-- 	<button class="up">▲</button> -->
			<!-- 	<button class="down">▼</button> -->
			<!-- 	</div> -->
				</div>
			</div>
			<!-- jbMenu[E] -->
			
			
			<input type="hidden" id="hashIndex" value="0">
			
			      
			<!--       사이드 레프트 [S] -->
			      <div id="jb-sidebar-left">
							<div class="poster" style="margin-left:55px;"></div>
							
			<!--       사이드 센터[S] -->
			      <div id="jb-content">
					<dl class="info"></dl>
			      </div>
			<!--       사이드 센터[E] -->
			
			<!-- 사이드 라이트[S] -->
			      <div id="jb-sidebar-right">
			      	<p><b>배역</b></p>
			        <dl class="staff">
					</dl>
			      </div>
			<!--       사이드 라이트[E] -->
			
			
			<!-- 푸터(스틸컷)[S] -->
			      <div id="jb-footer">
			      <p>스틸컷</p>
			        <div class="posters"></div>
			      </div>
			<!-- 푸터(스틸컷)[E] -->
			      
			<!-- 푸터(이 감독의 다른 영화)[S] -->      
			      <div id="jb-footer2">
			      <p class="directorP"></p>
			        <div class="directorsMovie"></div>
			      </div>
			<!-- 푸터(이 감독의 다른 영화)[E] -->       
			    
			    
			<input type="hidden" id="movieSeq" value="<%=movieSeq%>">
			<input type="hidden" id="query" value="<%=query%>">
			<input type="hidden" id ="nick" class="nick" value=<%=nick %>>
			<input type="hidden" id="getGrade" value="<%=getGrade %>">
			<input type="hidden" id="returnCmt" value="<%=returnCmt %>">
		
		    </div>
		<!-- #jb-container[E] -->
	</section>
</body>
</html>