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
<title>Qna 관리</title>

<script>
	function selChange() {
		var sel = document.getElementById('cntPerPage').value;
		location.href = "masterQnaBoardList.do?nowPage=${page.nowPage}&cntPerPage="
				+ sel;
	}

	//    function selChange() {
	//       var sel = document.getElementById('cntPerPage').value;
	//       location.href = "masterMemberList.do?nowPage=${page.nowPage}&cntPerPage="
	//             + sel;
	//    }
</script>




</head>
<body>
	<%@ include file="../common/masterNav.jsp"%>
	<form method="post" action="masterQnaBoardDelete.do">
		<div class="container">
			<h1 class="h1_caption">Qna 관리</h1>
			<div style="float: right;">
				<select id="cntPerPage" name="sel" onchange="selChange()"
					class="selected-five">
					<option value="5"
						<c:if test="${page.cntPerPage == 5}">selected</c:if>>5줄
						보기</option>
					<option value="10"
						<c:if test="${page.cntPerPage == 10}">selected</c:if>>10줄
						보기</option>
					<option value="15"
						<c:if test="${page.cntPerPage == 15}">selected</c:if>>15줄
						보기</option>
					<option value="20"
						<c:if test="${page.cntPerPage == 20}">selected</c:if>>20줄
						보기</option>
				</select>
			</div>
			<!-- 옵션선택 끝 -->
			<table>
				<tr>
					<th><label><input type="checkbox"
							class="check-all-checkbox">글번호</label></th>
					<th>ID</th>
					<th>제목</th>
					<th>내용</th>
					<th>이미지</th>
					<th>작성일</th>
					<th>답변여부[Y/N]</th>
					<th>삭제여부[Y/N]</th>
					<th>관리</th>
				</tr>
				<c:set var="i" value="1"></c:set>
				<c:forEach var="qnaBoard" items="${list}" varStatus="loop">
					<tr>
						<td id="${i }"><label><input type="checkbox"
								name="chkId" value="${qnaBoard.qid }"> ${qnaBoard.qid }</label></td>
						<td
							onclick="location.href='masterQnaBoardDetail.do?qid=${qnaBoard.qid}&nowPage=${page.nowPage }&cntPerPage=${page.cntPerPage }' ">${qnaBoard.memail}</td>
						<td
							onclick="location.href='masterQnaBoardDetail.do?qid=${qnaBoard.qid}&nowPage=${page.nowPage }&cntPerPage=${page.cntPerPage }' ">${qnaBoard.qnatitle}</td>
						<td
							onclick="location.href='masterQnaBoardDetail.do?qid=${qnaBoard.qid}&nowPage=${page.nowPage }&cntPerPage=${page.cntPerPage }' ">${qnaBoard.qnacontent}</td>
						<td
							onclick="location.href='masterQnaBoardDetail.do?qid=${qnaBoard.qid}&nowPage=${page.nowPage }&cntPerPage=${page.cntPerPage }' ">
							<img src="images/${qnaBoard.qnaorifile}" width="50" height="50">

						</td>
						<td
							onclick="location.href='masterQnaBoardDetail.do?qid=${qnaBoard.qid}&nowPage=${page.nowPage }&cntPerPage=${page.cntPerPage }' "><fmt:formatDate
								pattern="yyyy-MM-dd" value="${qnaBoard.qnareg}" /></td>

						<c:if test="${qnaBoard.qnayn == 'Y'}">
							<td
								onclick="location.href='masterQnaBoardDetail.do?qid=${qnaBoard.qid}&nowPage=${page.nowPage }&cntPerPage=${page.cntPerPage }' "
								style="color: cyan;">${qnaBoard.qnayn}</td>
						</c:if>
						<c:if test="${qnaBoard.qnayn == 'N'}">
							<td
								onclick="location.href='masterQnaBoardDetail.do?qid=${qnaBoard.qid}&nowPage=${page.nowPage }&cntPerPage=${page.cntPerPage }' "
								style="color: red;">${qnaBoard.qnayn}</td>
						</c:if>
						<c:if test="${qnaBoard.qnadrop == 'Y'}">
							<td
								onclick="location.href='masterQnaBoardDetail.do?qid=${qnaBoard.qid}&nowPage=${page.nowPage }&cntPerPage=${page.cntPerPage }' "
								style="color: cyan;">${qnaBoard.qnadrop}</td>

							</td>
						</c:if>
						<c:if test="${qnaBoard.qnadrop == 'N'}">
							<td
								onclick="location.href='masterQnaBoardDetail.do?qid=${qnaBoard.qid}&nowPage=${page.nowPage }&cntPerPage=${page.cntPerPage }' "
								style="color: red;">${qnaBoard.qnadrop}</td>
						</c:if>

						<td><c:if test="${qnaBoard.qnayn == 'N'}">
								<button type="button"
									onclick="location.href='masterQnaBoardDetail.do?qid=${qnaBoard.qid}&nowPage=${page.nowPage }&cntPerPage=${page.cntPerPage }'">답변</button>
								<button type="button"
									onclick="location.href='masterQnaBoardDelete.do?id=${qnaBoard.qid}&nowPage=${page.nowPage }&cntPerPage=${page.cntPerPage }' ">삭제</button>
							</c:if> <c:if test="${qnaBoard.qnayn == 'Y'}">
								<button type="button"
									onclick="location.href='masterQnaBoardDetail.do?qid=${qnaBoard.qid}&nowPage=${page.nowPage }&cntPerPage=${page.cntPerPage }'">수정</button>
								<button type="button"
									onclick="location.href='masterQnaBoardDelete.do?id=${qnaBoard.qid}&nowPage=${page.nowPage }&cntPerPage=${page.cntPerPage }' ">삭제</button>
							</c:if></td>
					</tr>
					<c:set var="i" value="${i + 1}"></c:set>
				</c:forEach>
			</table>

			<button type="submit" align="left" class="putsub">삭제여부 수정</button>
			<div align="right" class="search">
	</form>
	<form action="masterQnaBoardSearch.do" method="post">
		<select class="putsub" name="searchtype">
			<option value="">검색 유형 선택</option>
			<option value="memail">ID</option>
			<option value="qid">글번호</option>
			<option value="qnatitle">글제목</option>
			<option value="qnayn">답변여부</option>
		</select> <input type="text" align="right" id="keyword" name="keyword"
			placeholder="검색어를 입력하세요." maxlength="10" class="text-input">
		<input type="submit" value="검색" class="putsub">
	</form>
	<c:if test="${search ne 'search' }">
		<div class="pageFont1">
			<c:if test="${page.startPage != 1 }">
				<a style="text-decoration: none; color: deeppink"
					href="./masterQnaBoardList.do?nowPage=${page.startPage - 1 }&cntPerPage=${page.cntPerPage}">
					< </a>
			</c:if>
			<c:forEach begin="${page.startPage }" end="${page.endPage }" var="p">
				<c:choose>
					<c:when test="${p == page.nowPage }">
						<b>${p }</b>
					</c:when>
					<c:when test="${p != page.nowPage }">
						<a style="text-decoration: none; color: deeppink"
							href="./masterQnaBoardList.do?nowPage=${p }&cntPerPage=${page.cntPerPage}">${p }</a>
					</c:when>
				</c:choose>
			</c:forEach>
			<c:if test="${page.endPage != page.lastPage}">
				<a style="text-decoration: none; color: deeppink"
					href="./masterQnaBoardList.do?nowPage=${page.endPage+1 }&cntPerPage=${page.cntPerPage}">
					> </a>
			</c:if>
		</div>
	</c:if>
	<c:if test="${search eq 'search' }" />
	<h4 class="info-message">클릭시 해당 회원으로 이동합니다.</h4>
	</div>

	<%@ include file="../../common/footer.jsp"%>
</body>
</html>