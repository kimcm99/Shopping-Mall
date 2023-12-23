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
<title>신고 상세정보</title>


</head>
<body>
	<c:set var="now" value="<%=new java.util.Date()%>" />
	<fmt:formatDate var="reportreplyreg" value="${now}" type="date"
		pattern="yyyy-MM-dd" />
	<%@ include file="../common/masterNav.jsp"%>
	<form method="post" action="masterReportAnswerInsert.do">
		<input type="hidden" name="memail" value="${Report.memail  }">
		<input type="hidden" name="reportid" value="${Report.reportid }">

		<div class="container">
			<h1 class="h1_caption">신고 상세정보</h1>

			<table>
				<tr>
					<th>신고번호</th>
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

				<tr>
					<td>${Report.reportid}</td>
					<td style="color: deeppink;"
						onclick="location.href='masterMemberSelect.do?id=${Report.reportname}' ">${Report.reportname}</td>

					<td style="color: DodgerBlue;"
						onclick="location.href='masterMemberSelect.do?id=${Report.memail}' ">${Report.memail}</td>
					<td><input type="text" value="${Report.reporttitle}">
					</td>
					<td><input type="text" value="${Report.reportcontent}"
						readonly="readonly" maxlength="10"></td>
					<td><img src="images/${Report.reportimage}" width="50"
						height="50">
					<td><input type="text" value="${Report.reportreg}"
						maxlength="10" readonly="readonly"></td>
					<td><input type="text" value="${Report.reportreply}"
						maxlength="10" readonly="readonly"></td>
					<td>${Report.reportreplyreg}</td>
					<td>${Report.reportanswer}</td>
					<td>${Report.reportdrop}</td>
					<td>
						<button type="button"
							onclick="location.href='masterReportDelete.do?id=${Report.reportid}' ">삭제</button>
					</td>
				</tr>
			</table>
			<table class="fancy_table">
				<tr align="left">
					<th>피신고자</th>
					<td colspan="2" style="color: deeppink;"
						onclick="location.href='masterMemberSelect.do?id=${Report.reportname}' ">${Report.reportname}</td>
					<c:if test="${Report.reporttype eq 'review' }">
						<th
							onclick="location.href='masterReviewSelect.do?rid=${Report.reportnum}' ">신고유형</th>
						<td
							onclick="location.href='masterReviewSelect.do?rid=${Report.reportnum}' ">${Report.reporttype }</td>
						<th
							onclick="location.href='masterReviewSelect.do?rid=${Report.reportnum}' ">글번호</th>
						<td
							onclick="location.href='masterReviewSelect.do?rid=${Report.reportnum}' ">${Report.reportnum }</td>
					</c:if>
					<c:if test="${Report.reporttype eq 'freeBoard' }">
						<th>신고유형</th>
						<td>${Report.reporttype }</td>
						<th>글번호</th>
						<td>${Report.reportnum }</td>
					</c:if>
				</tr>
				<tr>
					<th>제목</th>
					<td colspan="4" Style="text-align: left;">&nbsp;&nbsp;&nbsp;${Report.reporttitle }</td>


					<th>작성일</th>
					<td>${Report.reportreg }</td>
				</tr>
				<tr>
					<th>이미지</th>
					<c:if test="${Report.reportimage ne null }">
						<td colspan="6"><img
							src="images/${Report.reportimage }" width="65%"
							height="400px"></td>
					</c:if>
					<c:if test="${Report.reportimage eq null }">
						<td colspan="6"><label>등록된 이미지가 없습니다.</label></td>
					</c:if>
				</tr>

				<tr>
					<th>내용</th>
					<td colspan="6"><textarea name="reportcontent" cols="40"
							rows="3" readonly="readonly">${Report.reportcontent }</textarea></td>
				<tr>
					<th>신고자명</th>
					<td style="color: DodgerBlue;"
						onclick="location.href='masterMemberSelect.do?id=${Report.memail}' ">${Report.memail}</td>
				</tr>
			</table>
	</form>

	<form method="post" action="masterReportAnswerInsert.do">
		<input type="hidden" name="reportid" value="${Report.reportid}">
		<input type="hidden" name="reportreplyreg" value="${reportreplyreg}">
		<table class="fancy_table">
			<tr>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
			</tr>
			<tr>
				<th>답변내용</th>
				<c:if test="${Report.reportreply ne null }">
					<td colspan="4"><textarea cols="40"
							placeholder="답변할 내용을 입력하세요." name="reportreply"> ${Report.reportreply }</textarea></td>
				</c:if>
				<c:if test="${Report.reportreply eq null }">
					<td colspan="4"><textarea cols="40" autofocus="autofocus"
							placeholder="답변할 내용을 입력하세요." name="reportreply"></textarea></td>
				</c:if>
			</tr>
		</table>
		<c:if test="${Report.reportreply ne null }">
			<button type="submit">수정하기</button>
		</c:if>
		<c:if test="${Report.reportreply eq null }">
			<button type="submit">답변하기</button>
		</c:if>
		<h4 class=info-message>피신고자를 클릭하여 회원삭제를 할 수 있습니다.</h4>
		<h4 class=info-message>신고유형 및 글번호를 클릭하여 문제글을 확인할 수 있습니다.</h4>
		<h4 class=info-message>등록된 답변은 수정할 수 없습니다.</h4>
	</form>
	</div>
</body>
</html>