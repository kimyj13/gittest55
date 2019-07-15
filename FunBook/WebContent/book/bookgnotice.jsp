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
<li><a href="booknotice.jsp">도 서</a></li>
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

int count = bdao.getbooksCount();//현페이지 글 가져오기

//한페이지 가져올 글 개수
int pageSize = 12;
//String pageNum 가져오기
String pageNum = request.getParameter("pageNum");
//pageNum이 없으면 "1" 설정
if(pageNum == null){
	pageNum = "1";
}

int currentPage = Integer.parseInt(pageNum);//int currentPage = pageNum 정수형 변경

int startRow = (currentPage-1)*pageSize+1; //int startRow = 
int endRow = currentPage * pageSize;//int endRow = 
//게시판 글있으면
// List<BookBean> BookList = getBookList(시작행, 가져올 글개수)
List<BookBean> BookList= null; //제네릭 타입
if(count != 0){
BookList = bdao.getbooksList(startRow, pageSize);
}
SimpleDateFormat sdf = new SimpleDateFormat("yyyy.MM.dd");//날짜 출력 형태

//화면에 보여지는 글번호 구하기
//전체 글개수가 20
//count  		currentPage(pageNum)  pageSize
//	 20						1							10				=>	20 - 0  =20
//								2							10				=>	10 - 10 =10
int num = count - (currentPage-1)*pageSize;//DB값 말고 게시판에 차례로 글 번호 보이게끔

%>
<!-- 게시판 -->
<article>
<h1>Notice [전체 글 개수 :<%=count %> ]</h1>
<a href="booknotice.jsp">기본 보기</a>
<table id="notice" >
<tr><th class="tno" align="center"> 목     록 </th>
    </table>
    <table style="border-spacing: 10px 10px">
<%
if(count !=0){
	%><tr><%
	for(int i=0; i < BookList.size();i++){
		BookBean bb = BookList.get(i);
		int a=1+i;
		if( a%3 >= 0){			
	%>
		<td style="color: #4af; border-left:15px solid; border-radius: 15px 0 0 15px; padding:5px 0px 0px 5px; "><%=num-- %><br>
		<img src="../upload/<%=bb.getBfile() %>" width="190"  height="200" onclick="location.href='bookgcontent.jsp?num=<%=bb.getNum()%>&pageNum=<%=pageNum%>'"
		onmouseover="">
		<br><%=bb.getBname() %><br><nav align="center">저자 : <%=bb.getWname()%></nav></td>
  	<%
		}
	if(a%3==0){
	%> </tr>
	  <tr> 
	  <% }   } %> </tr> <% } %> 
</table>
<div id="table_search">
<form action="booknoticebnum.jsp" method="get" >
<select name="bnum">
<option value="">선택하세요</option>
<option value="000">총류</option>
<option value="100">철학</option>
<option value="200">종교</option>
<option value="300">사회과학</option>
<option value="400">자연과학</option>
<option value="500">기술과학</option>
<option value="600">예술</option>
<option value="700">언어</option>
<option value="800">문학</option>
<option value="900">역사</option>
</select>
<input type="submit" value="분야별보기" class="btn">
</form>
</div>
<div id="table_search">
<form action="booknoticeSearch.jsp" method="get">
<input type="text" name="search" class="input_box">
<input type="submit" value="search" class="btn">
</form>
</div>
<div class="clear"></div>
<div id="page_control">
<%
if(count != 0){
	int pageCount = (count%pageSize != 0 ? count/pageSize+1: count/pageSize);
	int pageBlock = 10;
	int startPage = (currentPage-1)/pageBlock*pageBlock+1;
	int endPage = startPage+pageBlock-1;
	if(endPage > pageCount){
		endPage = pageCount;
	}
	if(startPage > pageBlock){
		%><a href="bookgnotice.jsp?pageNum=<%=startPage - pageBlock%>">Prev</a><%
	}
	for(int i = startPage; i <= endPage; i++ ){
		%><a href="bookgnotice.jsp?pageNum=<%=i%>"><%=i %></a><%
	}
	if(endPage < pageCount){
		%><a href="bookgnotice.jsp?pageNum=<%=endPage+1%>"><!-- startPage+pageBlock -->Next</a><%
	}
}

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