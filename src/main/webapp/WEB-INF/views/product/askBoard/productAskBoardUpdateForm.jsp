<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<script src="./js/product.js"></script>

<title>상품 문의 작성폼</title>

<!-- css 양식 include -->
<%@include file="/WEB-INF/views/common/header.jsp"%>


<!-- css불러오기 -->
<link rel="stylesheet" href="css/AskBoard.css">
</head>
<body>

	<div class="Ask_insert">
		<h1 class="" align="center">문의 수정</h1>
		<form method="post" action="productAskBoardUpdateCheck.do?askid=${askboard.askid }">
			
			<table class="askinsert_table">
				<tr>
					<th>상품번호</th>
					<td class=""><input type="text" class="input_box" name="pid"
						readonly="readonly" value="${askboard.pid}"></td>
				</tr>
				<tr>
					<th>작성자</th>
					<td class=""><input type="text" class="input_box"
						name="memail" readonly="readonly" value="${askboard.memail}"></td>
				</tr>
				<tr>
					<th>상품문의날짜</th>
					<fmt:formatDate value="${askboard.askreg }" var="formatDate" pattern="YYYY년 MM월 dd일"/>
					<td class="">${formatDate }</td>
				</tr>

				<tr>
					<th>상품문의내용</th>
					<td><textarea rows="10" cols="50" class="input_box" id="askcontent" name="askcontent"></textarea></td>
				</tr>
			</table>

			<div class="ask_insert_button">
				<input type="submit" value="수정" class="review_insert_button" id="review_insert_button" /> <input
					type="reset" value="취소" class="review_insert_button"
					onclick="history.go(-1)" />
			</div>
		</form>
	</div>







	<!-- css 양식 include -->
	<%@include file="/WEB-INF/views/common/footer.jsp"%>
</body>
</html>