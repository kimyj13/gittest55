<%@page import="Board.fBoardDAO"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
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

String uploadPath = request.getRealPath("/upload"); //물리적 경로
System.out.println("업로드 폴더 경로 : " + uploadPath);
int Maxsize = 5*1024*1024; //업로드 파일 크기 제한

MultipartRequest mr =
new MultipartRequest(request, uploadPath, Maxsize,"utf-8", new DefaultFileRenamePolicy());
//객체 생성 -> 파일 업로드// mr에 정보저장

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

fBoardDAO bdao = new fBoardDAO();
bdao.insertBoard(bb);

response.sendRedirect("fnotice.jsp");

%>
</body>
</html>