<%@page import="java.net.URLEncoder"%>
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
<<ul>
<li><a href="../center/notice.jsp">게시판</a></li>
<li><a href="../center/fnotice.jsp">자료실</a></li>
</ul>
</nav>
<!-- 왼쪽메뉴 -->
<%

request.setCharacterEncoding("utf-8");//한글처리
String search =request.getParameter("search");//search 파라미터 값 가져오기


//전체 글개수
//BoardDAO bdao
BoardDAO bdao = new BoardDAO();

int count = bdao.getBoardCount(search);//검색어를 포함한 검색글 가져오기

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
boardList = bdao.getBoardList(startRow, pageSize, search);
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
<table id="notice">
<tr><th class="tno">No.</th>
    <th class="ttitle">Title</th>
    <th class="twrite">Writer</th>
    <th class="tdate">Date</th>
    <th class="tread">Read</th></tr>
<%
if(count !=0){
	for(int i=0; i < boardList.size();i++){
// 		BoardBean bb = (BoardBean)boardList.get(i);
		BoardBean bb = boardList.get(i); //제네릭 사용시 형변환 안해도 됨//속도 업!
	
%>
<tr><td><%=num-- %></td><td class="left">
<a href="content.jsp?num=<%=bb.getNum()%>&pageNum=<%=pageNum%>"><%=bb.getSubject() %></a></td>
<td><%=bb.getName() %></td><td><%=sdf.format(bb.getDate())%></td><td><%=bb.getReadcount() %></td></tr>    
    <%
	}   } %>
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
<%}%>
<div id="table_search">
<form action="noticeSearch.jsp" method="get">
<input type="text" name="search" class="input_box" value="<%=search %>"><!-- 검색칸에 검색글자 보이게끔 -->
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
	
	
	search = URLEncoder.encode(search, "UTF-8") //검색칸 글자 한글 처리//마지막에 처리해주기
			.replaceAll("\\+", "%20")
			.replaceAll("\\%21+", "!")
			.replaceAll("\\%27", "'")
			.replaceAll("\\%28", "()")
			.replaceAll("\\%29", ")")
			.replaceAll("\\%7E", "~");
	if(startPage > pageBlock){
		%><a href="noticeSearch.jsp?pageNum=<%=startPage - pageBlock%>&search=<%=search%>">Prev</a><%
	}
	for(int i = startPage; i <= endPage; i++ ){
		%><a href="noticeSearch.jsp?pageNum=<%=i%>&search=<%=search%>")><%=i %></a><%
	}
	if(endPage < pageCount){
		%><a href="noticeSearch.jsp?pageNum=<%=endPage+1%>&search=<%=search%>"><!-- endPage+1 -->Next</a><%
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