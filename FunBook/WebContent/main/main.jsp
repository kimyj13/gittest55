<%@page import="Book.BookBean"%>
<%@page import="Book.BookDAO"%>
<%@page import="mail.MailSend"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.List"%>
<%@page import="Board.BoardDAO"%>
<%@page import="Board.BoardBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="../css/default.css" rel="stylesheet" type="text/css">
<link href="../css/front.css" rel="stylesheet" type="text/css">

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
<!-- 헤더파일들어가는 곳, 모든 페이지에 동일하게 보이는 top을 따로 만들어서 연결하기-->
<jsp:include page="../inc/top.jsp" />
<!-- 메인이미지 들어가는곳 -->
<div class="clear"></div>
<div id="main_img"><img src="../images/책.PNG"
 width="971" height="282"></div>
<!-- 메인이미지 들어가는곳 -->
<!-- 메인 콘텐츠 들어가는 곳 -->
<article id="front">
<div id="solution">
<div id="hosting">
<h3>Web Hosting Solution</h3>
<p>Lorem impsun Lorem impsunLorem impsunLorem
 impsunLorem impsunLorem impsunLorem impsunLorem
  impsunLorem impsunLorem impsun....</p>
</div>
<div id="security">
<h3>Web Security Solution</h3>
<p>Lorem impsun Lorem impsunLorem impsunLorem
 impsunLorem impsunLorem impsunLorem impsunLorem
  impsunLorem impsunLorem impsun....</p>
</div>
<div id="payment">
<h3>Web Payment Solution</h3>
<p>Lorem impsun Lorem impsunLorem impsunLorem
 impsunLorem impsunLorem impsunLorem impsunLorem
  impsunLorem impsunLorem impsun....</p>
</div>
</div>
<div class="clear"></div>
<div  id="news_notice">
<h3 class="brown"><span  style="margin-left: 30px;">도     서</span></h3>
<table>
<%
// MailSend mailsend = new MailSend();
// MailSend.MailSend();

BookDAO bkdao = new BookDAO();

int count = bkdao.getbooksCount();//현페이지 글 가져오기

String pageNum = request.getParameter("pageNum");

List<BookBean> bookList= null; //제네릭 타입

bookList = bkdao.getbooksList(1, 5);

// SimpleDateFormat sdf = new SimpleDateFormat("yyyy.MM.dd");//날짜 출력 형태

if(count !=0){
for(int i=0; i < bookList.size();i++){
		BookBean bkb = bookList.get(i); //제네릭 사용시 형변환 안해도 됨//속도 업!
%>
<tr><td class="contxt"><a href="../book/bookcontent.jsp?num=<%=bkb.getNum()%>&pageNum=<%=1%>"><%=bkb.getBname() %>
<!-- 페이지 넘버 값 1로 두면 첫페이지로 값이 넘어간다. --></a></td>
    <td><%=bkb.getWname()%></td></tr>
    <%
	}
}%> 
</table>
</div>
<div id="news_notice">
<h3 class="brown">게시판/자료실</h3>
<table>
<%
// MailSend mailsend = new MailSend();
// MailSend.MailSend();

BoardDAO bdao = new BoardDAO();

count = bdao.getBoardCount();//현페이지 글 가져오기

pageNum = request.getParameter("pageNum");

List<BoardBean> boardList= null; //제네릭 타입

boardList = bdao.getBoardList(1, 5);

SimpleDateFormat sdf = new SimpleDateFormat("yyyy.MM.dd");//날짜 출력 형태

if(count !=0){
for(int i=0; i < boardList.size();i++){
		BoardBean bb = boardList.get(i); //제네릭 사용시 형변환 안해도 됨//속도 업!
%>
<tr><td class="contxt"><a href="../center/content.jsp?num=<%=bb.getNum()%>&pageNum=<%=1%>"><%=bb.getSubject() %>
<!-- 페이지 넘버 값 1로 두면 첫페이지로 값이 넘어간다. --></a></td>
    <td><%=sdf.format(bb.getDate())%></td></tr>
    <%
	}
}%> 

</table>
</div>
</article>
<!-- 메인 콘텐츠 들어가는 곳, 모든 페이지에 동일하게 보이는 bottom을 따로 만들어서 연결하기 -->
<div class="clear"></div>
<!-- 푸터 들어가는 곳 -->
<jsp:include page="../inc/bottom.jsp" />
<!-- 푸터 들어가는 곳 -->
</div>
</body>
</html>