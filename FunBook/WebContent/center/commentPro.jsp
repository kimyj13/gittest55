<%@page import="Board.BoardDAO"%>
<%@page import="Board.BoardBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
request.setCharacterEncoding("utf-8");
int num =Integer.parseInt(request.getParameter("num"));
String id = (String)session.getAttribute("id");
String comment  = request.getParameter("comment");

BoardBean bb = new BoardBean();
bb.setNum(num);
bb.setName(id);
bb.setComment(comment);


// out.println(comment);
BoardDAO bdao = new BoardDAO();

bdao.commentBoard(bb);


String pageNum = request.getParameter("pageNum");
response.sendRedirect("content.jsp?num="+num+"&pageNum="+pageNum);
// response.sendRedirect("content2.jsp");
%>
</body>
</html>