<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<% session.invalidate(); //세션 초기화%>
<script type="text/javascript">
alert('로그아웃 합니다.');
location.href = "../main/main.jsp";
</script>
</body>
</html>