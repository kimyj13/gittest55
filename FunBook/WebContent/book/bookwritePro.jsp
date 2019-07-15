<%@page import="Book.BookDAO"%>
<%@page import="Book.BookBean"%>
<%@page import="java.sql.Timestamp"%>
<%@page import="java.sql.Date"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
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
// request.setCharacterEncoding("utf-8");

String uploadPath = request.getRealPath("/upload");
System.out.println("업로드 폴더 경로 : " + uploadPath);
int Maxsize = 10*1024*1024;

MultipartRequest mr =
new MultipartRequest(request, uploadPath, Maxsize,"utf-8", new DefaultFileRenamePolicy());


String bname = mr.getParameter("bname");
String wname = mr.getParameter("wname");
String bdate = mr.getParameter("bdate");
String bnum = mr.getParameter("bnum");
String bfile  = mr.getFilesystemName("bfile");
String content = mr.getParameter("content");

// out.println(bname);
// out.println(wname);
// out.println(bdate);
// out.println(bnum);
// out.println(bfile);
// out.println(content);

BookBean bb = new BookBean();
bb.setBnum(bnum);
bb.setBname(bname);
bb.setWname(wname);
bb.setBdate(bdate);
bb.setBfile(bfile);
bb.setContent(content);



BookDAO bdao = new BookDAO();
bdao.insertbook(bb);

// BoardBean bb = new BoardBean();



// BoardDAO bdao = new BoardDAO();
// bdao.insertBoard(bb);

response.sendRedirect("booknotice.jsp");

%>
</body>
</html>