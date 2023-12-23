<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>내가 쓴 리뷰</title>

<link rel="stylesheet" href="css/sidebar.css">
<script src="http://code.jquery.com/jquery-latest.js"></script>

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
			<div class="content">
				<h1>신고 기록</h1>
				<div class="container_review">
					<table border="1" class="reviewtable">
						<tr>
							<th>신고 번호</th>
							<th>피신고자</th>
							<th>신고자</th>
							<th>제목</th>
							<th>내용</th>
							<th>신고 게시판</th>
							<th>신고작성일</th>
						</tr>

						<tr>
							<td onclick="doDetailPage(${report.reportid}})">${report.reportid }</td>
							<td onclick="doDetailPage(${report.reportid}})">${report.reportname }</td>
							<td onclick="doDetailPage(${report.reportid})">${report.memail }</td>
							<td onclick="doDetailPage(${report.reportid})">${report.reporttitle}</td>
							<td onclick="doDetailPage(${report.reportid})">${report.reportcontent}</td>
							<td onclick="doDetailPage(${report.reportid})">${report.reporttype}</td>
							<fmt:formatDate value="${report.reportreg }"
								pattern="yyyy년 MM월 dd일" var="formattedDate" />
							<td onclick="doDetailPage(${report.reportid})">${formattedDate}</td>
						</tr>
					</table>
					
					<h1>신고 이미지</h1>
					<table class="reviewtable">
						<tr>
							<c:if test="${not empty report.reportimage }">
								<td style="position: relative;"
									onclick="doDetailPage(${report.reportid})"><img
									src="./images/${report.reportimage }" width="500px" height="300px"
									class="toggle-image"> <span class="text-on-image">${o.PTEXT}</span>
								</td>
							</c:if>
							<c:if test="${empty report.reportimage }">
								<h3 style="margin-left: 70px;"> 이미지가 없습니다 </h3>
							</c:if>
						</tr>
					</table>

					<h1>답변</h1>
					<table border="1" class="reviewtable">
						<c:if test="${!empty report.reportreply }">
							<tr>
								<th>관리자의 답변</th>
								<td>${report.reportreply }</td>
							</tr>

							<tr>
								<th>답변 날짜</th>
								<td>${report.reportreplyreg }</td>
							</tr>
						</c:if>

						<c:if test="${empty report.reportreply }">
							<div class="content_noreview">
								<h1>답변이 없습니다.</h1>
							</div>
						</c:if>

					</table>

				</div>
				<!-- container_review end -->
			</div>
		</div>
	</c:if>
	<!-- 멤버 세션 조건문 -->
	<%@ include file="/WEB-INF/views/common/footer.jsp"%>
</body>
</html>