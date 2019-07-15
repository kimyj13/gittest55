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
// request.setCharacterEncoding("utf-8"); //한글처리
String uploadPath = request.getRealPath("/upload");
System.out.println("업로드 폴더 경로 : " + uploadPath);
int Maxsize = 10*1024*1024;

MultipartRequest mr =
new MultipartRequest(request, uploadPath, Maxsize,"utf-8", new DefaultFileRenamePolicy());

int num = Integer.parseInt(mr.getParameter("num"));
String name = mr.getParameter("name");
String pass = mr.getParameter("pass"); 
String subject = mr.getParameter("subject");
String content = mr.getParameter("content");
String ofile=mr.getParameter("ofile");
String file = mr.getFilesystemName("file");

String pageNum = request.getParameter("pageNum");//수정후에 현재 페이지에 머물러 있게끔

BoardBean bb = new BoardBean();

bb.setNum(num);
bb.setName(name);
bb.setPass(pass);
bb.setSubject(subject);
bb.setContent(content);

// out.print("file");
// out.print(file);
// out.print("ofile");
// out.print(ofile);
if(file == null){
bb.setFile(ofile);
}else{
	bb.setFile(file);
}

fBoardDAO bdao = new fBoardDAO();

int check = bdao.numCheck(num, pass);
if(check == 1){
	bdao.updateBoard(bb);
	response.sendRedirect("fcontent.jsp?num="+num+"&pageNum="+pageNum);
}else if(check == 0){
	%>
	<script type="text/javascript">
	alert('비밀번호 틀림');
	history.back();
	</script>
	<%
}
%>
</body>
</html>