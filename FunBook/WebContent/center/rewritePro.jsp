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

int num = Integer.parseInt(mr.getParameter("num"));
int re_ref = Integer.parseInt(mr.getParameter("re_ref"));
int re_lev = Integer.parseInt(mr.getParameter("re_lev"));
int re_seq = Integer.parseInt(mr.getParameter("re_seq"));


BoardBean bb = new BoardBean();

bb.setNum(num);
bb.setRe_ref(re_ref);//그룹번호(답글달 원글 번호)
bb.setRe_lev(re_lev);//들여쓰기
bb.setRe_seq(re_seq);//순서값

bb.setName(name);
bb.setPass(pass);
bb.setSubject(subject);
bb.setContent(content);
bb.setFile(file);

BoardDAO bdao = new BoardDAO();
bdao.reInsertBoard(bb);

response.sendRedirect("notice.jsp");

%>
</body>
</html>