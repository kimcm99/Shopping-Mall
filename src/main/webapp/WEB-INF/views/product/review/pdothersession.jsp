<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:if test="${result==1}">
	<script>
	alert("작성자가 아닙니다.");
	location.href="productReviewSelect.do?rid=${rid}&pid=${pid}";
	</script>
</c:if>
