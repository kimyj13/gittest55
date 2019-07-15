<%@page import="Board.fBoardDAO"%>
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
int num = Integer.parseInt(request.getParameter("num"));
String pageNum = request.getParameter("pageNum");
String pass = request.getParameter("pass");

BoardBean bb = new BoardBean();
bb.setNum(num);
bb.setPass(pass);

fBoardDAO bdao = new fBoardDAO();
int check = bdao.numCheck(num, pass);
if(check == 1){
	bdao.deleteBoard(bb);
// 	response.sendRedirect("content.jsp");
	%>
	<script type="text/javascript">
	location.href="fnotice.jsp?pageNum=<%=pageNum%>";
	</script>
	<%
}else if(check==0){
	%>
	<script type="text/javascript">
	alert('비밀번호가 틀립니다');
	history.back();
	</script>
	<%
}



%>
</body>
</html>