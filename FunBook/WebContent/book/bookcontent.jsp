<%@page import="java.util.List"%>
<%@page import="Book.BookBean"%>
<%@page import="Book.BookDAO"%>
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
<div id="sub_img"></div>
<!-- 메인이미지 -->

<!-- 왼쪽메뉴 -->
<nav id="sub_menu">
<ul>
<!-- <li><a href="../center/notice.jsp">책 분류</a></li> -->
<li><a href="booknotice.jsp">도 서</a></li>
<li><a href="newbookgnotice.jsp">신간도서</a></li>
<%
String id = (String)session.getAttribute("id");
if(id!=null){
	if(id.equals("admin")){ %>

<li><a href="bookwrite.jsp">쓰기</a></li>
<%
}} %>
</ul>
</ul>
</nav>
<!-- 왼쪽메뉴 -->
<%
int num = Integer.parseInt(request.getParameter("num"));
String pageNum = request.getParameter("pageNum");

BookDAO bdao = new BookDAO();
// bdao.updateReadcount(num);  //조회수 증가

BookBean bb = bdao.getbook(num);

String content = bb.getContent();
if(content != null){
	//   \r \n =><br> 바꾸기
	content = content.replace("\r\n", "<br>");
}

%>
<!-- 게시판 -->
<article>
<h1>Notice Content</h1>

<table id="notice">
<tr><td   class="twrite">제목</td><td colspan="3"><%=bb.getBname() %></td></tr>

<tr><td class="twrite">저자</td><td><%=bb.getWname() %></td>
<td align="center">출간일</td><td width = "110" align="center"><%=bb.getBdate() %></td></tr>
<tr><td height="200" align="center">내용</td><td colspan="3">
<img src="../upload/<%=bb.getBfile() %>" width="300"><br><%=content %></td></tr>
</table>
<div id="table_search">
<input type="button" value="글목록" class="btn" onclick="location.href='booknotice.jsp?pageNum=<%=pageNum%>'">
</div>
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