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
<title>리 뷰 관 리</title>

<script>
	function selChange() {
		var sel = document.getElementById('cntPerPage').value;
		location.href = "masterReviewList.do?nowPage=${pp.nowPage}&cntPerPage="
				+ sel;
	}
</script>




</head>
<body>
	<%@ include file="../common/masterNav.jsp"%>
	<form method="post" action="masterReviewDelete.do">
		<div class="container">

			<h1 class="h1_caption">리 뷰 관 리</h1>


			<div style="float: right;">
				<select id="cntPerPage" name="sel" onchange="selChange()"
					class="selected-five">
					<option value="5"
						<c:if test="${pp.cntPerPage == 5}">selected</c:if>>5줄 보기</option>
					<option value="10"
						<c:if test="${pp.cntPerPage == 10}">selected</c:if>>10줄
						보기</option>
					<option value="15"
						<c:if test="${pp.cntPerPage == 15}">selected</c:if>>15줄
						보기</option>
					<option value="20"
						<c:if test="${pp.cntPerPage == 20}">selected</c:if>>20줄
						보기</option>
				</select>
			</div>
			<!-- 옵션선택 끝 -->
			<table>
				<tr>
					<th><label><input type="checkbox"
							class="check-all-checkbox">글번호</label></th>
					<th>상품번호</th>
					<th>ID</th>
					<th>작성자</th>
					<th>제목</th>
					<th>내용</th>
					<th>이미지</th>
					<th>작성일</th>
					<th>조회수</th>
					<th>삭제여부</th>
					<th>관리</th>
				</tr>
				<c:set var="i" value="1"></c:set>
				<c:forEach var="review" items="${list}" varStatus="loop">
					<tr>
						<td id="${i }"><label><input type="checkbox"
								name="chkId" value="${review.rid }"> ${review.rid }</label></td>
						<td
							onclick="location.href='masterReviewSelect.do?rid=${review.rid}' ">${review.pid}</td>
						<td
							onclick="location.href='masterReviewSelect.do?rid=${review.rid}' ">${review.memail}</td>

						<td
							onclick="location.href='masterReviewSelect.do?rid=${review.rid}' ">${review.rwriter}</td>
						<td
							onclick="location.href='masterReviewSelect.do?rid=${review.rid}' ">${review.rtitle}</td>
						<td><input type="text" value="${review.rcontent}"
							readonly="readonly"></td>
						<c:if test="${review.rimage ne null }">
							<td
								onclick="location.href='masterReviewSelect.do?rid=${review.rid}' ">
								<img src="images/${review.rimage}" width="50" height="50">
						</c:if>
						<c:if test="${review.rimage eq null }">
							<td
								onclick="location.href='masterReviewSelect.do?rid=${review.rid}' ">
								X
						</c:if>
						<td
							onclick="location.href='masterReviewSelect.do?rid=${review.rid}' ">${review.rreg}</td>
						<td
							onclick="location.href='masterReviewSelect.do?rid=${review.rid}' ">${review.rreadcount}</td>
						<c:if test="${review.rdrop == 'N'}">
							<td
								onclick="location.href='masterReviewSelect.do?rid=${review.rid}' "
								style="color: red;">${review.rdrop}</td>
						</c:if>

						<c:if test="${review.rdrop == 'Y'}">
							<td
								onclick="location.href='masterReviewSelect.do?rid=${review.rid}' "
								style="color: cyan;">${review.rdrop}</td>
						</c:if>

						<td>
							<button type="button"
								onclick="location.href='masterReviewDelete.do?rid=${review.rid}' ">삭제</button>
						</td>
					</tr>
					<c:set var="i" value="${i + 1}"></c:set>
				</c:forEach>
			</table>

			<button type="submit" align="left" class="putsub">삭제여부 수정</button>
			<div align="right" class="search">
	</form>
	<form action="masterReviewSearch.do" method="post">
		<select class="putsub" name="searchtype">
			<option value="">검색 유형 선택</option>
			<option value="memail">ID</option>
			<option value="rwriter">작성자</option>
			<option value="rid">글번호</option>
			<option value="pid">상품번호</option>
		</select> <input type="text" align="right" id="keyword" name="keyword"
			placeholder="검색어를 입력하세요." maxlength="10" class="text-input">
		<input type="submit" value="검색" class="putsub">
	</form>
	<c:if test="${search ne 'search' }">
		<div class="pageFont1">
			<c:if test="${pp.startPage != 1 }">
				<a style="text-decoration: none; color: deeppink"
					href="./masterReviewList.do?nowPage=${pp.startPage - 1 }&cntPerPage=${pp.cntPerPage}">
					< </a>
			</c:if>
			<c:forEach begin="${pp.startPage }" end="${pp.endPage }" var="p">
				<c:choose>
					<c:when test="${p == pp.nowPage }">
						<b>${p }</b>
					</c:when>
					<c:when test="${p != pp.nowPage }">
						<a style="text-decoration: none; color: deeppink"
							href="./masterReviewList.do?nowPage=${p }&cntPerPage=${pp.cntPerPage}">${p }</a>
					</c:when>
				</c:choose>
			</c:forEach>
			<c:if test="${pp.endPage != pp.lastPage}">
				<a style="text-decoration: none; color: deeppink"
					href="./masterReviewList.do?nowPage=${pp.endPage+1 }&cntPerPage=${pp.cntPerPage}">
					> </a>
			</c:if>
		</div>
	</c:if>
	<c:if test="${search eq 'search' }" />
	<h4 class="info-message">클릭시 해당 리뷰로 이동합니다.</h4>
	<h4 class="info-message">마우스 드래그로 대략적인 내용을 볼 수 있습니다.</h4>
	<h4 class="info-message">회원의 리뷰는 수정할 수 없습니다.</h4>
	</div>
</body>
</html>