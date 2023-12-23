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

	<c:if test="${msg == 'updateTrue'}">
		<script>
			alert('등록이 완료 되었습니다.');
			location.href = "masterProductList.do";
		</script>
	</c:if>

	<c:if test="${msg == 'deleteTrue'}">
		<script>
			alert('삭제가 완료 되었습니다.');
			location.href = "masterProductList.do";
		</script>
	</c:if>

	<c:if test="${msg == 'updateProductTrue'}">
		<script>
			alert('수정이 완료 되었습니다.');
			location.href = "masterProductList.do";
		</script>
	</c:if>

	<c:if test="${msg == 'productInsertTrue'}">
		<script>
			alert('등록이 완료 되었습니다.');
			location.href = "masterProductList.do";
		</script>
	</c:if>

	<c:if test="${result > 0}">
		<script>
			alert("${msg}");
			location.href = "masterProductList.do";
		</script>
	</c:if>

	<c:if test="${result == 0}">
		<script>
			alert("${msg}");
			history.go(-1);
		</script>
	</c:if>

	<!-- 종윤 추가코드 delete 다중 result 변수명 같아서 이름바꿈-->
	<!-- 삭제 성공시 -->
	<c:if test="${resultDelete > 0 }">
		<script>
			alert("${msg}");
			location.href = "masterProductList.do";
		</script>
	</c:if>

	<!--삭제 실패시-->
	<c:if test="${resultDelete > 0 }">
		<script>
			alert("${msg}");
			history.go(-1);
		</script>
	</c:if>
	
	<c:if test="${type == 'notKey'}">
		<script>
		alert("${msg}");
		history.go(-1);
		</script>
	</c:if>
	
	<c:if test="${type == 'notType'}">
		<script>
		alert("${msg}");
		history.go(-1);
		</script>
	</c:if>
	
	<c:if test="${type == 'notKeynotType'}">
		<script>
		alert("${msg}");
		history.go(-1);
		</script>
	</c:if>
	
	<c:if test="${resultCheck == 'checkBoxNull'}">
		<script>
		alert("${resultMsg}");
		history.go(-1);
		</script>
	</c:if>
	
</body>
</html>















