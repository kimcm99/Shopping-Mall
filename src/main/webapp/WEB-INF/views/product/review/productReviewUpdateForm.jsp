<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<script src="./js/product.js"></script>

<title>리뷰 페이지</title>
<!-- css 불러오기 -->
<link rel="stylesheet" href="css/productDetailReview.css">
<!-- css 양식 include -->
<%@include file="/WEB-INF/views/common/header.jsp"%>
</head>
<body>
	<div class="insert_main">
		<h1 class="" align="center">리뷰 수정</h1>
		<form method="post" action="productReviewUpdateCheck.do" enctype="multipart/form-data">
		<input type="hidden" name="rid" value="${review.rid }">

			<table class="insert_table">
				<tr>
					<th>pid</th>
					<td class="review_insert_form"><input type="text"
						class="input_box" name="pid" readonly="readonly" value="${pid}"></td>
				</tr>
				<tr>
					<th>아이디</th>
					<td class="review_insert_form"><input type="text"
						class="input_box" name="memail" readonly="readonly" value="${member.mEmail}"></td>
				</tr>
				<tr>
					<th>작성일</th>
					<td class="review_insert_form"><input type="text"
						class="input_box" name="rreg" readonly="readonly" value="${reviewDate}"></td>
				</tr>
				<tr>
					<th>작성자</th>
					<td><input type="text" id="rwriter" class="input_box"
						name="rwriter" value="${review.rwriter }" ></td>
				</tr>

				<tr>
					<!-- 추가할수도 -->
				</tr>

				<tr>
					<th>글제목</th>
					<td><input type="text" class="input_box" id="rtitle"
						name="rtitle" value="${review.rtitle }"></td>
				</tr>
				<tr>
					<th>이미지</th>
					<td><input type="file" id="rimage" class="input_box"
						name="rimage1"></td>
				</tr>
				<tr>
					<th>글내용</th>
					<td><textarea rows="10" cols="50" class="input_box"
							id="rcontent" name="rcontent">${review.rcontent }</textarea></td>
				</tr>
			</table>

			<div class="review_insert_button2">
				<input type="submit" value="수정" class="review_insert_button" id="review_insert_button"/> 
				<input type="reset" value="취소" class="review_insert_button" onclick="history.go(-1)" />
			</div>
		</form>
	</div>
	<!-- css 양식 include -->
	<%@include file="/WEB-INF/views/common/footer.jsp"%>
</body>
</html>