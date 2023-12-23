<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="http://code.jquery.com/jquery-latest.js"></script>
<link rel="stylesheet" href="css/masterCss.css">
<script src="js/master.js"></script>
<title>회원 개인정보</title>
<!-- css 양식 include -->
</head>
<body>
	<%@ include file="../common/masterNav.jsp"%>
	<div class="container">
		<h1 class="h1_caption">회원 개인정보</h1>
		<table>
			<tr>
				<th>ID</th>
				<th>이름</th>
				<th>핸드폰</th>
				<th>우편번호</th>
				<th>주소</th>
				<th>회원등급</th>
				<th>가입일</th>
				<th>삭제여부</th>
				<th>관리</th>
			</tr>
			<tr>
				<td>${member.mEmail}</td>
				<td>${member.mName}</td>
				<td>${member.mPhone}</td>
				<td>${member.mPost}</td>
				<td>${member.mAddress}</td>
				<td>${member.mGrade}</td>
				<td>${member.mReg}</td>
				<td>${member.mDrop}</td>
				<td><button type="button"
						onclick="location.href='masterMemberUpdateForm.do?id=${member.mEmail}' ">수정</button>
					<button type="button"
						onclick="location.href='masterMemberDelete.do?id=${member.mEmail}' ">삭제</button></td>
			</tr>
		</table>
		<table class="fancy_table">

			<tr>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
			</tr>
			<tr align="center">
				<td colspan="7"
					style="padding: 20px; color: deeppink; font-size: 40px; font-weight: bold;">주문
					상품 목록</td>

			</tr>
			<tr>
				<th>상품코드</th>
				<th>이미지</th>
				<th>상품명</th>
				<th>색상</th>
				<th>사이즈</th>
				<th>설명</th>
				<th>등록일</th>
			</tr>

			<c:forEach var="product" items="${productList}" varStatus="loop">
				<tr>
					<td style="font-size: 25px !important;"
						onclick="location.href='masterProductDetail.do?id=${product.pid}' ">${product.pid}
					</td>
					<td style="font-size: 25px !important;"
						onclick="location.href='masterProductDetail.do?id=${product.pid}' "><img
						src="./images/${product.pimage }" width="100" height="100"></td>
					<td style="font-size: 25px !important;"
						onclick="location.href='masterProductDetail.do?id=${product.pid}' ">${product.pname }</td>
					<td style="font-size: 25px !important;"
						onclick="location.href='masterProductDetail.do?id=${product.pid}' ">${product.pcolor }</td>
					<td style="font-size: 25px !important;"
						onclick="location.href='masterProductDetail.do?id=${product.pid}' ">${product.psize }</td>
					<td><input type="text" value="${product.pcontent }"
						style="font-size: 25px !important;"></td>
					<td style="font-size: 25px !important;"
						onclick="location.href='masterProductDetail.do?id=${product.pid}' ">
						<fmt:formatDate pattern="yyyy/MM/dd" value="${product.preg}" />
					</td>
				</tr>




			</c:forEach>
		</table>
		<h4 class="info-message">클릭시 해당 상품으로 이동합니다.</h4>
	</div>
	<br>

	</div>
</body>
</html>