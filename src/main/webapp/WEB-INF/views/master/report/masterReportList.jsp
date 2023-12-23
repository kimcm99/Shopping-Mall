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
<title>신고 관리</title>

<script>
	function selChange() {
		var sel = document.getElementById('cntPerPage').value;
		location.href = "masterReportList.do?nowPage=${page.nowPage}&cntPerPage="
				+ sel;
	}
</script>




</head>
<body>
	<%@ include file="../common/masterNav.jsp"%>
	<form method="post" action="masterReportDelete.do">
		<div class="container">
			<h1 class="h1_caption">신고 관리</h1>
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
							class="check-all-checkbox">RID</label></th>
					<th>신고유형</th>
					<th>신고글번호</th>
					<th>피신고자</th>
					<th>신고자</th>
					<th>제목</th>
					<th>내용</th>
					<th>이미지</th>
					<th>신고작성일</th>
					<th>답변</th>
					<th>답변일</th>
					<th>답변여부</th>
					<th>삭제여부</th>
					<th>관리</th>
				</tr>

				<c:set var="i" value="1"></c:set>
				<c:forEach var="Report" items="${list}" varStatus="loop">
					<tr>
						<td id="${i }"><label><input type="checkbox"
								name="chkId" value="${Report.reportid}">
								${Report.reportid }</label></td>
						<!-- 신고가 리뷰일때 해당글 조회  -->
						<c:if test="${Report.reporttype eq 'review'}">
							<td
								onclick="location.href='masterReviewSelect.do?rid=${Report.reportnum}' ">${Report.reporttype}</td>
							<td
								onclick="location.href='masterReviewSelect.do?rid=${Report.reportnum}' ">${Report.reportnum}</td>
						</c:if>
						<!-- 신고가 자유게시판일때 해당글 조회 -->
						<c:if test="${Report.reporttype eq 'freeBoard'}">
							<td>${Report.reporttype}</td>
							<td>${Report.reportnum}</td>
						</c:if>


						<td style="color: deeppink;"
							onclick="location.href='masterMemberSelect.do?id=${Report.reportname}&nowPage=${page.nowPage }&cntPerPage=${page.cntPerPage }' ">${Report.reportname}</td>
						<td style="color: DodgerBlue;"
							onclick="location.href='masterMemberSelect.do?id=${Report.memail}&nowPage=${page.nowPage }&cntPerPage=${page.cntPerPage }' ">${Report.memail}</td>
						<td><input type="text" readonly="readonly" maxlength="10"
							value="${Report.reporttitle}"></td>
						<td><input type="text" maxlength="10" readonly="readonly"
							value="${Report.reportcontent}"></td>
						<c:if test="${Report.reportimage ne null}">
							<td
								onclick="location.href='masterReportSelect.do?reportid=${Report.reportid}&nowPage=${page.nowPage }&cntPerPage=${page.cntPerPage }' ">
								<img src="images/${Report.reportimage}" width="50"
								height="50">
							</td>
						</c:if>
						<c:if test="${Report.reportimage eq null}">
							<td
								onclick="location.href='masterReportSelect.do?reportid=${Report.reportid}&nowPage=${page.nowPage }&cntPerPage=${page.cntPerPage }' ">
								<label>X</label>
							</td>
						</c:if>
						<td
							onclick="location.href='masterReportSelect.do?reportid=${Report.reportid}&nowPage=${page.nowPage }&cntPerPage=${page.cntPerPage }' "><fmt:formatDate
								pattern="yyyy-MM-dd" value="${Report.reportreg}" /></td>


						<td><input type="text" maxlength="10"
							value="${Report.reportreply}"></td>
						<td
							onclick="location.href='masterReportSelect.do?reportid=${Report.reportid}&nowPage=${page.nowPage }&cntPerPage=${page.cntPerPage }' ">${Report.reportreplyreg}</td>
						<c:if test="${Report.reportanswer == 'Y'}">
							<td
								onclick="location.href='masterReportSelect.do?reportid=${Report.reportid}&nowPage=${page.nowPage }&cntPerPage=${page.cntPerPage }' "
								style="color: cyan;">${Report.reportanswer}</td>
						</c:if>
						<c:if test="${Report.reportanswer == 'N'}">
							<td
								onclick="location.href='masterReportSelect.do?reportid=${Report.reportid}&nowPage=${page.nowPage }&cntPerPage=${page.cntPerPage }' "
								style="color: red;">${Report.reportanswer}</td>
						</c:if>
						<c:if test="${Report.reportdrop == 'Y'}">
							<td
								onclick="location.href='masterReportSelect.do?reportid=${Report.reportid}&nowPage=${page.nowPage }&cntPerPage=${page.cntPerPage }' "
								style="color: cyan;">${Report.reportdrop}</td>
						</c:if>
						<c:if test="${Report.reportdrop == 'N'}">
							<td
								onclick="location.href='masterReportSelect.do?reportid=${Report.reportid}&nowPage=${page.nowPage }&cntPerPage=${page.cntPerPage }' "
								style="color: red;">${Report.reportdrop}</td>
						</c:if>
						<td><c:if test="${Report.reportdrop == 'N'}">
								<button type="button"
									onclick="location.href='masterReportSelect.do?reportid=${Report.reportid}&nowPage=${page.nowPage }&cntPerPage=${page.cntPerPage }'">답변</button>
								<button type="button"
									onclick="location.href='masterReportDelete.do?reportid=${Report.reportid}&nowPage=${page.nowPage }&cntPerPage=${page.cntPerPage }' ">삭제</button>
							</c:if> <c:if test="${Report.reportdrop == 'Y'}">
								<button type="button"
									onclick="location.href='masterReportSelect.do?reportid=${Report.reportid}&nowPage=${page.nowPage }&cntPerPage=${page.cntPerPage }'">답변</button>
								<button type="button"
									onclick="location.href='masterReportDelete.do?reportid=${Report.reportid}&nowPage=${page.nowPage }&cntPerPage=${page.cntPerPage }' ">삭제</button>
							</c:if></td>
					</tr>
					<c:set var="i" value="${i + 1}"></c:set>
				</c:forEach>
			</table>

			<button type="submit" align="left" class="putsub">삭제여부 수정</button>
			<div align="right" class="search">
	</form>
	<form action="masterReportSearch.do" method="post">
		<select class="putsub" name="searchtype">
			<option value="">검색 유형 선택</option>
			<option value="memail">ID</option>
			<option value="reportid">글번호</option>
			<option value="reporttitle">글제목</option>
			<option value="reportanswer">답변여부</option>
			<option value="reportdrop">삭제여부</option>
			<option value="reporttype">신고유형</option>
		</select> <input type="text" align="right" id="keyword" name="keyword"
			placeholder="검색어를 입력하세요." maxlength="10" class="text-input">
		<input type="submit" value="검색" class="putsub">
	</form>
	<c:if test="${search ne 'search' }">
		<div class="pageFont1">
			<c:if test="${pp.startPage != 1 }">
				<a style="text-decoration: none; color: deeppink"
					href="./masterReportList.do?nowPage=${pp.startPage - 1 }&cntPerPage=${pp.cntPerPage}">
					< </a>
			</c:if>
			<c:forEach begin="${pp.startPage }" end="${pp.endPage }" var="p">
				<c:choose>
					<c:when test="${p == pp.nowPage }">
						<b>${p }</b>
					</c:when>
					<c:when test="${p != pp.nowPage }">
						<a style="text-decoration: none; color: deeppink"
							href="./masterReportList.do?nowPage=${p }&cntPerPage=${pp.cntPerPage}">${p }</a>
					</c:when>
				</c:choose>
			</c:forEach>
			<c:if test="${pp.endPage != pp.lastPage}">
				<a style="text-decoration: none; color: deeppink"
					href="./masterReportList.do?nowPage=${pp.endPage+1 }&cntPerPage=${pp.cntPerPage}">
					> </a>
			</c:if>
		</div>
	</c:if>
	<c:if test="${search eq 'search' }" />
	<h4 class="info-message">목록 클릭시 해당 신고글로 이동합니다.</h4>
	<h4 class="info-message">신고유형 클릭시 문제 글로 이동합니다.</h4>
	<h4 class="info-message">마우스 드래그로 대략적인 내용을 볼 수 있습니다.</h4>
	</div>

</body>
</html>