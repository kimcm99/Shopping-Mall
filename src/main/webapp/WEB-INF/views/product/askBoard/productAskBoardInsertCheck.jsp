<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:if test="${result==1}">
	<script>
	alert("문의 등록 완료");
	location.href="productDetail.do?pid=${pid}";
	</script>
</c:if>

<c:if test="${result !=1}">
	<script>
	alert("문의가 등록되지 않았습니다.");
	location.href="productDetail.do?pid=${pid}";
	</script>
</c:if>