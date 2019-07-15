<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="../css/default.css" rel="stylesheet" type="text/css">
<link href="../css/subpage.css" rel="stylesheet" type="text/css">
<link rel="stylesheet" href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>

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
// String id = (String)session.getAttribute("id");
// //세션값 없으면 로그임 페이지로 넘어가기
// if(id.equals("admin")){
%>
<!-- 게시판 -->
<article>
<h1>Notice Write</h1>
<form action="bookwritePro.jsp" method="post" name="fr" enctype="multipart/form-data">
<table id="notice">
<tr><td class="twrite">책제목</td><td><input type="text" name="bname"></td></tr>
<tr><td class="twrite">저자</td><td><input type="text" name="wname"></td></tr>
<tr><td class="twrite">출간일</td><td><input type="text" id="datepicker" placeholder="출간일" name="bdate"></td>
    <script>
        $(function () {
            $("#datepicker").datepicker();
        });
    </script>
</tr>
<tr><td class="twrite">분류</td><td>
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
</td></tr>

<tr><td class="twrite">이미지</td><td><input type="file" name="bfile"></td></tr>
<tr><td class="twrite">책 소개</td>
<td class="twrite"><textarea name="content" rows="20" cols="40"></textarea></td></tr>
</table>
<div id="table_search">
<input type="submit" value="글쓰기" class="btn" >
</div>
</form>
<div class="clear"></div>
<div id="page_control">
</div>
</article>
<%
// }else{
// 	response.sendRedirect("../main/main.jsp");
// }
%>
<!-- 게시판 -->
<!-- 본문들어가는 곳 -->
<div class="clear"></div>
<!-- 푸터들어가는 곳 -->
<jsp:include page="../inc/bottom.jsp" />
<!-- 푸터들어가는 곳 -->
</div>
</body>
</html>