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
<title>회 원 관 리</title>

<script>
	function selChange() {
		var sel = document.getElementById('cntPerPage').value;
		location.href = "masterMemberList.do?nowPage=${pp.nowPage}&cntPerPage="
				+ sel;
	}
</script>
</head>
<body>
	<%@ include file="../common/masterNav.jsp"%>
	<form method="post" action="masterMemberDelete.do">
		<div class="container">
			<h1 class="h1_caption">회 원 관 리</h1>
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
							class="check-all-checkbox">전체선택</label></th>
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
				<c:set var="i" value="1"></c:set>
				<c:forEach var="member" items="${list}" varStatus="loop">
					<tr>
						<td id="${i }"><label><input type="checkbox"
								name="chkId" value="${member.mEmail }"> ${i }. 번회원</label></td>
						<td
							onclick="location.href='masterMemberSelect.do?id=${member.mEmail}' ">${member.mEmail}</td>
						<td id="${member.mEmail }"
							onclick="location.href='masterMemberSelect.do?id=${member.mEmail}' ">${member.mName}</td>
						<td
							onclick="location.href='masterMemberSelect.do?id=${member.mEmail}' ">${member.mPhone}</td>
						<td
							onclick="location.href='masterMemberSelect.do?id=${member.mEmail}' ">${member.mPost}</td>
						<td
							onclick="location.href='masterMemberSelect.do?id=${member.mEmail}' ">${member.mAddress}</td>
						<td
							onclick="location.href='masterMemberSelect.do?id=${member.mEmail}' ">${member.mGrade}</td>
						<td
							onclick="location.href='masterMemberSelect.do?id=${member.mEmail}' ">${member.mReg}</td>
						<c:if test="${member.mDrop == 'N'}">
							<td
								onclick="location.href='masterMemberSelect.do?id=${member.mEmail}' "
								style="color: red;">${member.mDrop}</td>
						</c:if>

						<c:if test="${member.mDrop == 'Y'}">
							<td
								onclick="location.href='masterMemberSelect.do?id=${member.mEmail}' "
								style="color: cyan;">${member.mDrop}</td>
						</c:if>

						<td>
							<button type="button"
								onclick="location.href='masterMemberUpdateForm.do?id=${member.mEmail}'">수정</button>
							<button type="button"
								onclick="location.href='masterMemberDelete.do?id=${member.mEmail}' ">삭제</button>
						</td>
					</tr>
					<c:set var="i" value="${i + 1}"></c:set>
				</c:forEach>
			</table>

			<button type="submit" align="left" class="putsub">삭제여부 수정</button>
			<div align="right" class="search">
	</form>
	<form action="masterMemberSearch.do" method="post">
		<select class="putsub" name="searchtype">
			<option value="">검색 유형 선택</option>
			<option value="mEmail">ID</option>
			<option value="mName">이름</option>
			<option value="mAddress">주소</option>
			<option value="mGrade">회원등급</option>
		</select> <input type="text" align="right" id="keyword" name="keyword"
			placeholder="검색어를 입력하세요." maxlength="10" class="text-input">
		<input type="submit" value="검색" class="putsub">
	</form>
	<c:if test="${search ne 'search'}">
		<div class="pageFont1">
			<c:if test="${pp.startPage != 1 }">
				<a style="text-decoration: none; color: deeppink"
					href="./masterMemberList.do?nowPage=${pp.startPage - 1 }&cntPerPage=${pp.cntPerPage}">
					< </a>
			</c:if>
			<c:forEach begin="${pp.startPage }" end="${pp.endPage }" var="p">
				<c:choose>
					<c:when test="${p == pp.nowPage }">
						<b>${p }</b>
					</c:when>
					<c:when test="${p != pp.nowPage }">
						<a style="text-decoration: none; color: deeppink"
							href="./masterMemberList.do?nowPage=${p }&cntPerPage=${pp.cntPerPage}">${p }</a>
					</c:when>
				</c:choose>
			</c:forEach>
			<c:if test="${pp.endPage != pp.lastPage}">
				<a style="text-decoration: none; color: deeppink"
					href="./masterMemberList.do?nowPage=${pp.endPage+1 }&cntPerPage=${pp.cntPerPage}">
					> </a>
			</c:if>
		</div>
	</c:if>
	<c:if test="${search eq 'search'}">
	</c:if>
	<h4 class="info-message">클릭시 해당 회원으로 이동합니다.</h4>
	</div>
</body>
</html>