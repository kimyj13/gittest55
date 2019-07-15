<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="../css/default.css" rel="stylesheet" type="text/css">
<link href="../css/subpage.css" rel="stylesheet" type="text/css">
</head>
<body>
<div id="wrap">
<!-- 헤더들어가는 곳 -->
<jsp:include page="../inc/top.jsp" />
<!-- 헤더들어가는 곳 -->

<!-- 본문들어가는 곳 -->
<!-- 메인이미지 -->
<div id="sub_img_center"></div>
<!-- 메인이미지 -->

<!-- 왼쪽메뉴 -->
<nav id="sub_menu">
<ul>
<li><a href="../center/notice.jsp">게시판</a></li>
<li><a href="../center/fnotice.jsp">자료실</a></li>
</ul>
</nav>
<!-- 왼쪽메뉴 -->
<%
int num = Integer.parseInt(request.getParameter("num"));
String pageNum = request.getParameter("pageNum");
%>

<h2>게시판 글삭제</h2>
<form action="deletePro.jsp" method="post">
<input type="hidden" name = "num" value="<%=num %>">
<input type="hidden" name = "pageNum" value="<%=pageNum %>">
<table id="deleteForm">
<tr><td class="twrite">비밀번호</td><td><input type="password" name = "pass"></td></tr>
<tr><td colspan="2" class="twrite"><input type="submit" value="글삭제"></td></tr>
</table>
</form>
<div class="clear"></div>
<div id="page_control">
</div>
</article>
<!-- 게시판 -->
<!-- 본문들어가는 곳 -->
<div class="clear"></div>
<!-- 푸터들어가는 곳 -->
<jsp:include page="../inc/bottom.jsp" />
<!-- 푸터들어가는 곳 -->
</div>




</body>
</html>