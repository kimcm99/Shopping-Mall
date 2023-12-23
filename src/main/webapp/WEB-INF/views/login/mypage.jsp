<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>마이 페이지</title>
</head>

<script src="http://code.jquery.com/jquery-latest.js"></script>
<link rel="stylesheet" href="css/sidebar.css">
<!-- <link rel="stylesheet" href="css/mypage.css"> -->

<script>
	function mypageOrderDetail(oid){
		location.href = "mypageOrderDetail.do?oid=" + oid;
	}
</script>

<body>

	<%@ include file="/WEB-INF/views/common/header.jsp"%>
	<!-- 세션이 없을때 마이페이지 -->
	<c:if test="${member == null }">
		<script>
			alert("로그인이 되어 있지 않습니다.");
			location.href = "NaverLogin.do";
		</script>
	</c:if>


	<!-- 세션이 있을때 마이페이지 -->
	<c:if test="${member != null }">
		<ul>
			<li><a class="mypage_sidebar" href='#'>메뉴</a></li>
			<li><a href='mypage.do'>내 주문내역</a></li>
			<li><a href='cartFormMove.do'>장바구니</a></li>
			<li><a href='mypageQnA.do'>내가 쓴 QnA</a></li>
			<li><a href='mypageReview.do'>내가 쓴 Review</a></li>
			<li><a href='mypageAskBoard.do'>내가 물어본 상품문의</a></li>
			<li><a href='mypageReport.do'>신고 기록</a></li>
			<li><a href='updateForm.do'>내 정보 수정</a></li>
			<li><a href='deleteForm.do'>회원 탈퇴</a></li>
		</ul>

		<c:if test="${not empty orders}">
			<div class="content">
				<h1>내 주문 내역</h1>

				<div class="container_orders">
					<table border="1" class="ordertable">
						<tr>
							<th>주문번호</th>
							<th>주문 금액</th>
							<th>수령인 성함</th>
							<th>우편번호</th>
							<th>주소</th>
							<th>배송 메세지</th>
							<th>주문일</th>
						</tr>

							<c:forEach items="${orders}" var="order" varStatus="loop">
								<tr>
									<td onclick = "mypageOrderDetail(${order.oid})">${order.oid}</td>
									<td onclick = "mypageOrderDetail(${order.oid})">${order.ototalprice}</td>
									<td onclick = "mypageOrderDetail(${order.oid})">${order.oname}</td>
									<td onclick = "mypageOrderDetail(${order.oid})">${order.opost}</td>
									<td onclick = "mypageOrderDetail(${order.oid})">${order.oaddress}</td>
									<td onclick = "mypageOrderDetail(${order.oid})">${order.omessage}</td>
									<fmt:formatDate value="${order.oreg}"
										pattern="yyyy년 MM월 dd일" var="formattedDate" />
									<td onclick = "mypageOrderDetail(${order.oid})">${formattedDate}</td>
								</tr>
							</c:forEach>
					</table>
				</div>
			</div>
		</c:if>

		<c:if test="${empty orders}">
			<div class="content_noorderlist">
				<h1>주문한 내역이 없습니다.</h1>
			</div>
		</c:if>

	</c:if>
	<!-- 세션 확인 -->
</body>
<%@ include file="/WEB-INF/views/common/footer.jsp"%>
</html>