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

	<!-- 리뷰에서 글작성 성공 -->
	<c:if test="${resultType eq 'review_true' }">
		<script>
			alert('${msg}');
			location.href="productDetail.do?pid=${pid}";
		</script>
	</c:if>
	<!-- 자유게시판에서 글작성 성공 -->
	<c:if test="${resultType eq 'freeBoard_true' }">
		<script>
			alert('${msg}');
			location.href='freeBoardList.do';
		</script>
	</c:if>
	<!--  글작성 실패 -->
	<c:if test="${resultType eq 'report_false' }">
		<script>
			alert('${msg}');
			location.href='main.do';
		</script>
	</c:if>
	<!-- 용량이 초과한경우 -->
	<c:if test="${result eq 2 }">
		<script>
			alert('${msg}');
			history.go(-1);
		</script>
	</c:if>
	<!-- 파일 형식이 올바르지 않은경우 -->
	<c:if test="${result eq 3 }">
		<script>
			alert('${msg}');
			history.go(-1);
		</script>
	</c:if>
</body>
</html>