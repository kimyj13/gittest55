<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<header>
<%
String id = (String)session.getAttribute("id");
if(id==null){
%>
<div id="login"><a href="../member/login.jsp">login</a> | <a href="../member/join.jsp">join</a></div>
<%
}else{
%>

<div id="login"><b style="color: green;font-size: 20px;"><%=id %>님</b> | <a href="../member/mupdate.jsp" >회원정보수정</a> | <a href="../member/logout.jsp">logout</a> | <a href="../member/deleteForm.jsp">회원탈퇴</a></div>

<%}
%>
<div class="clear"></div>
<!-- 로고들어가는 곳 -->
<div id="logo"><img src="../images/로고.PNG" width="265" height="62" alt="Fun Book"></div>
<!-- 로고들어가는 곳 -->
<nav id="top_menu">
<ul style="margin-left: 20px;">
<%
if(id != null){
	if(id.equals("admin")){
		%>
		<li style="margin:0 10px;"><a href="../member/memberlist.jsp">회원</a></li>
			<li style="margin:0 10px;"><a href="../main/main.jsp">HOME</a></li>
	
	<li style="margin:0 10px;"><a href="../company/welcome.jsp">COMPANY</a></li>

	<li style="margin:0 10px;"><a href="../book/booknotice.jsp">도       서</a></li>

	<li style="margin:0 10px;"><a href="../center/notice.jsp">게시판/자료실</a></li>
		<%
	}else{

%>
	<li style="margin:0 20px;"><a href="../main/main.jsp">HOME</a></li>
	
	<li style="margin:0 20px;"><a href="../company/welcome.jsp">COMPANY</a></li>

	<li style="margin:0 20px;"><a href="../book/booknotice.jsp">도       서</a></li>

	<li style="margin:0 20px;"><a href="../center/notice.jsp">게시판/자료실</a></li>
<%}
}else{

%>
	<li style="margin:0 20px;"><a href="../main/main.jsp">HOME</a></li>
	
	<li style="margin:0 20px;"><a href="../company/welcome.jsp">COMPANY</a></li>

	<li style="margin:0 20px;"><a href="../book/booknotice.jsp">도       서</a></li>

	<li style="margin:0 20px;"><a href="../center/notice.jsp">게시판/자료실</a></li>
<%
}%>
</ul>
</nav>
</header>