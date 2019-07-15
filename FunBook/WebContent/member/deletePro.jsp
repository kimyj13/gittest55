<%@page import="member.MemberDAO"%>
<%@page import="member.MemberBean"%>
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
String id = request.getParameter("id");
String pass = request.getParameter("pass");
String id2 = request.getParameter("id2");
MemberBean mb = new MemberBean();
mb.setId(id);
mb.setPass(pass);

MemberDAO md = new MemberDAO();
int a = md.userCheck(id, pass);


if(a ==1){
	if(id2 != null){
	if(id2.equals("admin")){
		md.deleteMember(mb); //삭제작업 deleteMember(mb) 메서드 실행
		response.sendRedirect("../main/main.jsp");
	}
	}else{
		md.deleteMember(mb); //삭제작업 deleteMember(mb) 메서드 실행
		session.invalidate(); //세션값 저장된거 없애기!
		response.sendRedirect("../main/main.jsp");
	}
}else if(a ==0){
%>
	<script type="text/javascript">
	alert('비밀번호 틀림');
	history.back();
</script>
<%
}else{ //해킹대비(?)
%>
<script type="text/javascript">
alert('아이디 없음');
history.back();
</script>
<%

}
%>
</body>
</html>