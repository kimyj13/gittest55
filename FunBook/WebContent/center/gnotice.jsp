<%@page import="java.text.SimpleDateFormat"%>
<%@page import="Board.BoardBean"%>
<%@page import="java.util.List"%>
<%@page import="Board.BoardDAO"%>
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
<div id="sub_img_center"></div>
<!-- 메인이미지 -->

<!-- 왼쪽메뉴 -->
<nav id="sub_menu">
<ul>
<li><a href="../center/notice.jsp">게시판</a></li>
<li><a href="../center/fnotice.jsp">자료실</a></li>
</ul>
</nav>
<!-- 왼쪽메뉴 -->
<%
//전체 글개수
//BoardDAO bdao
BoardDAO bdao = new BoardDAO();

int count = bdao.getBoardCount();//현페이지 글 가져오기

//한페이지 가져올 글 개수
int pageSize = 15;
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
// List<BoardBean> boardList = getBoardList(시작행, 가져올 글개수)
List<BoardBean> boardList= null; //제네릭 타입
if(count != 0){
boardList = bdao.getBoardList(startRow, pageSize);
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
<a href="notice.jsp">기본 보기</a>
<table id="notice" >
<tr><th class="tno" align="center"> 목     록 </th>
    </table>
    <table style="border-spacing: 10px 10px">
<%
if(count !=0){
	%><tr><%
	for(int i=0; i < boardList.size();i++){
		BoardBean bb = boardList.get(i);
		int a=1+i;
		if( a%3 >= 0){			
	%>
		<td style="color: #4af; border-left:15px solid; border-radius: 15px 0 0 15px; padding:5px 0px 0px 5px;"><%=num-- %><br>
		<%if(bb.getFile() == null){%>
			<img src="../images/noimage.png" width="190"  height="100" onclick="location.href='gcontent.jsp?num=<%=bb.getNum()%>&pageNum=<%=pageNum%>'">
		<br><%=bb.getSubject() %><br>작성자 : <%=bb.getName() %><br>조회수 : <%=bb.getReadcount()%></td><%
		}else{%>
		<img src="../upload/<%=bb.getFile() %>" width="190"  height="100" onclick="location.href='gcontent.jsp?num=<%=bb.getNum()%>&pageNum=<%=pageNum%>'">
		<br><%=bb.getSubject() %><br><nav align="center">작성자 : <%=bb.getName() %></nav><nav align="center">조회수 : <%=bb.getReadcount()%></nav></td>
  	<%
		}
		
		}
	if(a%3==0){
	%> </tr>
	  <tr> 
	  <% }   } %> </tr> <% } %> 
</table>
<%
//세션값 가져오기
String id = (String)session.getAttribute("id");
//세션값이 있으면 글쓰기 버튼 보이기(로그인 한 사람만 글쓰기 버튼 보이게)
if(id != null){
%>
<div id="table_search">
<input type="button" value="글쓰기" class="btn" onclick="location.href='writeForm.jsp'">
</div>
<%} %>
<div id="table_search">
<form action="noticeSearch.jsp" method="get">
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
		%><a href="gnotice.jsp?pageNum=<%=startPage - pageBlock%>">Prev</a><%
	}
	for(int i = startPage; i <= endPage; i++ ){
		%><a href="gnotice.jsp?pageNum=<%=i%>"><%=i %></a><%
	}
	if(endPage < pageCount){
		%><a href="gnotice.jsp?pageNum=<%=endPage+1%>"><!-- startPage+pageBlock -->Next</a><%
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