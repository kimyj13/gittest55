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
String id = (String)session.getAttribute("id");
String pass = request.getParameter("pass");
String name = request.getParameter("name");
Timestamp reg_date = new Timestamp(System.currentTimeMillis());
String email = request.getParameter("email");
String address = request.getParameter("postcode");// +"/" + request.getParameter("add1");// +"/" +  request.getParameter("add2") ;

String dbaddress = request.getParameter("dbaddress");


String phone= request.getParameter("phone");
String mobile = request.getParameter("mobile");
out.println("address :");
out.println(address);
out.println("dbaddress :");
out.println(dbaddress);
//MemberBean  mb객체 생성
MemberBean mb = new MemberBean();
//mb변수 =<파라미터 저장
mb.setId(id);
mb.setPass(pass);
mb.setName(name);
mb.setEmail(email);

if(address == ""){
	address = dbaddress;
}else{
	if(request.getParameter("add1") != ""){
		address += "/" + request.getParameter("add1");}
	if(request.getParameter("add2") != ""){
	address +=request.getParameter("add2");}
	if(request.getParameter("add3") != ""){
		address += request.getParameter("add3");
	}
}


mb.setAddress(address);
mb.setPhone(phone);
mb.setMobile(mobile);
mb.setReg_date(reg_date);

//패키지 memeber 파일이름 MemberDAO
MemberDAO md = new MemberDAO();
//MemberDAO mdao 객체 생성
// int check = md.userCheck(id, pass);

md.updateMember(mb);  // insertMember(mb)

response.sendRedirect("../main/main.jsp");  //login.jsp이동

%>

</body>
</html>