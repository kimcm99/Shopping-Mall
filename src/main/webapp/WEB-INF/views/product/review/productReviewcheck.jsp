<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:if test="${result==1}">
	<script>
	alert("리뷰 등록 완료");
	location.href="productDetail.do?pid=${pid}";
	</script>
</c:if>

<c:if test="${result !=1}">
	<script>
	alert("상품을 구매 후 이용 가능합니다.");
	location.href="productDetail.do?pid=${pid}";
	</script>
</c:if>