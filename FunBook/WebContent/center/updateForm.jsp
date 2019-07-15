<%@page import="Board.BoardBean"%>
<%@page import="Board.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="../css/default.css" rel="stylesheet" type="text/css">
<link href="../css/subpage.css" rel="stylesheet" type="text/css">
<!--[if lt IE 9]>
<script src="http://ie7-js.googlecode.com/svn/version/2.1(beta4)/IE9.js" type="text/javascript"></script>
<script src="http://ie7-js.googlecode.com/svn/version/2.1(beta4)/ie7-squish.js" type="text/javascript"></script>
<script src="http://html5shim.googlecode.com/svn/trunk/html5.js" type="text/javascript"></script>
<![endif]-->
<!--[if IE 6]>
 <script src="../script/DD_belatedPNG_0.0.8a.js"></script>
 <script>
   /* EXAMPLE */
   DD_belatedPNG.fix('#wrap');
   DD_belatedPNG.fix('#main_img');   

 </script>
 <![endif]-->
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
String id = (String)session.getAttribute("id");
//세션값 없으면 로그임 페이지로 넘어가기

if(id==null){ //세션값 없으면 로그인 창으로 이동
	response.sendRedirect("../member/login.jsp");
}

//pageNum & num 파라미터 값  가져오기
int num = Integer.parseInt(request.getParameter("num"));
String pageNum = request.getParameter("pageNum");

BoardDAO bdao = new BoardDAO();
BoardBean bb = bdao.getboard(num);
%>
<!-- 게시판 -->
<article>
<h1>Notice Update</h1>
<form action="updatePro.jsp?pageNum=<%=pageNum %>" method="post" name="fr" enctype="multipart/form-data">
<input type = "hidden" name="num" value="<%=num %>">
<input type="hidden" name="ofile" value="<%=bb.getFile()%>">
<table id="notice">
<tr><td class="twrite">글쓴이</td><td><input type="text" name="name" value="<%=id %>" readonly ></td></tr>
<tr><td class="twrite">비밀번호</td><td><input type="password" name = "pass"></td></tr>
<tr><td class="twrite">제목</td><td><input type="text" name="subject" value="<%=bb.getSubject() %>"></td></tr>
<tr><td class="twrite">첨부파일</td><td><img src="../upload/<%=bb.getFile() %>" width="200"><br><input type="file" name="file" ></td></tr>

<tr><td class="twrite">글내용</td>
<td class="twrite"><textarea name="content" rows="20" cols="40"><%=bb.getContent() %></textarea></td></tr>
</table>
<div id="table_search">
<input type="submit" value="글쓰기" class="btn" >
</div>
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