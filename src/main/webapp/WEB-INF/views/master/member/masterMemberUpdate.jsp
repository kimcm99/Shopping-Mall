<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="http://code.jquery.com/jquery-latest.js"></script>
<link rel="stylesheet" href="css/masterCss.css">
<script src="js/master.js"></script>
<title>Insert title here</title>
</head>
<body>
	<c:if test="${result > 0}">
		<script>
			alert("${msg}");
			location.href = "masterMemberSelect.do?id=${mEmail}";
		</script>
	</c:if>

	<c:if test="${result < 0}">
		<script>
			alert("${msg}");
			history.go(-1);
		</script>
	</c:if>
</body>
</html>