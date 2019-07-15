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


String name = mr.getParameter("name");
String pass = mr.getParameter("pass");
String subject = mr.getParameter("subject");
String content = mr.getParameter("content");
String file  = mr.getFilesystemName("file");

BoardBean bb = new BoardBean();

bb.setName(name);
bb.setPass(pass);
bb.setSubject(subject);
bb.setContent(content);
bb.setFile(file);

BoardDAO bdao = new BoardDAO();
bdao.insertBoard(bb);

response.sendRedirect("notice.jsp");

%>
</body>
</html>