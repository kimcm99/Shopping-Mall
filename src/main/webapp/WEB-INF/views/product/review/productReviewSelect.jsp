<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>리뷰 페이지</title>

<!-- css 양식 include -->
<%@include file="/WEB-INF/views/common/header.jsp"%>
<!-- css 불러오기 -->
<link rel="stylesheet" href="css/productDetailReview.css">
<!-- css 불러오기 -->
<link rel="stylesheet" href="css/productDetail.css">
</head>
<body>

	<!-- 		<h1 class="bbswrite_title" align="center">리뷰 작성</h1> -->
	<form method="post" action="productReviewUpdateForm.do"
		enctype="multipart/form-data">
		<input type="hidden" name="rid" value="${review.rid}"> 
		<input	type="hidden" name="pid" value="${review.pid}">


<%-- 		productReviewUpdateForm.do?rid=${review.rid}&pid=${review.pid}'" --%>
		<table class="review_select">



			<tr>
				<th>작성자</th>
				<td style="color: black;">${review.rwriter }</td>
			</tr>



			<tr>
				<th>글제목</th>
				<td style="color: black;">${review.rtitle}</td>
			</tr>
			<tr>
				<th>이미지</th>
				<c:if test="${review.rimage != null}">
					<td><img src="images/${review.rimage }" alt="#" width="500"
						hight="500" /></td>
				</c:if>
				<c:if test="${review.rimage == null}">
					<td>첨부파일이 없습니다.</td>
				</c:if>
			</tr>

			<tr>
				<th>글내용</th>
				<td rowspan="2" style="color: black;">${review.rcontent}</td>
			</tr>

		</table>

		<div class="button_select">
			<!-- 			<button type="button" class="review_button1" -->
			<%-- 				onclick="location.href='productReviewUpdateForm.do?rid=${review.rid}&pid=${review.pid}'">수정</button> --%>
			
			<c:if test="${member.mEmail eq review.memail }">
			<button type="submit" class="review_button1" onclick="submit()">수정</button>
			</c:if>


			<button type="button" class="review_button1" onclick="history.go(-1)">취소</button>
		</div>
	</form>

	<!-- css 양식 include -->
	<%@include file="/WEB-INF/views/common/footer.jsp"%>
</body>
</html>