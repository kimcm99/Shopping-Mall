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
	<!-- 답글작성 성공 -->
	<c:if test="${result eq 'insert_True' }">
		<script>
			alert('답글작성 완료.');
			location.href='masterReportSelect.do?reportid=${Report.reportid}';
		</script>
	</c:if>
	<!-- 답글작성 실패 -->
	<c:if test="${result eq 'insert_False' }">
		<script>
			alert('답글작성 실패.');
			history.go(-1);
		</script>
	</c:if>
</body>
</html>