<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@page import="java.lang.Math"%>
<%@page import="java.lang.Integer"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지사항</title>
<!-- css 양식 include -->
<%@include file="/WEB-INF/views/common/header.jsp"%>
<!-- css 불러오기 -->
<link rel="stylesheet" href="css/productDetailReview.css">
<!-- css 불러오기 -->
<link rel="stylesheet" href="css/productDetail.css">
<!-- css 불러오기 -->
<link rel="stylesheet" href="css/freeBoardDetail.css">
<style type="text/css">

.qna_btn {
	background-color: black;
    color: white;
    padding: 10px;
    display: block;
    margin:0 auto;
    width: 150px; /* 버튼을 100%로 설정하여 테이블 셀과 일치시킵니다. */
    white-space: nowrap; /* 텍스트 줄 바꿈 방지 */
}

.qna_btn:hover{
	background-color: #ffffff;
	color: #000000;
}

</style>
</head>
<body>

	<div class="div_freeBoardDetail" align="center">
		<table class="table_freeBoardDetail">



		<tr>
			<th>작성일</th>
			<td style="color: black;"><fmt:formatDate
					pattern="yyyy-MM-dd hh:mm" value="${mnd.mnReg}" /></td>
			<th>조회수</th>
			<td style="color: black;">${mnd.mnReadCount }</td>
		</tr>
		<tr>
			<th>제목</th>
			<td colspan="3" style="color: black;">${mnd.mnTitle }</td>
		</tr>


		<tr>
			<td colspan="4" style="color: black;"><pre>${mnd.mnContent }</pre></td>
		</tr>

		<c:if test="${mnd.mnOriFile != null }">
			<td colspan="4"><img
				src="images/${mnd.mnOriFile}">
			</td>
		</c:if>

	</table>
	<div align="right">
	<c:if test="${mnd.rnum != 1 }">
			<a href="masterNoticeDetailMove.do?rnum=${mnd.rnum-1 }&cntPerPage=${pp.cntPerPage}">다음글</a>
	</c:if>
	<c:if test="${mnd.rnum != pp.total }">
			<a href="masterNoticeDetailMove.do?rnum=${mnd.rnum+1 }&cntPerPage=${pp.cntPerPage}">이전글</a>
	</c:if>
	</div>
		<button type="button" class="qna_btn"
			onclick="location.href='masterNotice.do?nowPage=${Integer.toString(Math.floor((mnd.rnum-1)/pp.cntPerPage)+1)}'">목록으로</button>
	</div>
</body>
</html>