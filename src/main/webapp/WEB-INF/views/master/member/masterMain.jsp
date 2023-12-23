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

<title>관리자 페이지</title>
<!-- css 양식 include -->
</head>
<body>
	<%@ include file="../common/masterNav.jsp"%>
	<h1 class="h1_caption">관리자 페이지</h1>
	<div class="container_2" style="margin-top: 100px">

		<table
			style="width: 75%; height: 450px; margin-left: 150px; font-size: 25px;">
			<tr>
				<th><button type="button"
						onclick="location.href='masterMemberList.do' ">회원관리</button></th>
				<td onclick="location.href='masterMemberList.do' ">회원 전체목록과
					회원정보 수정을 관리합니다.</td>
			</tr>
			<tr>
				<th><button type="button"
						onclick="location.href='masterProductList.do' ">상품관리</button></th>
				<td onclick="location.href='masterProductList.do' ">상품 전체목록과
					상품추가 및 수정을 관리합니다.</td>
			</tr>
			<tr>
				<th><button type="button"
						onclick="location.href='masterQnaBoardList.do' ">Q&A관리</button></th>
				<td onclick="location.href='masterQnaBoardList.do' ">Q&A 전체목록과
					QnA답변 및 삭제를 관리합니다.</td>
			</tr>
			<tr>
				<th><button type="button"
						onclick="location.href='masterReportList.do' ">신고관리</button></th>
				<td onclick="location.href='masterReportList.do' ">신고 전체목록과
					신고답변 및 삭제를 관리합니다.</td>
			</tr>
			<tr>
				<th><button type="button"
						onclick="location.href='masterReviewList.do' ">리뷰관리</button></th>
				<td onclick="location.href='masterReviewList.do' ">리뷰 전체목록과 리뷰
					삭제를 관리합니다.</td>
			</tr>
			<tr>
				<th><button type="button"
						onclick="location.href='masterOrdersList.do' ">주문관리</button></th>
				<td onclick="location.href='masterOrdersList.do' ">주문 전체목록과
					배송상태 변경 및 배송메시지 전송을 관리합니다.</td>
			</tr>
		</table>
	</div>
</body>
</html>