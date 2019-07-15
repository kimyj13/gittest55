
<%@page import="member.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript">
function ok() {
	//join.jsp 페이지 id.value = idcheck.jsp 페이지 fid.value
	//window 내장 객체 멤버변수 opener == join.jsp 창을 open()한 페이지
	opener.document.fr.id.value = document.wfr.fid.value;
	window.close();//창닫기
}
</script>
</head>
<body>
<%
String id = request.getParameter("fid");

MemberDAO md = new MemberDAO();
int check = md.idcheck(id);

if(check == 1){
	out.println("아이디 중복");
}else if(check ==0){
out.println("아이디 사용 가능");
%>
<input type="button" value="아이디사용" onclick="ok()">
<%
}
%>
<form action="idcheck.jsp" name="wfr" method="get">
아이디:<input type="text" name="fid" value="<%=id %>">
<input type="submit" value="아이디 중복확인">
</form>
</body>
</html>