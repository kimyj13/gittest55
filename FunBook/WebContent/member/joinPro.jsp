<%@page import="member.MemberDAO"%>
<%@page import="member.MemberBean"%>
<%@page import="java.sql.Timestamp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<h1>member/joinPro.jsp</h1>
<%
request.setCharacterEncoding("utf-8");//한글처리
String id = request.getParameter("id"); //변수 저장
String pass = request.getParameter("pass");
String name = request.getParameter("name");
Timestamp reg_date = new Timestamp(System.currentTimeMillis());
String email = request.getParameter("email");
String address = request.getParameter("postcode") +"/" + request.getParameter("add1") + request.getParameter("add2") ;
if(request.getParameter("add3") != null){
	address += request.getParameter("add3");
}
String phone= request.getParameter("phone");
String mobile = request.getParameter("mobile");

//MemberBean  mb객체 생성
MemberBean mb = new MemberBean();
//mb변수 =<파라미터 저장
mb.setId(id);
mb.setPass(pass);
mb.setName(name);
mb.setEmail(email);
mb.setAddress(address);
mb.setPhone(phone);
mb.setMobile(mobile);
mb.setReg_date(reg_date);

//패키지 memeber 파일이름 MemberDAO
MemberDAO md = new MemberDAO();
//MemberDAO mdao 객체 생성

md.insertMember(mb);  // insertMember(mb)

response.sendRedirect("login.jsp");  //login.jsp이동

%>

</body>
</html>