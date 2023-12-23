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
<title>상품 상세정보</title>
<!-- css 양식 include -->
</head>
<body>

	<%@ include file="../common/masterNav.jsp"%>

	<div class="container">
		<h1 class="h1_caption">상품 상세정보</h1>
		<table>
			<tr>
				<th>상품코드</th>
				<th>이미지</th>
				<th>상품명</th>
				<th>색상</th>
				<th>사이즈</th>
				<th>설명</th>
				<th>등록일</th>
				<th>재고수량</th>
				<th>삭제여부[Y/N]</th>
				<th>수정/삭제</th>
			</tr>
			<tr>
				<td>${product.pid }</td>
				<td><img src="./images/${product.pimage }" width="100"
					height="100"></td>
				<td>${product.pname }</td>
				<td>${product.pcolor }</td>
				<td>${product.psize }</td>
				<td>${product.pcontent }</td>

				<c:if test="${product.preg != null}">
					<td><fmt:formatDate pattern="yyyy-MM-dd"
							value="${product.preg }" /></td>
				</c:if>

				<c:if test="${product.preg == null }">
					<td><fmt:formatDate pattern="yyyy-MM-dd" value="${date }" /></td>
				</c:if>
				<td>${amount.acount }</td>

				<td>${product.pdrop }</td>
				<td>
					<button type="button"
						onclick="location.href='masterProductUpdateForm.do?id=${product.pid}'">수정</button>
					<button type="button"
						onclick="alert('삭제하시겠습니까?'); location.href='masterProductDelete.do?id=${product.pid}'">삭제</button>
				</td>
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
					회원 목록</td>

			</tr>
			<tr>
				<th>ID</th>
				<th>이름</th>
				<th>핸드폰</th>
				<th>우편번호</th>
				<th>주소</th>
				<th>회원등급</th>
				<th>가입일</th>
			</tr>

			<c:set var="i" value="1"></c:set>
			<c:forEach var="member" items="${memberList}" varStatus="loop">
				<tr>
					<td style="font-size: 25px !important;"
						onclick="location.href='masterMemberSelect.do?id=${member.mEmail}' ">${member.mEmail}
					</td>
					<td style="font-size: 25px !important;"
						onclick="location.href='masterMemberSelect.do?id=${member.mEmail}' ">${member.mName}</td>
					<td style="font-size: 25px !important;"
						onclick="location.href='masterMemberSelect.do?id=${member.mEmail}' ">${member.mPhone}</td>
					<td style="font-size: 25px !important;"
						onclick="location.href='masterMemberSelect.do?id=${member.mEmail}' ">${member.mPost}</td>
					<td style="font-size: 25px !important;"
						onclick="location.href='masterMemberSelect.do?id=${member.mEmail}' ">${member.mAddress}</td>
					<td style="font-size: 25px !important;"
						onclick="location.href='masterMemberSelect.do?id=${member.mEmail}' ">${member.mGrade}</td>
					<td style="font-size: 25px !important;"
						onclick="location.href='masterMemberSelect.do?id=${member.mEmail}' ">${member.mReg}</td>
				</tr>
			</c:forEach>

		</table>
		<h4 class="info-message">클릭시 해당 회원으로 이동합니다.</h4>
	</div>
	<br>


</body>
</html>