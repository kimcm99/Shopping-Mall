<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품 문</title>

<link rel="stylesheet" href="css/sidebar.css">
<script src="http://code.jquery.com/jquery-latest.js"></script>
<script>
	function doDetailPage(pid){
		location.href = "productDetail.do?pid=" + pid;
	}
	
	function deleteReview(rid) {
	   var confirmDelete = confirm("진짜 삭제하시겠습니까?");
	   if(confirmDelete){
		   
		$.ajax({
	        type: "POST",
	        url: "mypageDeleteReview.do",
	        data: { rid: rid },
	        success: function (response) {
	            if (response === "Y") {
	                alert("리뷰가 삭제 되었습니다.");
	                location.href = "mypageReview.do";
	            } else {
	                alert("리뷰 삭제에 실패했습니다.");
	                history.go(-1);
	            }
	        },
	        error: function () {
	            alert("서버 오류가 발생했습니다.");
	        }
	    });
	   }
	}
</script>

</head>
<body>
	<%@ include file="/WEB-INF/views/common/header.jsp"%>

	<!-- 세션이 없을때 마이페이지 -->
	<c:if test="${member == null }">
		<script>
			alert("로그인이 되어 있지 않습니다.");
			location.href = "NaverLogin.do";
		</script>
	</c:if>

	<c:if test="${member != null }">
		<div class="main_container">
			<div class="nav1">
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
			</div>
			<c:if test="${not empty plist}">
				<div class="content">
					<h1>상품문의</h1>
					<div class="container_review">
						<table border="1" class="reviewtable">
							<tr>
								<th>상품명</th>
								<th>이미지</th>
								<th>내용</th>
								<th>작성일</th>
							</tr>

							<c:forEach items="${plist }" varStatus="loop" var="askproduct">
								<tr>
									<td onclick="doDetailPage(${askproduct.PID})">${askproduct.PNAME }</td>
									<c:if test="${not empty askproduct.PIMAGE }">
										<td style="position: relative;"
											onclick="doDetailPage(${askproduct.PID})"><img
											src="./images/${askproduct.PIMAGE }" width="50" height="50"
											class="toggle-image"> <span class="text-on-image">${o.PTEXT}</span>
										</td>
									</c:if>
									<c:if test="${empty askproduct.PIMAGE }">
										<td> x <td>
									</c:if>
									<td onclick="doDetailPage(${askproduct.PID})">${askproduct.ASKCONTENT }</td>
									<fmt:formatDate value="${askproduct.ASKREG }"
										pattern="yyyy년 MM월 dd일" var="formattedDate" />
									<td onclick="doDetailPage(${askproduct.PID})">${formattedDate}</td>
								</tr>
							</c:forEach>
						</table>
					</div>
					<!-- container_review end -->
				</div>

			</c:if>
		</div>
		
		<c:if test="${empty plist}">
			<div class="content_noask">
				<h1>작성한 ask문 없습니다.</h1>
			</div>
		</c:if>
	</c:if>
	<!-- 멤버 세션 조건문 -->
</body>
<%@ include file="/WEB-INF/views/common/footer.jsp"%>
</html>