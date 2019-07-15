<%@page import="java.net.URLEncoder"%>
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

request.setCharacterEncoding("utf-8");//한글처리
// String search =request.getParameter("search");//search 파라미터 값 가져오기
String bnum = request.getParameter("bnum");

//전체 글개수
//BookDAO bdao
BookDAO bdao = new BookDAO();

int count = bdao.getBookbnum(bnum);//검색어를 포함한 검색글 가져오기

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
// List<BookBean> BookList = getBookList(시작행, 가져올 글개수)
List<BookBean> BookList= null; //제네릭 타입

if(count != 0){
BookList = bdao.getBookBnumList(startRow, pageSize, bnum);
}
// SimpleDateFormat sdf = new SimpleDateFormat("yyyy.MM.dd");//날짜 출력 형태

//화면에 보여지는 글번호 구하기
//전체 글개수가 20
//count  		currentPage(pageNum)  pageSize
//	 20						1							10				=>	20 - 0  =20
//								2							10				=>	10 - 10 =10
int num = count - (currentPage-1)*pageSize;//DB값 말고 게시판에 차례로 글 번호 보이게끔

%>
<!-- 게시판 -->
<article>
<h1>분류번호 : <%=bnum %> [전체 글 개수 :<%=count %> ]</h1>
<table id="notice">
<tr><th class="tno">No.</th>
    <th class="ttitle">책제목</th>
    <th class="twrite">저자</th>
    <th class="tdate">출간일</th>
    <th class="tread">분류</th></tr>
<%
if(count !=0){
	for(int i=0; i < BookList.size();i++){
// 		BoardBean bb = (BoardBean)boardList.get(i);
		BookBean bb =BookList.get(i); //제네릭 사용시 형변환 안해도 됨//속도 업!
	
		bnum="";
		switch(bb.getBnum()){//디비에 저장된 번호를 분야명으로 출력하기
		case "000":
			bnum="총류";
			break;
		case "100":
			bnum="철학";
			break;
		case "200":
			bnum="종교";
			break;
		case "300":
			bnum="사회과학";
			break;
		case "400":
			bnum="자연과학";
			break;
		case "500":
			bnum="기술과학";
			break;
		case "600":
			bnum="예술";
			break;
		case "700":
			bnum="언어";
			break;
		case "800":
			bnum="문학";
			break;
		case "900":
			bnum="역사";
			break;
		default:bnum="총류";		
		}
		 %>
		 <tr onclick="location.href='bookcontent.jsp?num=<%=bb.getNum()%>&pageNum=<%=pageNum%>'" ><td><%=num-- %></td>
		 <td><img src="../upload/<%=bb.getBfile() %>" height="150" align="left"><p  style="padding-top:50px;font-size: 16px;"><%=bb.getBname() %></p></td>
		 <td ><%=bb.getWname() %></td><td><%=bb.getBdate()%></td><td><%=bnum %></td></tr>    
		     <%
		 	}   } %>
</table>
<div id="table_search">
<form action="booknoticebnum.jsp" method="get" >
<select name="bnum" value="<%=bnum%>">
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
<input type="submit" value="분류별보기" class="btn">
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
	
	
// 	bnum = URLEncoder.encode(bnum "UTF-8") //검색칸 글자 한글 처리//마지막에 처리해주기
// 			.replaceAll("\\+", "%20")
// 			.replaceAll("\\%21+", "!")
// 			.replaceAll("\\%27", "'")
// 			.replaceAll("\\%28", "()")
// 			.replaceAll("\\%29", ")")
// 			.replaceAll("\\%7E", "~");
	if(startPage > pageBlock){
		%><a href="booknoticebnum.jsp?pageNum=<%=startPage - pageBlock%>&bnum=<%=bnum%>">Prev</a><%
	}
	for(int i = startPage; i <= endPage; i++ ){
		%><a href="booknoticebnum.jsp?pageNum=<%=i%>&bnum=<%=bnum%>")><%=i %></a><%
	}
	if(endPage < pageCount){
		%><a href="booknoticebnum.jsp?pageNum=<%=endPage+1%>&bnum=<%=bnum%>"><!-- endPage+1 -->Next</a><%
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