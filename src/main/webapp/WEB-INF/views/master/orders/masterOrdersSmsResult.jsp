<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<c:if test="${result eq 'free' }">
		<script>
			alert("${msg}");
			location.href = "masterOrdersList.do";
		</script>
	</c:if>
	<c:if test="${result eq 'delivery' }">
		<script>
			alert("${msg}");
			location.href = "masterOrdersSelect.do?oid=${orders.oid}";
		</script>
	</c:if>

</body>
</html>