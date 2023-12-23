<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 가입</title>
</head>
<body>

<c:if test="${result == 1 }">
	<script type="text/javascript">
		alert("회원가입 되었습니다.");
		location.href = "main.do";
	</script>
</c:if>

<c:if test="${result != 1 }">
	<script type="text/javascript">
		alert("회원가입에 실패하였습니다.");
		history.go(-1);
	</script>
</c:if>

</body>
</html>