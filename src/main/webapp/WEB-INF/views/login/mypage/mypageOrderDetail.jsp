<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>내 주문 내역</title>
</head>

<script src="http://code.jquery.com/jquery-latest.js"></script>
<link rel="stylesheet" href="css/sidebar.css">
<!-- <link rel="stylesheet" href="css/mypage.css"> -->

<script>
	function doDetailPage(pid){
		location.href = "productDetail.do?pid=" + pid;
	}
	
	function refund(odid,oid) {
		   var confirmDelete = confirm("환불 요청을 하시겠습니까?");
		  
		   if(confirmDelete){
			$.ajax({
		        type: "POST",
		        url: "refund.do",
		        data: { odid: odid },
		        success: function (response) {
		            if (response === "Y") {
		                alert("환불요청이 되었습니다.");
		                location.href = "mypageOrderDetail.do?oid="+ oid;
		            } else if (response === "A"){
		                alert("배송 완료된 상품에 대해서는 환불 요청을 할 수 없습니다.");
		                location.href = "mypageOrderDetail.do?oid="+ oid;
		            } else if(response === "R"){
		            	alert("이미 환불 요청을 처리중 입니다.");
		            	location.href = "mypageOrderDetail.do?oid="+ oid;
		            } else{
		            	alert("이미 환불 처리가 완료 되었습니다.");
		            	location.href = "mypageOrderDetail.do?oid="+ oid;
		            }
		        },
		        error: function () {
		            alert("서버 오류가 발생했습니다.");
		        }
		    });
		   }
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

		<c:if test="${not empty ordersList}">
			<div class="content">
				<h1>내 주문 내역</h1>

				<div class="container_orders">
					<table border="1" class="ordertable">
						<tr>
							<th>주문상세번호</th>
							<th>상품명</th>
							<th>상품 이미지</th>
							<th>주문 상품 수량</th>
							<th>상품 배송 상태</th>
							<th>주문일</th>
							<th>환불 요청</th>
						</tr>

							<c:forEach items="${ordersList}" var="order" varStatus="orderLoop">
								<tr>
									<td onclick = "doDetailPage(${order['PID']})">${order['ODID']}</td>
									<td onclick = "doDetailPage(${order['PID']})">${order.ODNAME}</td>
									<td style="position: relative;" onclick = "doDetailPage(${order['PID']})"><img
										src="./images/${order['ODIMAGE']}" width="50" height="50"
										class="toggle-image"> <span class="text-on-image">${o.PTEXT}</span>
									</td>
									<td onclick = "doDetailPage(${order['PID']})">${order['ODCOUNT']}</td>
									<td onclick = "doDetailPage(${order['PID']})">${statusMsg[orderLoop.index]}</td>
									<fmt:formatDate value="${order['OREG']}"
										pattern="yyyy년 MM월 dd일" var="formattedDate" />
									<td onclick = "doDetailPage(${order['PID']})">${formattedDate}</td>
									<td><button class="refund_btn"
											onclick="refund(${order['ODID']},${order['OID']})">환불요청</button></td>
								</tr>
							</c:forEach>
					</table>
				</div>
			</div>
		</c:if>

		<c:if test="${empty ordersList}">
			<div class="content_noorderlist">
				<h1>주문한 내역이 없습니다.</h1>
			</div>
		</c:if>

	</c:if>
	<!-- 세션 확인 -->
</body>
<%@ include file="/WEB-INF/views/common/footer.jsp"%>
</html>