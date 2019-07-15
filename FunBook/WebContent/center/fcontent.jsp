<%@page import="Board.fBoardDAO"%>
<%@page import="Board.BoardBean"%>
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

fBoardDAO bdao = new fBoardDAO();
bdao.updateReadcount(num);  //조회수 증가

BoardBean bb = bdao.getboard(num);

String content = bb.getContent();
if(content != null){
	//   \r \n =><br> 바꾸기
	content = content.replace("\r\n", "<br>");
}

%>
<!-- 게시판 -->
<article>
<h1>File Notice Content</h1>

<table id="notice">
<tr><td class="twrite">글번호</td><td><%=bb.getNum() %></td>
<td class="twrite">조회수</td><td align="center"><%=bb.getReadcount() %></td></tr>

<tr><td class="twrite">작성자</td><td align="center"><%=bb.getName() %></td>
<td align="center">작성일</td><td width = "110" align="center"><%=bb.getDate() %></td></tr>

<tr><td   class="twrite">제목</td><td colspan="3"><%=bb.getSubject() %></td></tr>

<!-- 첨부파일 경로 걸어주기 ../upload/ -->
<tr><td  class="twrite" >파일</td><td colspan="3"><a href="../upload/<%=bb.getFile() %>"><%=bb.getFile() %></a>
<a href="file_down.jsp?file_name=<%=bb.getFile()%>"><%=bb.getFile() %></a><br>
</td></tr>
<tr><td height="200" align="center">내용</td><td colspan="3">
<img src="../upload/<%=bb.getFile() %>" width="300"><br><%=content %></td></tr>


</table>
<div id="table_search">
<%
//세션값 가져오기
//세션값이 있으면 세션값과 글의 작성자와 비교 일치하면 글 수정 글 삭제 버튼이 보이기
String id = (String)session.getAttribute("id");
if(id !=null){
if(id.equals(bb.getName()) || id.equals("admin")){
	%>
	<input type="button" value="글수정" class="btn" onclick="location.href='fupdateForm.jsp?num=<%=num%>&pageNum=<%=pageNum%>'">
<input type="button" value="글삭제" class="btn" onclick="location.href='fdeleteForm.jsp?num=<%=num%>&pageNum=<%=pageNum%>'">
<%
}}
%>
<input type="button" value="글목록" class="btn" onclick="location.href='fnotice.jsp?pageNum=<%=pageNum%>'">
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