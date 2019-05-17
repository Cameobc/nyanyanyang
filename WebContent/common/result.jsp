<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%
    request.setCharacterEncoding("utf-8");
    response.setCharacterEncoding("utf-8");
    String msg = request.getParameter("message");
    String path = request.getParameter("path");
    %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript">
	alert('<%=msg%>');
	location.href= "<%=path%>";
</script>
</head>
<body>

</body>
</html>