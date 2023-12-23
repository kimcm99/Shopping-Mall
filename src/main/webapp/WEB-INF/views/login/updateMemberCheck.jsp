<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 수정</title>
</head>
<body>

<c:if test="${result == 1 }">
	<script type="text/javascript">
		alert("회원 정보가 수정 되었습니다.");
		location.href = "mypage.do";
	</script>
</c:if>

<c:if test="${result != 1 }">
	<script type="text/javascript">
		alert("회원 정보가 수정에 실패하였습니다.");
		history.go(-1);
	</script>
</c:if>

</body>
</html>