<%@page import="java.text.SimpleDateFormat"%>
<%@page import="Book.BookBean"%>
<%@page import="java.util.List"%>
<%@page import="Book.BookDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="../css/default.css" rel="stylesheet" type="text/css">
<link href="../css/subpage.css" rel="stylesheet" type="text/css">
<!--[if lt IE 9]>
<script src="http://ie7-js.googlecode.com/svn/version/2.1(beta4)/IE9.js" type="text/javascript"></script>
<script src="http://ie7-js.googlecode.com/svn/version/2.1(beta4)/ie7-squish.js" type="text/javascript"></script>
<script src="http://html5shim.googlecode.com/svn/trunk/html5.js" type="text/javascript"></script>
<![endif]-->
<!--[if IE 6]>
 <script src="../script/DD_belatedPNG_0.0.8a.js"></script>
 <script>
   /* EXAMPLE */
   DD_belatedPNG.fix('#wrap');
   DD_belatedPNG.fix('#main_img');   

 </script>
 <![endif]-->
</head>
<body>
<div id="wrap">
<!-- 헤더들어가는 곳 -->
<jsp:include page="../inc/top.jsp" />
<!-- 헤더들어가는 곳 -->

<!-- 본문들어가는 곳 -->
<!-- 메인이미지 -->
<div id="sub_img"></div>
<!-- 메인이미지 -->

<!-- 왼쪽메뉴 -->
<nav id="sub_menu">
<ul>
<!-- <li><a href="../center/notice.jsp">책 분류</a></li> -->
<li><a href="booknotice.jsp">도서목록</a></li>
<li><a href="newbookgnotice.jsp">신간도서</a></li>
<%
String id = (String)session.getAttribute("id");
if(id!=null){
	if(id.equals("admin")){ %>
<li><a href="bookwrite.jsp">쓰기</a></li>
<%
}} %>
</ul>
</nav>
<!-- 왼쪽메뉴 -->
<%
//전체 글개수
//BookDAO bdao
BookDAO bdao = new BookDAO();

//String pageNum 가져오기
String pageNum = request.getParameter("pageNum");
//pageNum이 없으면 "1" 설정
if(pageNum == null){
	pageNum = "1";
}

List<BookBean> BookList= null; //제네릭 타입

BookList = bdao.getBookBdateList(1, 12);//날짜 내림차순으로 검색해 12 게시물만 가져오기


%>
<!-- 게시판 -->
<article>
<h1>최신도서</h1>

<table id="notice" >
<tr><th class="tno" align="center" style="font-size: 20px;"> 신 간 도 서 12 권 </th>
    </table>
    <table style="border-spacing: 10px 10px">
<%
if(BookList !=null){
	%><tr><%
	for(int i=0; i < BookList.size();i++){
		BookBean bb = BookList.get(i);
		int a=1+i;
		if( a%3 >= 0){			
			
	%>
		<td style="color: #4af; border-left:15px solid; border-radius: 15px 0 0 15px; padding:5px 0px 0px 5px; "><%=bb.getBdate()%><br>
		<img src="../upload/<%=bb.getBfile() %>" width="190"  height="200" onclick="location.href='bookgcontent.jsp?num=<%=bb.getNum()%>&pageNum=<%=pageNum%>'">
		<br><%=bb.getBname() %><br><nav align="center">저자 : <%=bb.getWname()%></nav></td>
  	<%
		}
	if(a%3==0){
	%> </tr>
	  <tr> 
	  <% }   } %> </tr> <% } %> 
</table>
<div id="table_search"></div>

<div class="clear"></div>
<div id="page_control">
<%


%>
</div>
</article>
<!-- 게시판 -->
<!-- 본문들어가는 곳 -->
<div class="clear"></div>
<!-- 푸터들어가는 곳 -->
<jsp:include page="../inc/bottom.jsp" />
<!-- 푸터들어가는 곳 -->
</div>
</body>
</html>