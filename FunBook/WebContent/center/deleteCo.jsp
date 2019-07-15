<%@page import="Board.BoardDAO"%>
<%@page import="Board.BoardBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
int num = Integer.parseInt(request.getParameter("num"));
int conum = Integer.parseInt(request.getParameter("conum"));
String pageNum = request.getParameter("pageNum");
String id = (String)session.getAttribute("id");

BoardBean bb = new BoardBean();

bb.setName(id);
bb.setConum(conum);
BoardDAO bdao = new BoardDAO();

int check = bdao.couserCheck(id, conum);

// out.println(check);
// out.println(id);
if(id !=null){
	if(check == 1 ){
		bb.setConum(conum);
		bb.setNum(num);
		bdao.deleteComment(bb);
		%>
		<script type="text/javascript">
		location.href="content.jsp?num=<%=num%>&pageNum=<%=pageNum%>";
		</script>
		<%
		}else if(id.equals("admin")){
		bb.setConum(conum);
		bb.setNum(num);
		bdao.deleteComment(bb);
		%>
		<script type="text/javascript">
		location.href="content.jsp?num=<%=num%>&pageNum=<%=pageNum%>";
		</script>
		<%	
		}else if(check == -1){
		%>
		<script type="text/javascript">
		alert('본인이 작성한 댓글만 삭제 가능합니다.');
		history.back();
		</script>
		<%
		}
	}else{
%>
<script type="text/javascript">
alert('저리가');
history.back();
</script>
<%} 
%>
</body>
</html>