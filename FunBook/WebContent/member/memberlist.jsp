<%@page import="java.net.URLEncoder"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.List"%>
<%@page import="member.MemberBean"%>
<%@page import="member.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="../css/default.css" rel="stylesheet" type="text/css">
<link href="../css/subpage.css" rel="stylesheet" type="text/css">
</head>
<body>
<div id="wrap">
<!-- 헤더들어가는 곳 -->
<jsp:include page="../inc/top.jsp" />
<!-- 헤더들어가는 곳 -->

<!-- 본문들어가는 곳 -->
<!-- 메인이미지 -->
<div id="sub_img_center"></div>

<nav id="sub_menu">
<!-- 관리자만 확인 가능 -->
<ul>
<li><a href="memberlist.jsp">회원정보</a></li>
</ul>
</nav>

<%
request.setCharacterEncoding("utf-8");
String id = (String)session.getAttribute("id");

MemberDAO mdao = new MemberDAO();
List Mblist = mdao.getMemberList();
SimpleDateFormat sdf = new SimpleDateFormat("yyyy.MM.dd");//날짜 출력 형태
%>

<article>
<h1>회원정보</h1>
<table id="notice" >
<tr>
   <th class="twrite">ID</th>
    <th class="twrite">PASS</th>
    <th class="twrite">이름</th>
    <th class="tdate">가입일</th>
    <th class="tdate">Email</th>
    <th class="ttitle">주소</th>
    <th class="tdate">Phone</th>
    <th class="tdate">Mobile</th></tr>
    

<% for(int i = 0; i < Mblist.size(); i++){
	MemberBean mb = (MemberBean)Mblist.get(i);
	
	 String id2 = mb.getId();
	id2 = URLEncoder.encode(id2, "UTF-8") //글자 한글 처리 넘기기//마지막에 처리해주기
	.replaceAll("\\+", "%20")
	.replaceAll("\\%21+", "!")
	.replaceAll("\\%27", "'")
	.replaceAll("\\%28", "()")
	.replaceAll("\\%29", ")")
	.replaceAll("\\%7E", "~");
%><tr onclick="location.href='deleteForm.jsp?id2=<%=id2%>'"><td><%=mb.getId() %></td><td><%=mb.getPass() %></td><td><%=mb.getName() %></td><td><%=sdf.format(mb.getReg_date()) %></td>
<td><%=mb.getEmail() %></td><td><%=mb.getAddress() %></td><td><%=mb.getPhone() %></td><td><%=mb.getMobile() %></td></tr>
<%
}
%>
</table>

</article>
<div class="clear"></div>
<!-- 푸터들어가는 곳 -->
<jsp:include page="../inc/bottom.jsp" />
<!-- 푸터들어가는 곳 -->
</div>
</body>
</html>