<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>신고작성 폼</title>
<script src="http://code.jquery.com/jquery-latest.js"></script>
<link rel="stylesheet" href="css/report.css">
<script src="./js/report.js"></script>





</head>
<body>
	<c:set var="now" value="<%=new java.util.Date()%>" />

	<fmt:formatDate var="date" value="${now}" type="date"
		pattern="yyyy-MM-dd" />
	<form method="post" action="reportWrite.do"
		enctype="multipart/form-data">
		<input type="hidden" name="pid" value="${pid }">
		<div class="container_main">
			<h1>신고 작성 게시판</h1>
			<table class="table_main" border="1">
				<tr>
					<th>피신고자</th>
					<td colspan="2"><input type="text" id="reportname"
						name="reportname" value="${report.reportname }"
						Style="color: deeppink;" placeholder="신고할 ID를 입력하세요."
						readonly="readonly"></td>
					<th>신고유형</th>
					<c:if test="${report.reporttype eq 'review'}">
						<td colspan="1"><input type="text" id="reporttype"
							name="reporttype" value="${report.reporttype }"
							readonly="readonly" size="20px"></td>
						<th>글번호</th>
						<td colspan="1"><input type="text" id="reportnum"
							name="reportnum" value="${report.reportnum }" readonly="readonly"></td>
					</c:if>
					<c:if test="${report.reporttype eq 'freeBoard'}">
						<td colspan="1"><input type="text" id="reporttype"
							name="reporttype" value="${report.reporttype }"
							readonly="readonly"></td>
						<th>글번호</th>
						<td colspan="1"><input type="text" id="reportnum"
							name="reportnum" value="${report.reportnum }" readonly="readonly"></td>
					</c:if>
				</tr>
				<tr>
					<th>제목</th>
					<td colspan="4"><input type="text" id="reporttitle"
						name="reporttitle" placeholder="제목을 입력하세요." width=""></td>


					<th>작성일</th>
					<td colspan="2"><input readonly="readonly" type="text"
						value="${date }"></td>
				</tr>
				<tr>
					<th>내용</th>
					<td colspan="6"><textarea id="reportcontent"
							name="reportcontent" cols="40" rows="10" placeholder="내용을 입력하세요."></textarea></td>
				</tr>
				<tr>
					<th>이미지</th>
					<td colspan="6"><input type="file" name="image1"></td>
				</tr>
				<tr>
					<th>신고자</th>
					<td colspan="6"><input type="text" Style="color: skyblue;"
						name="memail" value="${member.mEmail }" readonly="readonly"></td>
				</tr>
			</table>
			<div class="button_row">
				<button type="submit" id="report">신고</button>
				<button type="reset">취소</button>
				<button type="button" id="main">메인</button>
			</div>
		</div>
	</form>
</body>
</html>






